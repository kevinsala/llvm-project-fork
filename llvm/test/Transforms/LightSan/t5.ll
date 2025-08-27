; ModuleID = 't5.c'
source_filename = "t5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@stderr = external global ptr, align 8
@__objsan_shadow..str = private global ptr poison
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@A = external global i32, align 4
@__objsan_value_pack = internal global <{ i32, i32, ptr, i32, i32, ptr }> <{ i32 8, i32 14, ptr null, i32 8, i32 14, ptr @.str }>
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter_main = alias i32 (), ptr @main

; Function Attrs: noinline nounwind optnone sanitize_obj uwtable
define dso_local i32 @main() #0 {
entry:
  %0 = alloca <{ i32, i32, ptr, i32, i32, ptr }>, align 8
  %1 = alloca i8, align 1
  %2 = alloca i64, align 8
  call void @__objsan_pre_function(i32 0, ptr null) #3
  %3 = call ptr @__objsan_post_base_pointer_info(ptr @A, ptr %2, ptr %1) #3
  %4 = load i64, ptr %2, align 8
  %5 = load i8, ptr %1, align 1
  %6 = call ptr @__objsan_pre_load(ptr @A, ptr %3, ptr null, i64 4, i64 %4, i8 %5, i8 0) #3
  %7 = call ptr @__objsan_post_base_pointer_info(ptr @stderr, ptr %2, ptr %1) #3
  %8 = load i64, ptr %2, align 8
  %9 = load i8, ptr %1, align 1
  %10 = call ptr @__objsan_pre_load(ptr @stderr, ptr %7, ptr null, i64 8, i64 %8, i8 %9, i8 0) #3
  %11 = load ptr, ptr %10, align 8
  %12 = load i32, ptr %6, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr @__objsan_value_pack, i64 32, i1 false)
  %13 = getelementptr inbounds nuw <{ i32, i32, ptr, i32, i32, ptr }>, ptr %0, i32 0, i32 2
  store ptr %11, ptr %13, align 8
  call void @__objsan_pre_call(i64 0, i32 2, ptr %0, i8 0) #3
  %14 = getelementptr inbounds i8, ptr %0, i32 8
  %15 = load ptr, ptr %14, align 8
  %16 = getelementptr inbounds i8, ptr %0, i32 24
  %17 = load ptr, ptr %16, align 8
  %call = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %15, ptr noundef %17, i32 noundef %12) #4
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

declare ptr @__objsan_post_base_pointer_info(ptr, ptr, ptr)

declare ptr @__objsan_pre_load(ptr, ptr, ptr, i64, i64, i8, i8)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

declare void @__objsan_pre_call(i64, i32, ptr, i8)

declare void @__objsan_pre_function(i32, ptr)

define private void @__objsan_ctor() {
entry:
  %0 = call ptr @__objsan_pre_global(ptr @.str, i32 4, i8 1) #3
  store ptr %0, ptr @__objsan_shadow..str, align 8
  ret void
}

declare ptr @__objsan_pre_global(ptr, i32, i8)

attributes #0 = { noinline nounwind optnone sanitize_obj uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { willreturn }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git 4083f0d3db28355305541623c82f40052928b3c4)"}
