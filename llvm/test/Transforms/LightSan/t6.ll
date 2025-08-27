; ModuleID = 't6.c'
source_filename = "t6.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__objsan_shadow.stdout = weak_odr global ptr @stdout
@stdout = external global ptr, align 8
@__objsan_value_pack = internal global <{ i32, i32, [4 x i8], i32, i32, i32, ptr }> <{ i32 4, i32 12, [4 x i8] zeroinitializer, i32 0, i32 8, i32 14, ptr null }>
@__objsan_value_pack.1 = internal global <{ i32, i32, ptr, i32, i32, ptr }> <{ i32 8, i32 14, ptr null, i32 8, i32 14, ptr null }>
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter_main = alias i32 (i32, ptr), ptr @main

; Function Attrs: noinline nounwind optnone sanitize_obj uwtable
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %0 = alloca <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, align 8
  %size = alloca i64, align 8
  %1 = alloca i8, align 1
  %2 = alloca i64, align 8
  %retval = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = load ptr, ptr @__objsan_shadow.stdout, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr @__objsan_value_pack, i64 32, i1 false)
  %8 = getelementptr inbounds nuw <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, ptr %0, i32 0, i32 3
  store i32 %argc, ptr %8, align 4
  %9 = getelementptr inbounds nuw <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, ptr %0, i32 0, i32 6
  store ptr %argv, ptr %9, align 8
  call void @__objsan_pre_function(i32 2, ptr %0) #3
  %10 = getelementptr inbounds i8, ptr %0, i32 12
  %11 = load i32, ptr %10, align 4
  %12 = getelementptr inbounds i8, ptr %0, i32 24
  %13 = load ptr, ptr %12, align 8
  %14 = call ptr @__objsan_post_base_pointer_info(ptr %7, ptr %2, ptr %1) #3
  %15 = load i64, ptr %2, align 8
  store i64 %15, ptr %size, align 8
  %16 = load i8, ptr %1, align 1
  %17 = call ptr @__objsan_post_alloca(ptr %retval, i64 4, i8 1) #3
  %18 = call ptr @__objsan_post_base_pointer_info(ptr %17, ptr %2, ptr %1) #3
  %19 = load i64, ptr %2, align 8
  %20 = load i8, ptr %1, align 1
  %21 = call ptr @__objsan_pre_store(ptr %17, ptr %18, ptr null, i64 4, i64 %19, i8 2, i8 0) #3
  store ptr %17, ptr %3, align 8
  %argc.addr = alloca i32, align 4
  %22 = call ptr @__objsan_post_alloca(ptr %argc.addr, i64 4, i8 1) #3
  %23 = call ptr @__objsan_post_base_pointer_info(ptr %22, ptr %2, ptr %1) #3
  %24 = load i64, ptr %2, align 8
  %25 = load i8, ptr %1, align 1
  %26 = call ptr @__objsan_pre_store(ptr %22, ptr %23, ptr null, i64 4, i64 %24, i8 2, i8 0) #3
  store ptr %22, ptr %4, align 8
  %argv.addr = alloca ptr, align 8
  %27 = call ptr @__objsan_post_alloca(ptr %argv.addr, i64 8, i8 1) #3
  %28 = call ptr @__objsan_post_base_pointer_info(ptr %27, ptr %2, ptr %1) #3
  %29 = load i64, ptr %2, align 8
  %30 = call ptr @__objsan_pre_load(ptr %27, ptr %28, ptr null, i64 8, i64 %29, i8 2, i8 0) #3
  %31 = load i8, ptr %1, align 1
  %32 = call ptr @__objsan_pre_store(ptr %27, ptr %28, ptr null, i64 8, i64 %29, i8 2, i8 0) #3
  store ptr %27, ptr %5, align 8
  %rt = alloca i32, align 4
  %33 = call ptr @__objsan_post_alloca(ptr %rt, i64 4, i8 1) #3
  %34 = call ptr @__objsan_post_base_pointer_info(ptr %33, ptr %2, ptr %1) #3
  %35 = load i64, ptr %2, align 8
  store i64 %35, ptr %size, align 8
  %36 = load i8, ptr %1, align 1
  store ptr %33, ptr %6, align 8
  store i32 0, ptr %21, align 4
  store i32 %11, ptr %26, align 4
  store ptr %13, ptr %32, align 8
  %37 = load ptr, ptr %30, align 8
  %38 = call ptr @__objsan_post_base_pointer_info(ptr %37, ptr %2, ptr %1) #3
  %39 = load i64, ptr %2, align 8
  store i64 %39, ptr %size, align 8
  %40 = load i8, ptr %1, align 1
  %arrayidx = getelementptr inbounds ptr, ptr %37, i64 0
  %41 = load i64, ptr %size, align 8
  %42 = call ptr @__objsan_pre_load(ptr %arrayidx, ptr %38, ptr null, i64 8, i64 %41, i8 %40, i8 0) #3
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %size, align 8
  %45 = call ptr @__objsan_pre_load(ptr %7, ptr %14, ptr null, i64 8, i64 %44, i8 %16, i8 0) #3
  %46 = load ptr, ptr %45, align 8
  %call = call i32 @__adapter_fputs(ptr noundef %43, ptr noundef %46)
  %47 = load i64, ptr %size, align 8
  %48 = call ptr @__objsan_pre_store(ptr %33, ptr %34, ptr null, i64 4, i64 %47, i8 2, i8 0) #3
  store i32 %call, ptr %48, align 4
  %49 = load i64, ptr %size, align 8
  %50 = call ptr @__objsan_pre_load(ptr %33, ptr %34, ptr null, i64 4, i64 %49, i8 2, i8 0) #3
  %51 = load i32, ptr %50, align 4
  %52 = getelementptr ptr, ptr %0, i32 0
  %53 = load ptr, ptr %3, align 8
  store ptr %53, ptr %52, align 8
  %54 = getelementptr ptr, ptr %0, i32 1
  %55 = load ptr, ptr %4, align 8
  store ptr %55, ptr %54, align 8
  %56 = getelementptr ptr, ptr %0, i32 2
  %57 = load ptr, ptr %5, align 8
  store ptr %57, ptr %56, align 8
  %58 = getelementptr ptr, ptr %0, i32 3
  %59 = load ptr, ptr %6, align 8
  store ptr %59, ptr %58, align 8
  call void @__objsan_post_function(i32 4, ptr %0) #3
  ret i32 %51
}

