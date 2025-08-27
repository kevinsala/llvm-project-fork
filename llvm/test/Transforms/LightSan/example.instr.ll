; ModuleID = 'example.ll'
source_filename = "example.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__objsan_value_pack = internal global <{ i32, i32, [4 x i8], i32, i32, i32, ptr }> <{ i32 4, i32 12, [4 x i8] zeroinitializer, i32 0, i32 8, i32 14, ptr null }>
@__objsan_value_pack.1 = internal global <{ i32, i32, ptr }> <{ i32 8, i32 14, ptr null }>
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter_main = alias i32 (i32, ptr), ptr @main

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca [3 x ptr], align 8
  %4 = alloca <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, align 8
  %5 = alloca i8, align 1
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr @__objsan_value_pack, i64 32, i1 false)
  %11 = getelementptr inbounds nuw <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, ptr %4, i32 0, i32 3
  store i32 %0, ptr %11, align 4
  %12 = getelementptr inbounds nuw <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, ptr %4, i32 0, i32 6
  store ptr %1, ptr %12, align 8
  call void @__objsan_pre_function(i32 2, ptr %4) #3
  %13 = getelementptr inbounds i8, ptr %4, i32 12
  %14 = load i32, ptr %13, align 4
  %15 = getelementptr inbounds i8, ptr %4, i32 24
  %16 = load ptr, ptr %15, align 8
  %17 = call ptr @__objsan_post_alloca(ptr %7, i64 4, i8 1) #3
  store ptr %17, ptr %8, align 8
  %18 = alloca i32, align 4
  %19 = call ptr @__objsan_post_alloca(ptr %18, i64 4, i8 1) #3
  store ptr %19, ptr %9, align 8
  %20 = alloca ptr, align 8
  %21 = call ptr @__objsan_post_alloca(ptr %20, i64 8, i8 1) #3
  store ptr %21, ptr %10, align 8
  %22 = call ptr @__objsan_pre_store(ptr %17, ptr %7, ptr null, i64 4, ptr %7, i64 4, i8 2, i8 0) #3
  store i32 0, ptr %22, align 4
  %23 = getelementptr inbounds i8, ptr %18, i64 4
  %24 = getelementptr inbounds i8, ptr %18, i64 4
  %25 = icmp ult ptr %18, %18
  %26 = select i1 %25, ptr %18, ptr %18
  %27 = icmp ugt ptr %23, %24
  %28 = select i1 %27, ptr %23, ptr %24
  %29 = call ptr @__objsan_post_loop_value_range(ptr %26, ptr %28, i64 0, ptr %18, i64 4, i8 2, i8 1)
  store i32 %14, ptr %18, align 4
  %30 = call ptr @__objsan_pre_store(ptr %21, ptr %20, ptr null, i64 8, ptr %20, i64 8, i8 2, i8 0) #3
  store ptr %16, ptr %30, align 8
  %31 = load i32, ptr %18, align 4
  %32 = call i32 @__adapter_example(i32 noundef %31, ptr noundef %19)
  %33 = getelementptr ptr, ptr %3, i32 0
  %34 = load ptr, ptr %8, align 8
  store ptr %34, ptr %33, align 8
  %35 = getelementptr ptr, ptr %3, i32 1
  %36 = load ptr, ptr %9, align 8
  store ptr %36, ptr %35, align 8
  %37 = getelementptr ptr, ptr %3, i32 2
  %38 = load ptr, ptr %10, align 8
  store ptr %38, ptr %37, align 8
  call void @__objsan_post_function(i32 3, ptr %3) #3
  ret i32 %32
}

declare i32 @example(i32 noundef, ptr noundef) #1

declare ptr @__objsan_post_loop_value_range(ptr, ptr, i64, ptr, i64, i8, i8)

declare ptr @__objsan_get_mptr(ptr, ptr, i8)

define weak i32 @__adapter_example(i32 noundef %0, ptr noundef %1) #1 {
entry:
  %2 = alloca i8, align 1
  %3 = alloca i64, align 8
  %4 = call ptr @__objsan_post_base_pointer_info(ptr %1, ptr nonnull %3, ptr nonnull %2) #3
  %5 = load i8, ptr %2, align 1
  %6 = call ptr @__objsan_get_mptr(ptr %1, ptr %4, i8 %5)
  %7 = call i32 @example(i32 %0, ptr %6)
  ret i32 %7
}

declare ptr @__objsan_post_alloca(ptr, i64, i8)

declare ptr @__objsan_post_base_pointer_info(ptr, ptr, ptr)

declare ptr @__objsan_pre_store(ptr, ptr, ptr, i64, ptr, i64, i8, i8)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

declare void @__objsan_pre_function(i32, ptr)

declare void @__objsan_post_function(i32, ptr)

define private void @__objsan_ctor() {
entry:
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git 759240f33b2ab88f9167b8c9c6752e0f6fc6fd2b)"}
