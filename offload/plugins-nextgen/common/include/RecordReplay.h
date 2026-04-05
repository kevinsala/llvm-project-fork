//===- RecordReplay.h - Record Replay interface ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#ifndef OPENMP_LIBOMPTARGET_PLUGINS_NEXTGEN_COMMON_RECORDREPLAY_H
#define OPENMP_LIBOMPTARGET_PLUGINS_NEXTGEN_COMMON_RECORDREPLAY_H

#include <cstddef>
#include <cstdint>
#include <mutex>

#include "Shared/APITypes.h"
#include "Shared/EnvironmentVar.h"
#include "Shared/Utils.h"

#include "OffloadError.h"

#include "llvm/ADT/Hashing.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StableHashing.h"
#include "llvm/Support/Error.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MemoryBufferRef.h"
#include "llvm/Support/raw_ostream.h"

namespace llvm {
namespace omp {
namespace target {
namespace plugin {

struct GenericKernelTy;
struct GenericDeviceTy;

struct RecordReplayTy {

  /// Describes the state of the record replay mechanism.
  enum RRStatusTy { RRDeactivated = 0, RRRecording, RRReplaying };

  /// Describes the format of the recording.
  enum RRFormatTy { RRNative = 0, RRMneme };

  /// Identification of the kernel recording.
  struct RRHandleTy {
    size_t KernelHash = 0;
    size_t LaunchConfigHash = 0;
  };

protected:
  void *RRStartAddr = nullptr;
  uint64_t RRTotalSize = 0;
  uint64_t RRSize = 0;
  RRStatusTy RRStatus;
  bool RRSaveOutput;
  GenericDeviceTy &RRDevice;
  std::mutex RRAllocationLock;

  // A list of all globals mapped to the device.
  struct GlobalEntry {
    std::string Name;
    uint64_t Size;
    void *Addr;
  };
  llvm::SmallVector<GlobalEntry> GlobalEntries;

public:
  RecordReplayTy(RRStatusTy Status, bool SaveOutput, GenericDeviceTy &Device)
      : RRStatus(Status), RRSaveOutput(SaveOutput), RRDevice(Device) {}

  virtual ~RecordReplayTy() = default;

  void setStatus(RRStatusTy Status) { RRStatus = Status; }
  bool isRecording() const { return RRStatus == RRStatusTy::RRRecording; }
  bool isReplaying() const { return RRStatus == RRStatusTy::RRReplaying; }
  bool isRecordingOrReplaying() const { return isRecording() || isReplaying(); }
  bool shouldRecordOutput() const { return RRSaveOutput; }
  bool shouldRecordPrologue() const { return isRecording(); }
  bool shouldRecordEpilogue() const { return isRecordingOrReplaying(); }
  void addEntry(const char *Name, uint64_t Size, void *Addr) {
    GlobalEntries.emplace_back(GlobalEntry{Name, Size, Addr});
  }

  virtual Error recordPrologue(const GenericKernelTy &Kernel, RRHandleTy Handle,
                               uint32_t NumParams,
                               const KernelLaunchParamsTy &LaunchParams) = 0;
  virtual Error recordEpilogue(const GenericKernelTy &Kernel,
                               RRHandleTy Handle) = 0;
  virtual Error recordDescriptor(const GenericKernelTy &Kernel,
                                 RRHandleTy Handle,
                                 KernelLaunchParamsTy LaunchParams,
                                 int32_t NumArgs, uint64_t NumTeams,
                                 uint32_t NumThreads,
                                 uint64_t LoopTripCount) = 0;

  void *alloc(uint64_t Size);

  Error init(uint64_t MemSize, void *VAddr);
  Error deinit();

  static RRHandleTy createHandle(const GenericKernelTy &Kernel,
                                 uint64_t NumTeams, uint32_t NumThreads,
                                 uint32_t SharedMemorySize);
};

struct MnemeRecordReplayTy : public RecordReplayTy {
  MnemeRecordReplayTy(RRStatusTy Status, bool SaveOutput,
                      GenericDeviceTy &Device)
      : RecordReplayTy(Status, SaveOutput, Device) {}

  Error recordPrologue(const GenericKernelTy &Kernel, RRHandleTy Handle,
                       uint32_t NumParams,
                       const KernelLaunchParamsTy &LaunchParams) override;
  Error recordEpilogue(const GenericKernelTy &Kernel,
                       RRHandleTy Handle) override;
  Error recordDescriptor(const GenericKernelTy &Kernel, RRHandleTy Handle,
                         KernelLaunchParamsTy LaunchParams, int32_t NumArgs,
                         uint64_t NumTeams, uint32_t NumThreads,
                         uint64_t LoopTripCount) override;

private:
  Error recordSnapshot(StringRef Filename, DeviceImageTy &Image,
                       uint32_t NumParams,
                       const KernelLaunchParamsTy &LaunchParams);

  static std::string getSnapshotFilename(const GenericKernelTy &Kernel,
                                         RRHandleTy Handle, bool IsPrologue);
};

struct NativeRecordReplayTy : public RecordReplayTy {
  NativeRecordReplayTy(RRStatusTy Status, bool SaveOutput,
                       GenericDeviceTy &Device)
      : RecordReplayTy(Status, SaveOutput, Device) {}

  Error recordPrologue(const GenericKernelTy &Kernel, RRHandleTy Handle,
                       uint32_t NumParams,
                       const KernelLaunchParamsTy &LaunchParams) override;
  Error recordEpilogue(const GenericKernelTy &Kernel,
                       RRHandleTy Handle) override;
  Error recordDescriptor(const GenericKernelTy &Kernel, RRHandleTy Handle,
                         KernelLaunchParamsTy LaunchParams, int32_t NumArgs,
                         uint64_t NumTeams, uint32_t NumThreads,
                         uint64_t LoopTripCount) override;

private:
  Error recordSnapshot(StringRef Filename);
  Error recordGlobals(StringRef Filename);
  Error recordImage(const GenericKernelTy &Kernel, StringRef Filename);
};

} // namespace plugin
} // namespace target
} // namespace omp
} // namespace llvm

#endif // OPENMP_LIBOMPTARGET_PLUGINS_COMMON_RECORDREPLAY_H
