; ModuleID = 'external_funcs.c'
source_filename = "external_funcs.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__objsan_shadow.stdout = weak global ptr @stdout
@stdout = external local_unnamed_addr global ptr, align 8
@__objsan_shadow..str = private global ptr poison
@.str = private unnamed_addr constant [10 x i8] c"%f %d %p\0A\00", align 1
@__objsan_value_pack = internal global <{ i32, i32, ptr }> <{ i32 8, i32 14, ptr null }>
@__objsan_value_pack.1 = internal global <{ i32, i32, ptr, i32, i32, ptr, i32, i32, ptr }> <{ i32 8, i32 14, ptr null, i32 8, i32 14, ptr @.str, i32 8, i32 14, ptr null }>
@__objsan_value_pack.2 = internal global <{ i32, i32, [4 x i8], i32, i32, i32, ptr }> <{ i32 4, i32 12, [4 x i8] zeroinitializer, i32 0, i32 8, i32 14, ptr null }>
@__objsan_value_pack.3 = internal global <{ i32, i32, ptr, i32, i32, ptr }> <{ i32 8, i32 14, ptr null, i32 8, i32 14, ptr null }>
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter_func_def1 = alias ptr (double, ptr), ptr @func_def1
@__adapter_func_def2 = alias double (i32), ptr @func_def2
@__adapter_main = alias i32 (i32, ptr), ptr @main

; Function Attrs: mustprogress nofree norecurse nosync nounwind sanitize_obj willreturn memory(argmem: write) uwtable
define dso_local noundef ptr @func_def1(double noundef %a, ptr noundef returned writeonly initializes((0, 8)) %b) local_unnamed_addr #0 {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %b, ptr nonnull %1, ptr nonnull %0) #7
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = call ptr @__objsan_get_mptr(ptr %b, ptr %2, i8 %4) #8
  %6 = call ptr @__objsan_pre_store_m(ptr %5, ptr %2, ptr null, i64 8, i64 %3, i8 %4, i8 0) #7
  store double %a, ptr %6, align 8, !tbaa !5
  ret ptr %b
}