declare i32 @fputs(ptr noundef, ptr noundef) #1

define weak i32 @__adapter_fputs(ptr noundef %0, ptr noundef %1) #1 {
entry:
  %2 = alloca <{ i32, i32, ptr, i32, i32, ptr }>, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %2, ptr @__objsan_value_pack.1, i64 32, i1 false)
  %3 = getelementptr inbounds nuw <{ i32, i32, ptr, i32, i32, ptr }>, ptr %2, i32 0, i32 2
  store ptr %0, ptr %3, align 8
  %4 = getelementptr inbounds nuw <{ i32, i32, ptr, i32, i32, ptr }>, ptr %2, i32 0, i32 5
  store ptr %1, ptr %4, align 8
  call void @__objsan_pre_call(i64 0, i32 2, ptr %2, i8 0) #3
  %5 = getelementptr inbounds i8, ptr %2, i32 8
  %6 = load ptr, ptr %5, align 8
  %7 = getelementptr inbounds i8, ptr %2, i32 24
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @fputs(ptr %6, ptr %8)
  ret i32 %9
}

declare ptr @__objsan_post_alloca(ptr, i64, i8)

declare ptr @__objsan_post_base_pointer_info(ptr, ptr, ptr)

declare ptr @__objsan_pre_store(ptr, ptr, ptr, i64, i64, i8, i8)

declare ptr @__objsan_pre_load(ptr, ptr, ptr, i64, i64, i8, i8)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

declare void @__objsan_pre_function(i32, ptr)

declare void @__objsan_post_function(i32, ptr)

declare void @__objsan_pre_call(i64, i32, ptr, i8)

define private void @__objsan_ctor() {
entry:
  %0 = call ptr @__objsan_pre_global(ptr @stdout, i32 0, i8 1) #3
  ret void
}

declare ptr @__objsan_pre_global(ptr, i32, i8)

attributes #0 = { noinline nounwind optnone sanitize_obj uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!5 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git 4083f0d3db28355305541623c82f40052928b3c4)"}
