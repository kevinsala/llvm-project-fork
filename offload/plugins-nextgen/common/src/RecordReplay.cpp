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

Error RecordReplayTy::init(uint64_t MemSize, void *VAddr) {
  if (!VAddr)
    VAddr = Device.getSuggestedVirtualAddress();

  auto StartAddrOrErr = Device.allocateWithVirtualAddress(MemSize, VAddr);
  if (!StartAddrOrErr)
    return StartAddrOrErr.takeError();
  if (!*StartAddrOrErr)
    return Plugin::error(ErrorCode::OUT_OF_RESOURCES, "allocating memory");

  StartAddr = *StartAddrOrErr;
  TotalSize = MemSize;

  INFO(OMP_INFOTYPE_PLUGIN_KERNEL, Device.getDeviceId(),
       "Record initialized with starting address %p, "
       "memory size %lu bytes and status %s\n",
       StartAddr, TotalSize,
       Status == StatusTy::Recording ? "recording" : "replaying");

  return Plugin::success();
}

Error RecordReplayTy::deinit() {
  if (StartAddr)
    return Device.deallocateWithVirtualAddress(StartAddr, TotalSize);
  return Plugin::success();
}

std::pair<const RecordReplayTy::InstanceTy &, bool>
RecordReplayTy::registerInstance(StringRef KernelName, uint32_t NumTeams,
                                 uint32_t NumThreads,
                                 uint32_t SharedMemorySize) {
  std::lock_guard<std::mutex> LG(InstancesLock);
  auto [It, Inserted] =
      Instances.emplace(KernelName, NumTeams, NumThreads, SharedMemorySize);
  // Increase the number of occurrences.
  It->Occurrences += 1;
  return {*It, Inserted};
}

void *RecordReplayTy::allocate(uint64_t Size) {
  assert(StartAddr && "Expected memory has been pre-allocated");
  constexpr int Alignment = 16;
  // Assumes alignment is a power of 2.
  int64_t AlignedSize = (Size + (Alignment - 1)) & (~(Alignment - 1));
  std::lock_guard<std::mutex> LG(AllocationLock);
  void *Alloc = (char *)StartAddr + CurrentSize;
  CurrentSize += AlignedSize;
  ODBG(OLDT_Alloc) << "Memory Allocator return " << Alloc;
  return Alloc;
}

Expected<RecordReplayTy::HandleTy> RecordReplayTy::recordPrologue(
    const GenericKernelTy &Kernel, const KernelArgsTy &KernelArgs,
    const KernelLaunchParamsTy &LaunchParams, uint32_t NumTeams[3],
    uint32_t NumThreads[3], uint32_t SharedMemorySize) {
  if (!isRecordingOrReplaying())
    return HandleTy{nullptr, false};

  // Register the instance and avoid recording if it is inactive or replaying.
  auto [Instance, First] = registerInstance(Kernel.getName(), NumTeams[0],
                                            NumThreads[0], SharedMemorySize);

  HandleTy Handle{&Instance, First};
  if (isReplaying() || !First)
    return Handle;

  if (auto Err =
          recordDescriptorImpl(Kernel, Instance, KernelArgs, LaunchParams,
                               NumTeams, NumThreads, SharedMemorySize))
    return Err;

  if (auto Err = recordPrologueImpl(Kernel, Instance, KernelArgs, LaunchParams))
    return Err;

  return Handle;
}

Error RecordReplayTy::recordEpilogue(const GenericKernelTy &Kernel,
                                     HandleTy Handle) {
  if (!shouldRecordEpilogue() || !Handle.Active)
    return Plugin::success();

  return recordEpilogueImpl(Kernel, *Handle.Instance);
}

