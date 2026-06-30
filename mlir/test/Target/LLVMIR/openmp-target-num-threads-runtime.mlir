// RUN: mlir-translate -mlir-to-llvmir %s | FileCheck %s

// Regression test: a runtime (non-constant) 'num_threads' on a target-SPMD
// 'teams parallel' kernel must leave the compile-time max thread count as 0
// ("unknown"), NOT 1. If it were left at 1, the kernel's launch bounds
// ("omp_target_thread_limit" / "amdgpu-flat-work-group-size") would clamp
// every team to a single thread, ignoring the runtime thread count.
//
// ConfigurationEnvironmentTy layout:
//   { i8 UseGenericStateMachine, i8 MayUseNestedParallelism, i8 ExecMode,
//     i32 MinThreads, i32 MaxThreads, i32 MinTeams, i32 MaxTeams, i32, i32 }

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.alloca_memory_space", 5 : ui32>>, llvm.target_triple = "amdgcn-amd-amdhsa", omp.is_target_device = true, omp.is_gpu = true} {

  // Runtime num_threads (loaded from a mapped pointer): MaxThreads must be 0.
  // CHECK: @[[RT_ENV:.*runtime_num_threads.*_kernel_environment]] = weak_odr protected constant %struct.KernelEnvironmentTy {
  // CHECK-SAME: %struct.ConfigurationEnvironmentTy { i8 0, i8 1, i8 2, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0 },
  llvm.func @runtime_num_threads(%nt_ptr : !llvm.ptr) {
    %0 = omp.map.info var_ptr(%nt_ptr : !llvm.ptr, i32) map_clauses(to) capture(ByCopy) -> !llvm.ptr
    omp.target map_entries(%0 -> %arg : !llvm.ptr) {
      %nt = llvm.load %arg : !llvm.ptr -> i32
      omp.teams {
        omp.parallel num_threads(%nt : i32) {
          omp.terminator
        }
        omp.terminator
      }
      omp.terminator
    }
    llvm.return
  }

  // Constant num_threads still folds to the exact value (baseline, unchanged).
  // CHECK: @[[CT_ENV:.*constant_num_threads.*_kernel_environment]] = weak_odr protected constant %struct.KernelEnvironmentTy {
  // CHECK-SAME: %struct.ConfigurationEnvironmentTy { i8 0, i8 1, i8 2, i32 1, i32 256, i32 0, i32 0, i32 0, i32 0 },
  llvm.func @constant_num_threads() {
    omp.target {
      %nt = llvm.mlir.constant(256 : i32) : i32
      omp.teams {
        omp.parallel num_threads(%nt : i32) {
          omp.terminator
        }
        omp.terminator
      }
      omp.terminator
    }
    llvm.return
  }
}

// The runtime kernel must not carry a single-thread launch-bound clamp.
// CHECK-NOT: "omp_target_thread_limit"="1"
// CHECK-NOT: "amdgpu-flat-work-group-size"="1,1"
