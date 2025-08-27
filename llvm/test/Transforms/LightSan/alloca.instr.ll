; ModuleID = 'alloca.ll'
source_filename = "alloca.ll"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter_foo = alias ptr (), ptr @foo
@__adapter_bar = alias ptr (i1), ptr @bar
@__adapter_baz = alias ptr (i32), ptr @baz
@__adapter_fizz = alias ptr (), ptr @fizz

define ptr @foo() {
entry:
  %0 = alloca [1 x ptr], align 8
  %a = alloca ptr, align 8
  %1 = call ptr @__objsan_post_alloca(ptr %a, i64 8, i8 1) #0
  %2 = getelementptr ptr, ptr %0, i32 0
  store ptr %1, ptr %2, align 8
  call void @__objsan_post_function(i32 1, ptr %0) #0
  ret ptr %1
}

define ptr @bar(i1 %c) {
entry:
  %0 = alloca [2 x ptr], align 8
  %a = alloca i32, align 4
  %1 = call ptr @__objsan_post_alloca(ptr %a, i64 4, i8 1) #0
  %b = alloca i32, i32 5, align 4
  %2 = call ptr @__objsan_post_alloca(ptr %b, i64 20, i8 1) #0
  %s = select i1 %c, ptr %1, ptr %2
  %3 = getelementptr ptr, ptr %0, i32 0
  store ptr %1, ptr %3, align 8
  %4 = getelementptr ptr, ptr %0, i32 1
  store ptr %2, ptr %4, align 8
  call void @__objsan_post_function(i32 2, ptr %0) #0
  ret ptr %s
}

define ptr @baz(i32 %v) {
entry:
  %0 = alloca [1 x ptr], align 8
  %a = alloca ptr, i32 %v, align 8
  %1 = zext i32 %v to i64
  %2 = mul i64 8, %1
  %3 = call ptr @__objsan_post_alloca(ptr %a, i64 %2, i8 1) #0
  %4 = getelementptr ptr, ptr %0, i32 0
  store ptr %3, ptr %4, align 8
  call void @__objsan_post_function(i32 1, ptr %0) #0
  ret ptr %3
}

define ptr @fizz() {
entry:
  %0 = alloca [1 x ptr], align 8
  %a = alloca <vscale x 2 x i32>, align 8
  %1 = getelementptr <vscale x 2 x i32>, ptr null, i32 1
  %2 = ptrtoint ptr %1 to i64
  %3 = call ptr @__objsan_post_alloca(ptr %a, i64 %2, i8 1) #0
  %4 = getelementptr ptr, ptr %0, i32 0
  store ptr %3, ptr %4, align 8
  call void @__objsan_post_function(i32 1, ptr %0) #0
  ret ptr %3
}

declare ptr @__objsan_post_alloca(ptr, i64, i8)

declare void @__objsan_post_function(i32, ptr)

define private void @__objsan_ctor() {
entry:
  ret void
}

attributes #0 = { willreturn }