; Function Attrs: nounwind sanitize_obj uwtable
define dso_local double @func_def2(i32 noundef %a) local_unnamed_addr #1 {
entry:
  %0 = alloca <{ i32, i32, ptr, i32, i32, ptr, i32, i32, ptr }>, align 8
  %1 = alloca i8, align 1
  %2 = alloca i64, align 8
  %3 = alloca <{ i32, i32, ptr }>, align 8
  %b = alloca double, align 8
  %4 = load ptr, ptr @__objsan_shadow.stdout, align 8
  %5 = call ptr @__objsan_post_base_pointer_info(ptr %4, ptr nonnull %2, ptr nonnull %1) #7
  %6 = load i64, ptr %2, align 8
  %7 = load i8, ptr %1, align 1
  %8 = call ptr @__objsan_get_mptr(ptr %4, ptr %5, i8 %7) #8
  %9 = call ptr @__objsan_pre_load(ptr %4, ptr %5, ptr null, i64 8, i64 %6, i8 %7, i8 0) #7
  %10 = call ptr @__objsan_post_alloca(ptr nonnull %b, i64 8, i8 1) #7
  %11 = getelementptr inbounds nuw i8, ptr %10, i64 8
  %12 = call ptr @__objsan_post_loop_value_ptr_range(ptr %10, ptr nonnull %11, i64 0, ptr nonnull %b, i64 8, i8 2, i8 1) #8
  %13 = call ptr @__objsan_post_base_pointer_info(ptr %10, ptr nonnull %2, ptr nonnull %1) #7
  %c = alloca double, align 8
  %14 = call ptr @__objsan_post_alloca(ptr nonnull %c, i64 8, i8 1) #7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %15 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %10, ptr %15, align 8
  call void @__objsan_pre_call(i64 211, i32 1, ptr nonnull %3, i8 0) #7
  %16 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %17 = load ptr, ptr %16, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %17) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %18 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %14, ptr %18, align 8
  call void @__objsan_pre_call(i64 211, i32 1, ptr nonnull %3, i8 0) #7
  %19 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %20 = load ptr, ptr %19, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %20) #8
  %conv = sitofp i32 %a to double
  store double %conv, ptr %b, align 8, !tbaa !5
  %call1 = call ptr @__adapter_func_decl(ptr noundef nonnull %10, double noundef %conv, ptr noundef nonnull %14) #8
  call fastcc void @func_int(ptr noundef %10, ptr noundef %14)
  %21 = load ptr, ptr %9, align 8, !tbaa !9
  %22 = load double, ptr %b, align 8, !tbaa !5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %0, ptr noundef nonnull align 16 dereferenceable(48) @__objsan_value_pack.1, i64 48, i1 false)
  %23 = getelementptr inbounds nuw i8, ptr %0, i64 8
  store ptr %21, ptr %23, align 8
  %24 = getelementptr inbounds nuw i8, ptr %0, i64 40
  store ptr %14, ptr %24, align 8
  call void @__objsan_pre_call(i64 0, i32 3, ptr nonnull %0, i8 0) #7
  %25 = getelementptr inbounds nuw i8, ptr %0, i64 8
  %26 = load ptr, ptr %25, align 8
  %27 = getelementptr inbounds nuw i8, ptr %0, i64 24
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds nuw i8, ptr %0, i64 40
  %30 = load ptr, ptr %29, align 8
  %call3 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %26, ptr noundef nonnull captures(none) %28, double noundef %22, i32 noundef %a, ptr noundef nonnull %30) #8
  %31 = load double, ptr %b, align 8, !tbaa !5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %32 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %14, ptr %32, align 8
  call void @__objsan_pre_call(i64 210, i32 1, ptr nonnull %3, i8 0) #7
  %33 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %34 = load ptr, ptr %33, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %34) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %3, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %35 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %10, ptr %35, align 8
  call void @__objsan_pre_call(i64 210, i32 1, ptr nonnull %3, i8 0) #7
  %36 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %37 = load ptr, ptr %36, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %37) #8
  store ptr %10, ptr %3, align 8
  %38 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %14, ptr %38, align 8
  call void @__objsan_post_function(i32 2, ptr nonnull %3) #7
  ret double %31
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #2

