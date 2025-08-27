; ModuleID = 't4.c'
source_filename = "t4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__objsan_shadow.A = global ptr poison
@A = dso_local global i32 2000, align 4
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

define private void @__objsan_ctor() {
entry:
  %0 = call ptr @__objsan_pre_global(ptr @A, i32 4, i8 1, i8 1) #0
  store ptr %0, ptr @__objsan_shadow.A, align 8
  ret void
}

declare ptr @__objsan_pre_global(ptr, i32, i8, i8)

attributes #0 = { willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git 4083f0d3db28355305541623c82f40052928b3c4)"}