Error NativeRecordReplayTy::recordPrologueImpl(
    const GenericKernelTy &Kernel, const InstanceTy &Instance,
    const KernelArgsTy &KernelArgs, const KernelLaunchParamsTy &LaunchParams) {
  SmallString<128> SnapshotFilename = {Kernel.getName(), ".memory"};
  if (auto Err = recordSnapshot(SnapshotFilename))
    return Err;

  SmallString<128> GlobalsFilename = {Kernel.getName(), ".globals"};
  if (auto Err = recordGlobals(GlobalsFilename))
    return Err;

  SmallString<128> ImageFilename = {Kernel.getName(), ".image"};
  return recordImage(Kernel, ImageFilename);
}

Error NativeRecordReplayTy::recordEpilogueImpl(const GenericKernelTy &Kernel,
                                               const InstanceTy &Instance) {
  SmallString<128> SnapshotFilename = {
      Kernel.getName(),
      (isRecording() ? ".original.output" : ".replay.output")};
  return recordSnapshot(SnapshotFilename);
}

Error NativeRecordReplayTy::recordDescriptorImpl(
    const GenericKernelTy &Kernel, const InstanceTy &Instance,
    const KernelArgsTy &KernelArgs, const KernelLaunchParamsTy &LaunchParams,
    uint32_t NumTeams[3], uint32_t NumThreads[3], uint32_t SharedMemorySize) {
  json::Object JsonKernelInfo;
  JsonKernelInfo["Name"] = Kernel.getName();
  JsonKernelInfo["NumArgs"] = KernelArgs.NumArgs;
  JsonKernelInfo["NumTeamsClause"] = NumTeams[0];
  JsonKernelInfo["ThreadLimitClause"] = NumThreads[0];
  JsonKernelInfo["LoopTripCount"] = KernelArgs.Tripcount;
  JsonKernelInfo["DeviceMemorySize"] = CurrentSize;
  JsonKernelInfo["DeviceId"] = Device.getDeviceId();
  JsonKernelInfo["VAllocAddr"] = (intptr_t)StartAddr;
  JsonKernelInfo["VAllocSize"] = TotalSize;

  json::Array JsonArgPtrs;
  for (uint32_t I = 0; I < KernelArgs.NumArgs; ++I)
    JsonArgPtrs.push_back((intptr_t)(*(void **)LaunchParams.Ptrs[I]));
  JsonKernelInfo["ArgPtrs"] = json::Value(std::move(JsonArgPtrs));

  json::Array JsonArgOffsets;
  for (uint32_t I = 0; I < KernelArgs.NumArgs; ++I)
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
      WritableMemoryBuffer::getNewUninitMemBuffer(CurrentSize);
  if (!DeviceMemoryMB)
    return Plugin::error(ErrorCode::UNKNOWN,
                         "creating MemoryBuffer for device memory");

  if (auto Err = Device.dataRetrieve(DeviceMemoryMB.get()->getBufferStart(),
                                     StartAddr, CurrentSize, nullptr))
    return Err;

  StringRef DeviceMemory(DeviceMemoryMB.get()->getBufferStart(), CurrentSize);
  std::error_code EC;
  raw_fd_ostream OS(Filename, EC);
  if (EC)
    return Plugin::error(ErrorCode::UNKNOWN, "dumping memory to file");
  OS << DeviceMemory;
  OS.close();
  return Plugin::success();
}

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

    if (auto Err = Device.dataRetrieve(BufferPtr, OffloadEntry.Addr,
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

Error MnemeRecordReplayTy::recordPrologueImpl(
    const GenericKernelTy &Kernel, const InstanceTy &Instance,
    const KernelArgsTy &KernelArgs, const KernelLaunchParamsTy &LaunchParams) {
  std::string Filename =
      getSnapshotFilename(Kernel, Instance, /*IsPrologue=*/true);
  return recordSnapshot(Filename, Kernel.getImage(), KernelArgs.NumArgs,
                        LaunchParams);
}

Error MnemeRecordReplayTy::recordEpilogueImpl(const GenericKernelTy &Kernel,
                                              const InstanceTy &Instance) {
  KernelLaunchParamsTy LaunchParams{0, nullptr, nullptr};
  std::string Filename =
      getSnapshotFilename(Kernel, Instance, /*IsPrologue=*/false);
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
    if (auto Err = Device.dataRetrieve(HostData, GV.Addr, GV.Size, nullptr))
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
  OS << llvm::StringRef(reinterpret_cast<const char *>(&TotalSize),
                        sizeof(TotalSize));
  OS << llvm::StringRef(reinterpret_cast<const char *>(&CurrentSize),
                        sizeof(CurrentSize));
  OS << llvm::StringRef(reinterpret_cast<const char *>(&StartAddr),
                        sizeof(StartAddr));

  ErrorOr<std::unique_ptr<WritableMemoryBuffer>> HostData =
      WritableMemoryBuffer::getNewUninitMemBuffer(CurrentSize);
  if (!HostData)
    return Plugin::error(ErrorCode::UNKNOWN, "creating host data buffer");

  if (auto Err = Device.dataRetrieve(HostData.get()->getBufferStart(),
                                     StartAddr, CurrentSize, nullptr))
    return Err;

  OS << llvm::StringRef(
      reinterpret_cast<const char *>(HostData.get()->getBufferStart()),
      CurrentSize);

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

Error MnemeRecordReplayTy::recordDescriptorImpl(
    const GenericKernelTy &Kernel, const InstanceTy &Instance,
    const KernelArgsTy &KernelArgs, const KernelLaunchParamsTy &LaunchParams,
    uint32_t NumTeams[3], uint32_t NumThreads[3], uint32_t SharedMemorySize) {
  std::ostringstream StartSt;
  StartSt << StartAddr;

  std::filesystem::path CurrentPath = std::filesystem::current_path();

  json::Object JsonKernelInfo;
  JsonKernelInfo["DemangledName"] = "";
  JsonKernelInfo["KernelName"] = Kernel.getName();
  JsonKernelInfo["VASize"] = TotalSize;
  JsonKernelInfo["VAddr"] = StartSt.str();
  JsonKernelInfo["BinaryBlobs"] = json::Value(json::Array());
  JsonKernelInfo["Modules"] = json::Value(json::Array());
  JsonKernelInfo["StaticHash"] = std::to_string(Instance.KernelHash);

  json::Array JsonArgNames, JsonSpecializations;
  for (uint32_t I = 0; I < KernelArgs.NumArgs; ++I) {
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
      (CurrentPath / getSnapshotFilename(Kernel, Instance, /*Prologue=*/true))
          .string();
  JsonInstance["Epilogue"] =
      (CurrentPath / getSnapshotFilename(Kernel, Instance, /*Prologue=*/false))
          .string();
  JsonInstance["SharedMem"] = SharedMemorySize;
  JsonInstance["Occurrences"] = 1;

  json::Object JsonGrid;
  JsonGrid["x"] = NumTeams[0];
  JsonGrid["y"] = 1;
  JsonGrid["z"] = 1;
  JsonInstance["GridDims"] = json::Value(std::move(JsonGrid));

  json::Object JsonBlock;
  JsonBlock["x"] = NumThreads[0];
  JsonBlock["y"] = 1;
  JsonBlock["z"] = 1;
  JsonInstance["BlockDims"] = json::Value(std::move(JsonBlock));

  JsonInstances[std::to_string(Instance.LaunchConfigHash)] =
      json::Value(std::move(JsonInstance));
  JsonKernelInfo["instances"] = json::Value(std::move(JsonInstances));

  SmallString<128> JsonFilename = {std::to_string(Instance.KernelHash).c_str(),
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
                                         const InstanceTy &Instance,
                                         bool IsPrologue) {
  std::ostringstream FilenameSt;
  FilenameSt << "DeviceState." << (IsPrologue ? "prologue" : "epilogue") << "."
             << std::to_string(Instance.KernelHash) << "."
             << std::to_string(Instance.LaunchConfigHash) << ".mneme";
  return FilenameSt.str();
}