declare ptr @func_decl(ptr noundef, double noundef, ptr noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind sanitize_obj willreturn memory(argmem: readwrite) uwtable
define internal fastcc void @func_int(ptr noundef nonnull writeonly captures(none) initializes((0, 8)) %a, ptr noundef nonnull readonly captures(none) %b) unnamed_addr #4 {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr nonnull %a, ptr nonnull %1, ptr nonnull %0) #7
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = call ptr @__objsan_get_mptr(ptr nonnull %a, ptr %2, i8 %4) #8
  %6 = call ptr @__objsan_pre_store_m(ptr %5, ptr %2, ptr null, i64 8, i64 %3, i8 %4, i8 0) #7
  %7 = call ptr @__objsan_post_base_pointer_info(ptr nonnull %b, ptr nonnull %1, ptr nonnull %0) #7
  %8 = load i64, ptr %1, align 8
  %9 = load i8, ptr %0, align 1
  %10 = call ptr @__objsan_get_mptr(ptr nonnull %b, ptr %7, i8 %9) #8
  %11 = call ptr @__objsan_pre_load_m(ptr %10, ptr %7, ptr null, i64 8, i64 %8, i8 %9, i8 0) #7
  %12 = load double, ptr %11, align 8, !tbaa !5
  store double %12, ptr %6, align 8, !tbaa !5
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #2

; Function Attrs: nounwind sanitize_obj uwtable
define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef readnone captures(none) %argv) local_unnamed_addr #1 {
entry:
  %0 = alloca <{ i32, i32, [4 x i8], i32, i32, i32, ptr }>, align 8
  %1 = alloca <{ i32, i32, ptr, i32, i32, ptr, i32, i32, ptr }>, align 8
  %2 = alloca i8, align 1
  %3 = alloca i64, align 8
  %4 = alloca <{ i32, i32, ptr }>, align 8
  %b.i = alloca double, align 8
  %5 = load ptr, ptr @__objsan_shadow.stdout, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 16 dereferenceable(32) @__objsan_value_pack.2, i64 32, i1 false)
  %6 = getelementptr inbounds nuw i8, ptr %0, i64 12
  store i32 %argc, ptr %6, align 4
  %7 = getelementptr inbounds nuw i8, ptr %0, i64 24
  store ptr %argv, ptr %7, align 8
  call void @__objsan_pre_function(i32 2, ptr nonnull %0) #7
  %8 = getelementptr inbounds nuw i8, ptr %0, i64 12
  %9 = load i32, ptr %8, align 4
  %10 = call ptr @__objsan_post_base_pointer_info(ptr %5, ptr nonnull %3, ptr nonnull %2) #7
  %11 = load i64, ptr %3, align 8
  %12 = load i8, ptr %2, align 1
  %13 = call ptr @__objsan_get_mptr(ptr %5, ptr %10, i8 %12) #8
  %14 = call ptr @__objsan_pre_load(ptr %5, ptr %10, ptr null, i64 8, i64 %11, i8 %12, i8 0) #7
  %15 = call ptr @__objsan_post_alloca(ptr nonnull %b.i, i64 8, i8 1) #7
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 8
  %17 = call ptr @__objsan_post_loop_value_ptr_range(ptr %15, ptr nonnull %16, i64 0, ptr nonnull %b.i, i64 8, i8 2, i8 1) #8
  %18 = call ptr @__objsan_post_base_pointer_info(ptr %15, ptr nonnull %3, ptr nonnull %2) #7
  %c.i = alloca double, align 8
  %19 = call ptr @__objsan_post_alloca(ptr nonnull %c.i, i64 8, i8 1) #7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %4, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %20 = getelementptr inbounds nuw i8, ptr %4, i64 8
  store ptr %15, ptr %20, align 8
  call void @__objsan_pre_call(i64 211, i32 1, ptr nonnull %4, i8 0) #7
  %21 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %22 = load ptr, ptr %21, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %22) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %4, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %23 = getelementptr inbounds nuw i8, ptr %4, i64 8
  store ptr %19, ptr %23, align 8
  call void @__objsan_pre_call(i64 211, i32 1, ptr nonnull %4, i8 0) #7
  %24 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %25 = load ptr, ptr %24, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %25) #8
  %conv.i = sitofp i32 %9 to double
  store double %conv.i, ptr %b.i, align 8, !tbaa !5
  %call1.i = call ptr @__adapter_func_decl(ptr noundef nonnull %15, double noundef %conv.i, ptr noundef nonnull %19) #8
  call fastcc void @func_int(ptr noundef %15, ptr noundef %19)
  %26 = load ptr, ptr %14, align 8, !tbaa !9
  %27 = load double, ptr %b.i, align 8, !tbaa !5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %1, ptr noundef nonnull align 16 dereferenceable(48) @__objsan_value_pack.1, i64 48, i1 false)
  %28 = getelementptr inbounds nuw i8, ptr %1, i64 8
  store ptr %26, ptr %28, align 8
  %29 = getelementptr inbounds nuw i8, ptr %1, i64 40
  store ptr %19, ptr %29, align 8
  call void @__objsan_pre_call(i64 0, i32 3, ptr nonnull %1, i8 0) #7
  %30 = getelementptr inbounds nuw i8, ptr %1, i64 8
  %31 = load ptr, ptr %30, align 8
  %32 = getelementptr inbounds nuw i8, ptr %1, i64 24
  %33 = load ptr, ptr %32, align 8
  %34 = getelementptr inbounds nuw i8, ptr %1, i64 40
  %35 = load ptr, ptr %34, align 8
  %call3.i = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %31, ptr noundef nonnull captures(none) %33, double noundef %27, i32 noundef %9, ptr noundef nonnull %35) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %4, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %36 = getelementptr inbounds nuw i8, ptr %4, i64 8
  store ptr %19, ptr %36, align 8
  call void @__objsan_pre_call(i64 210, i32 1, ptr nonnull %4, i8 0) #7
  %37 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %38 = load ptr, ptr %37, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %38) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %4, ptr noundef nonnull align 8 dereferenceable(16) @__objsan_value_pack, i64 16, i1 false)
  %39 = getelementptr inbounds nuw i8, ptr %4, i64 8
  store ptr %15, ptr %39, align 8
  call void @__objsan_pre_call(i64 210, i32 1, ptr nonnull %4, i8 0) #7
  %40 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %41 = load ptr, ptr %40, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %41) #8
  store ptr %15, ptr %4, align 8
  %42 = getelementptr inbounds nuw i8, ptr %4, i64 8
  store ptr %19, ptr %42, align 8
  call void @__objsan_post_function(i32 2, ptr nonnull %4) #7
  ret i32 0
}

