; ModuleID = 'branch.ll'
source_filename = "branch.ll"

@__instrumentor_.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@__instrumentor_value_pack = internal global <{ i32, i32, [7 x i8], i1 }> <{ i32 1, i32 12, [7 x i8] zeroinitializer, i1 false }>
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__instrumentor_ctor, ptr null }]
@__instrumentor_.str.1 = private unnamed_addr constant [10 x i8] c"branch.ll\00", align 1
@__instrumentor_.str.2 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__instrumentor_dtor, ptr null }]

define i32 @foo(i1 %c) {
entry:
  %0 = alloca <{ i32, i32, [7 x i8], i1 }>, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr @__instrumentor_value_pack, i64 16, i1 false)
  %1 = getelementptr inbounds nuw <{ i32, i32, [7 x i8], i1 }>, ptr %0, i32 0, i32 3
  store i1 %c, ptr %1, align 1
  call void @__instrumentor_pre_function(ptr @foo, ptr @__instrumentor_.str, i32 1, ptr %0, i8 0) #1
  %2 = getelementptr inbounds i8, ptr %0, i32 8
  %3 = load i1, ptr %2, align 1
  %4 = zext i1 %3 to i8
  %5 = call i8 @__instrumentor_pre_br(i8 1, i8 %4, i64 2) #1
  %6 = trunc i8 %5 to i1
  br i1 %6, label %a, label %b

a:                                                ; preds = %entry
  ret i32 0

b:                                                ; preds = %entry
  %7 = call i8 @__instrumentor_pre_br(i8 0, i8 1, i64 1) #1
  br label %d

d:                                                ; preds = %b
  ret i32 1
}

declare i8 @__instrumentor_pre_br(i8, i8, i64)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #0

declare void @__instrumentor_pre_function(ptr, ptr, i32, ptr, i8)

define private void @__instrumentor_ctor() {
entry:
  call void @__instrumentor_pre_module(ptr @__instrumentor_.str.1, ptr @__instrumentor_.str.2) #1
  ret void
}

declare void @__instrumentor_pre_module(ptr, ptr)

define private void @__instrumentor_dtor() {
entry:
  call void @__instrumentor_post_module(ptr @__instrumentor_.str.1, ptr @__instrumentor_.str.2) #1
  ret void
}

declare void @__instrumentor_post_module(ptr, ptr)

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { willreturn }
