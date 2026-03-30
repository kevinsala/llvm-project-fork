#include "PluginInterface.h"

#include "Shared/APITypes.h"

#include "ErrorReporting.h"
#include "Shared/Utils.h"

#include "llvm/Support/Error.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

#include <cstdint>
#include <filesystem>
#include <functional>

using namespace llvm;
using namespace omp;
using namespace target;
using namespace plugin;
using namespace error;

Error NativeRecordReplayTy::recordImage(const GenericKernelTy &Kernel,
                                        StringRef Filename) {
  std::error_code EC;
  raw_fd_ostream OS(Filename, EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "saving image");
  OS << Kernel.getImage().getMemoryBuffer().getBuffer();
  OS.close();
  return Plugin::success();
}

Error NativeRecordReplayTy::recordGlobals(StringRef Filename) {
  int32_t Size = 0;

  for (auto &OffloadEntry : GlobalEntries) {
    if (!OffloadEntry.Size)
      continue;
    // Get the total size of the string and entry including the null byte.
    Size +=
        OffloadEntry.Name.length() + 1 + sizeof(uint32_t) + OffloadEntry.Size;
  }

  ErrorOr<std::unique_ptr<WritableMemoryBuffer>> GlobalsMB =
      WritableMemoryBuffer::getNewUninitMemBuffer(Size);
  if (!GlobalsMB)
    return Plugin::error(ErrorCode::UNKNOWN,
                         "creating MemoryBuffer for globals memory");

  void *BufferPtr = GlobalsMB.get()->getBufferStart();
  for (auto &OffloadEntry : GlobalEntries) {
    if (!OffloadEntry.Size)
      continue;

    int32_t NameLength = OffloadEntry.Name.length() + 1;
    memcpy(BufferPtr, OffloadEntry.Name.data(), NameLength);
    BufferPtr = utils::advancePtr(BufferPtr, NameLength);

    *((uint32_t *)(BufferPtr)) = OffloadEntry.Size;
    BufferPtr = utils::advancePtr(BufferPtr, sizeof(uint32_t));

    if (auto Err = RRDevice.dataRetrieve(BufferPtr, OffloadEntry.Addr,
                                         OffloadEntry.Size, nullptr))
      return Err;
    BufferPtr = utils::advancePtr(BufferPtr, OffloadEntry.Size);
  }
  assert(BufferPtr == GlobalsMB->get()->getBufferEnd() &&
         "Buffer over/under-filled.");
  assert(Size ==
             utils::getPtrDiff(BufferPtr, GlobalsMB->get()->getBufferStart()) &&
         "Buffer size mismatch");

  StringRef GlobalsMemory(GlobalsMB.get()->getBufferStart(), Size);
  std::error_code EC;
  raw_fd_ostream OS(Filename, EC);
  OS << GlobalsMemory;
  OS.close();
  return Plugin::success();
}

Error MnemeRecordReplayTy::recordPrologue(
    const GenericKernelTy &Kernel, RRHandleTy Handle, uint32_t NumParams,
    const KernelLaunchParamsTy &LaunchParams) {
  std::string Filename =
      getSnapshotFilename(Kernel, Handle, /*IsPrologue=*/true);
  return recordSnapshot(Filename, Kernel.getImage(), NumParams, LaunchParams);
}

Error MnemeRecordReplayTy::recordEpilogue(const GenericKernelTy &Kernel,
                                          RRHandleTy Handle) {
  KernelLaunchParamsTy LaunchParams{0, nullptr, nullptr};
  std::string Filename =
      getSnapshotFilename(Kernel, Handle, /*IsPrologue=*/false);
  return recordSnapshot(Filename, Kernel.getImage(), 0, LaunchParams);
}

