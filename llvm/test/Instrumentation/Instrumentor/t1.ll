; ModuleID = 'unreachable_trap.ll'
source_filename = "unreachable_trap.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c"unreachable_and_trap.c\00", align 1
@__PRETTY_FUNCTION__.trap2 = private unnamed_addr constant [17 x i8] c"void trap2(void)\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @unreachable() #0 {
entry:
  call void @__instrumentor_pre_unreachable() #3
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @trap1() #0 {
entry:
  call void @__instrumentor_pre_call() #3
  call void @llvm.trap()
  ret void
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @trap2() #0 {
entry:
  call void @__instrumentor_pre_call() #3
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 12, ptr noundef @__PRETTY_FUNCTION__.trap2) #4
  call void @__instrumentor_pre_unreachable() #3
  unreachable
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

declare void @__instrumentor_pre_unreachable()

declare void @__instrumentor_pre_call()

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { willreturn }
attributes #4 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 20.0.0git (https://github.com/jdoerfert/llvm-project.git 035afa9b5a6f2a0275c2d47d184e90ed2a7eac31)"}
