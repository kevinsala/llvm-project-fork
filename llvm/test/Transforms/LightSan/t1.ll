; ModuleID = 't1.c'
source_filename = "t1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = dso_local global double 0.000000e+00, align 8
@B = dso_local local_unnamed_addr global ptr null, align 8
@stdout = external local_unnamed_addr global ptr, align 8
@.str = private unnamed_addr constant [13 x i8] c"%f %d %p %p\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

@Sentinel = external global ptr, align 8
@Shadow = dso_local global ptr @Sentinel, align 8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) uwtable
define dso_local noundef i32 @foo(i32 noundef returned %0, ptr noundef writeonly captures(none) initializes((0, 8)) %1) local_unnamed_addr #0 {
  %3 = sitofp i32 %0 to double
  store double %3, ptr %1, align 8, !tbaa !5
  ret i32 %0
}

; Function Attrs: nounwind uwtable
define dso_local double @bar(i32 noundef %0) local_unnamed_addr #1 {
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %2) #6
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #6
  %4 = sitofp i32 %0 to double
  store double %4, ptr %2, align 8, !tbaa !5
  %5 = call ptr @foobar(double noundef %4, ptr noundef nonnull %2) #6
  %6 = load ptr, ptr @stdout, align 8, !tbaa !9
  %7 = load double, ptr %2, align 8, !tbaa !5
  %8 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %6, ptr noundef nonnull @.str, double noundef %7, i32 noundef %0, ptr noundef nonnull @A, ptr noundef nonnull %3) #6
  %9 = load double, ptr %2, align 8, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #6
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %2) #6
  ret double %9
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #2

declare ptr @foobar(double noundef, ptr noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #2

; Function Attrs: nofree nounwind uwtable
define dso_local noundef double @bar2(i32 noundef %0) local_unnamed_addr #5 {
  %2 = load ptr, ptr @stdout, align 8, !tbaa !9
  %3 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %2, ptr noundef nonnull @.str.1, i32 noundef %0) #6
  ret double 0.000000e+00
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr noundef readnone captures(none) %1) local_unnamed_addr #1 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #6
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #6
  %5 = sitofp i32 %0 to double
  store double %5, ptr %3, align 8, !tbaa !5
  %6 = call ptr @foobar(double noundef %5, ptr noundef nonnull %3) #6
  %7 = load ptr, ptr @stdout, align 8, !tbaa !9
  %8 = load double, ptr %3, align 8, !tbaa !5
  %9 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %7, ptr noundef nonnull @.str, double noundef %8, i32 noundef %0, ptr noundef nonnull @A, ptr noundef nonnull %4) #6
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #6
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #6
  %10 = load ptr, ptr @stdout, align 8, !tbaa !9
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef nonnull @.str.1, i32 noundef %0) #6
  %12 = load ptr, ptr @B, align 8, !tbaa !12
  %13 = call ptr @foobar(double noundef %5, ptr noundef %12) #6
  ret i32 0
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 21.0.0git (https://github.com/jdoerfert/llvm-project.git 4083f0d3db28355305541623c82f40052928b3c4)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"p1 _ZTS8_IO_FILE", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !13, i64 0}
!13 = !{!"p1 double", !11, i64 0}