Error MnemeRecordReplayTy::recordSnapshot(
    StringRef Filename, DeviceImageTy &Image, uint32_t NumParams,
    const KernelLaunchParamsTy &LaunchParams) {
  std::error_code EC;
  raw_fd_ostream OS(Filename, EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "saving RR snapshot");

  // Write globals.
  size_t TotalGVs = 0;
  for (const auto &GV : GlobalEntries) {
    if (GV.Size)
      ++TotalGVs;
  }

  OS << StringRef(reinterpret_cast<const char *>(&TotalGVs), sizeof(TotalGVs));

  for (const auto &GV : GlobalEntries) {
    if (!GV.Size)
      continue;

    uint8_t *HostData = new uint8_t[GV.Size];
    if (auto Err = RRDevice.dataRetrieve(HostData, GV.Addr, GV.Size, nullptr))
      return Err;

    size_t StrLen = GV.Name.size();
    OS << StringRef(reinterpret_cast<const char *>(&StrLen), sizeof(StrLen));
    OS << GV.Name;
    OS << StringRef(reinterpret_cast<const char *>(&GV.Size), sizeof(GV.Size));
    OS << StringRef(reinterpret_cast<const char *>(&GV.Addr), sizeof(GV.Addr));
    OS << StringRef(reinterpret_cast<const char *>(HostData), GV.Size);
    delete[] HostData;
  }

  size_t TotalBlobs = 1;
  OS << StringRef(reinterpret_cast<const char *>(&TotalBlobs),
                  sizeof(TotalBlobs));

  // Write device memory.
  OS << llvm::StringRef(reinterpret_cast<const char *>(&RRTotalSize),
                        sizeof(RRTotalSize));
  OS << llvm::StringRef(reinterpret_cast<const char *>(&RRSize),
                        sizeof(RRSize));
  OS << llvm::StringRef(reinterpret_cast<const char *>(&RRStartAddr),
                        sizeof(RRStartAddr));

  ErrorOr<std::unique_ptr<WritableMemoryBuffer>> HostData =
      WritableMemoryBuffer::getNewUninitMemBuffer(RRSize);
  if (!HostData)
    return Plugin::error(ErrorCode::UNKNOWN, "creating host data buffer");

  if (auto Err = RRDevice.dataRetrieve(HostData.get()->getBufferStart(),
                                       RRStartAddr, RRSize, nullptr))
    return Err;

  OS << llvm::StringRef(
      reinterpret_cast<const char *>(HostData.get()->getBufferStart()), RRSize);

  // Write kernel arguments.
  size_t NumArgs = NumParams;
  OS << StringRef(reinterpret_cast<const char *>(&NumArgs), sizeof(NumArgs));

  for (size_t I = 0; I < NumArgs; I++) {
    size_t ArgSize = sizeof(void *);
    OS << StringRef(reinterpret_cast<const char *>(&ArgSize), sizeof(ArgSize));
    OS << StringRef(reinterpret_cast<const char *>(LaunchParams.Ptrs[I]),
                    ArgSize);
  }
  OS.close();
  return Plugin::success();
}