define weak ptr @__adapter_func_decl(ptr noundef %0, double noundef %1, ptr noundef %2) local_unnamed_addr #3 {
entry:
  %3 = alloca <{ i32, i32, ptr, i32, i32, ptr }>, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %3, ptr noundef nonnull align 16 dereferenceable(32) @__objsan_value_pack.3, i64 32, i1 false)
  %4 = getelementptr inbounds nuw i8, ptr %3, i64 8
  store ptr %0, ptr %4, align 8
  %5 = getelementptr inbounds nuw i8, ptr %3, i64 24
  store ptr %2, ptr %5, align 8
  call void @__objsan_pre_call(i64 0, i32 2, ptr nonnull %3, i8 0) #9
  %6 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %7 = load ptr, ptr %6, align 8
  %8 = getelementptr inbounds nuw i8, ptr %3, i64 24
  %9 = load ptr, ptr %8, align 8
  %10 = call ptr @func_decl(ptr %7, double %1, ptr %9)
  ret ptr %10
}

declare ptr @__objsan_post_base_pointer_info(ptr, ptr, ptr)

declare ptr @__objsan_get_mptr(ptr, ptr, i8)

declare ptr @__objsan_post_alloca(ptr, i64, i8)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #6

declare void @__objsan_pre_call(i64, i32, ptr, i8)

declare ptr @__objsan_pre_load(ptr, ptr, ptr, i64, i64, i8, i8)

declare void @__objsan_post_function(i32, ptr)

declare void @__objsan_pre_function(i32, ptr)

define private void @__objsan_ctor() {
entry:
  %0 = call ptr @__objsan_pre_global(ptr nonnull @stdout, i32 0, i8 0, i8 1) #9
  %1 = call ptr @__objsan_pre_global(ptr nonnull @.str, i32 10, i8 1, i8 0) #9
  store ptr %1, ptr @__objsan_shadow..str, align 8
  ret void
}

declare ptr @__objsan_pre_global(ptr, i32, i8, i8)

declare ptr @__objsan_pre_load_m(ptr, ptr, ptr, i64, i64, i8, i8)

declare ptr @__objsan_pre_store_m(ptr, ptr, ptr, i64, i64, i8, i8)

declare ptr @__objsan_post_loop_value_ptr_range(ptr, ptr, i64, ptr, i64, i8, i8)

attributes #0 = { mustprogress nofree norecurse nosync nounwind sanitize_obj willreturn memory(argmem: write) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind sanitize_obj uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree noinline norecurse nosync nounwind sanitize_obj willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nounwind willreturn }
attributes #8 = { nounwind }
attributes #9 = { willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git e2960649024cec893b9e82e59f0879c0ce164583)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"p1 _ZTS8_IO_FILE", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