Error MnemeRecordReplayTy::recordDescriptor(const GenericKernelTy &Kernel,
                                            RRHandleTy Handle,
                                            KernelLaunchParamsTy LaunchParams,
                                            int32_t NumArgs, uint64_t NumTeams,
                                            uint32_t NumThreads,
                                            uint64_t LoopTripCount) {
  std::ostringstream StartSt;
  StartSt << RRStartAddr;

  std::filesystem::path CurrentPath = std::filesystem::current_path();

  json::Object JsonKernelInfo;
  JsonKernelInfo["DemangledName"] = "";
  JsonKernelInfo["KernelName"] = Kernel.getName();
  JsonKernelInfo["VASize"] = RRTotalSize;
  JsonKernelInfo["VAddr"] = StartSt.str();
  JsonKernelInfo["BinaryBlobs"] = json::Value(json::Array());
  JsonKernelInfo["Modules"] = json::Value(json::Array());
  JsonKernelInfo["StaticHash"] = std::to_string(Handle.KernelHash);

  json::Array JsonArgNames, JsonSpecializations;
  for (int I = 0; I < NumArgs; ++I) {
    JsonArgNames.push_back(std::string("arg") + std::to_string(I));
    JsonSpecializations.push_back(false);
  }
  JsonKernelInfo["ArgNames"] = json::Value(std::move(JsonArgNames));
  JsonKernelInfo["Specializations"] =
      json::Value(std::move(JsonSpecializations));

  json::Object JsonInstances;
  json::Object JsonInstance;
  JsonInstance["Args"] = json::Value(json::Array());
  JsonInstance["Prologue"] =
      (CurrentPath / getSnapshotFilename(Kernel, Handle, /*IsPrologue=*/true))
          .string();
  JsonInstance["Epilogue"] =
      (CurrentPath / getSnapshotFilename(Kernel, Handle, /*IsPrologue=*/false))
          .string();
  JsonInstance["SharedMem"] = 0;
  JsonInstance["Occurrences"] = 1;

  json::Object JsonGrid;
  JsonGrid["x"] = NumTeams;
  JsonGrid["y"] = 1;
  JsonGrid["z"] = 1;
  JsonInstance["GridDims"] = json::Value(std::move(JsonGrid));

  json::Object JsonBlock;
  JsonBlock["x"] = NumThreads;
  JsonBlock["y"] = 1;
  JsonBlock["z"] = 1;
  JsonInstance["BlockDims"] = json::Value(std::move(JsonBlock));

  JsonInstances[std::to_string(Handle.LaunchConfigHash)] =
      json::Value(std::move(JsonInstance));
  JsonKernelInfo["instances"] = json::Value(std::move(JsonInstances));

  SmallString<128> JsonFilename = {std::to_string(Handle.KernelHash).c_str(),
                                   ".json"};
  std::error_code EC;
  raw_fd_ostream JsonOS(JsonFilename.data(), EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "saving kernel json file");
  JsonOS << json::Value(std::move(JsonKernelInfo));
  JsonOS.close();

  return Plugin::success();
}

std::string
MnemeRecordReplayTy::getSnapshotFilename(const GenericKernelTy &Kernel,
                                         RRHandleTy Handle, bool IsPrologue) {
  std::ostringstream FilenameSt;
  FilenameSt << "DeviceState." << (IsPrologue ? "prologue" : "epilogue") << "."
             << std::to_string(Handle.KernelHash) << "."
             << std::to_string(Handle.LaunchConfigHash) << ".mneme";
  return FilenameSt.str();
}

void *RecordReplayTy::alloc(uint64_t Size) {
  assert(RRStartAddr && "Expected memory has been pre-allocated");
  constexpr int Alignment = 16;
  // Assumes alignment is a power of 2.
  int64_t AlignedSize = (Size + (Alignment - 1)) & (~(Alignment - 1));
  std::lock_guard<std::mutex> LG(RRAllocationLock);
  void *Alloc = (char *)RRStartAddr + RRSize;
  RRSize += AlignedSize;
  ODBG(OLDT_Alloc) << "Memory Allocator return " << Alloc;
  return Alloc;
}

Error RecordReplayTy::init(uint64_t MemSize, void *VAddr) {
  auto StartAddrOrErr = RRDevice.allocateWithVirtualAddress(MemSize, VAddr);
  if (!StartAddrOrErr)
    return StartAddrOrErr.takeError();
  if (!*StartAddrOrErr)
    return Plugin::error(ErrorCode::OUT_OF_RESOURCES, "allocating memory");

  RRStartAddr = *StartAddrOrErr;
  RRTotalSize = MemSize;

  INFO(OMP_INFOTYPE_PLUGIN_KERNEL, RRDevice.getDeviceId(),
       "Record initialized with starting address %p, "
       "memory size %lu bytes and status %s\n",
       RRStartAddr, RRTotalSize,
       RRStatus == RRStatusTy::RRRecording ? "recording" : "replaying");

  return Plugin::success();
}

Error RecordReplayTy::deinit() {
  if (RRStartAddr)
    return RRDevice.deallocateWithVirtualAddress(RRStartAddr, RRTotalSize);
  return Plugin::success();
}

RecordReplayTy::RRHandleTy
RecordReplayTy::createHandle(const GenericKernelTy &Kernel, uint64_t NumTeams,
                             uint32_t NumThreads, uint32_t SharedMemorySize) {
  size_t KernelHash = stable_hash_name(StringRef(Kernel.getName()));
  size_t LaunchConfigHash =
      stable_hash_combine((stable_hash)NumTeams, (stable_hash)NumThreads,
                          (stable_hash)SharedMemorySize);
  return {KernelHash, LaunchConfigHash};
}

Error NativeRecordReplayTy::recordPrologue(
    const GenericKernelTy &Kernel, RRHandleTy Handle, uint32_t NumParams,
    const KernelLaunchParamsTy &LaunchParams) {
  SmallString<128> SnapshotFilename = {Kernel.getName(), ".memory"};
  return recordSnapshot(SnapshotFilename);
}

Error NativeRecordReplayTy::recordEpilogue(const GenericKernelTy &Kernel,
                                           RRHandleTy Handle) {
  SmallString<128> GlobalsFilename = {Kernel.getName(), ".globals"};
  if (auto Err = recordGlobals(GlobalsFilename))
    return Err;

  SmallString<128> ImageFilename = {Kernel.getName(), ".image"};
  if (auto Err = recordImage(Kernel, ImageFilename))
    return Err;

  SmallString<128> SnapshotFilename = {
      Kernel.getName(),
      (isRecording() ? ".original.output" : ".replay.output")};
  return recordSnapshot(SnapshotFilename);
}

Error NativeRecordReplayTy::recordDescriptor(const GenericKernelTy &Kernel,
                                             RRHandleTy Handle,
                                             KernelLaunchParamsTy LaunchParams,
                                             int32_t NumArgs, uint64_t NumTeams,
                                             uint32_t NumThreads,
                                             uint64_t LoopTripCount) {
  json::Object JsonKernelInfo;
  JsonKernelInfo["Name"] = Kernel.getName();
  JsonKernelInfo["NumArgs"] = NumArgs;
  JsonKernelInfo["NumTeamsClause"] = NumTeams;
  JsonKernelInfo["ThreadLimitClause"] = NumThreads;
  JsonKernelInfo["LoopTripCount"] = LoopTripCount;
  JsonKernelInfo["DeviceMemorySize"] = RRSize;
  JsonKernelInfo["DeviceId"] = RRDevice.getDeviceId();
  JsonKernelInfo["BumpAllocVAStart"] = (intptr_t)RRStartAddr;

  json::Array JsonArgPtrs;
  for (int I = 0; I < NumArgs; ++I)
    JsonArgPtrs.push_back((intptr_t)LaunchParams.Ptrs[I]);
  JsonKernelInfo["ArgPtrs"] = json::Value(std::move(JsonArgPtrs));

  json::Array JsonArgOffsets;
  for (int I = 0; I < NumArgs; ++I)
    JsonArgOffsets.push_back(0);
  JsonKernelInfo["ArgOffsets"] = json::Value(std::move(JsonArgOffsets));

  SmallString<128> JsonFilename = {Kernel.getName(), ".json"};
  std::error_code EC;
  raw_fd_ostream JsonOS(JsonFilename.str(), EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "saving kernel json file");
  JsonOS << json::Value(std::move(JsonKernelInfo));
  JsonOS.close();
  return Plugin::success();
}

Error NativeRecordReplayTy::recordSnapshot(StringRef Filename) {
  ErrorOr<std::unique_ptr<WritableMemoryBuffer>> DeviceMemoryMB =
      WritableMemoryBuffer::getNewUninitMemBuffer(RRSize);
  if (!DeviceMemoryMB)
    return Plugin::error(ErrorCode::UNKNOWN,
                         "creating MemoryBuffer for device memory");

  if (auto Err = RRDevice.dataRetrieve(DeviceMemoryMB.get()->getBufferStart(),
                                       RRStartAddr, RRSize, nullptr))
    return Err;

  StringRef DeviceMemory(DeviceMemoryMB.get()->getBufferStart(), RRSize);
  std::error_code EC;
  raw_fd_ostream OS(Filename, EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "dumping memory to file");
  OS << DeviceMemory;
  OS.close();
  return Plugin::success();
}
