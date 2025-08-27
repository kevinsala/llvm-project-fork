; ModuleID = 'loop.c'
source_filename = "loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = dso_local local_unnamed_addr global ptr null, align 8
@B = dso_local local_unnamed_addr global [1000 x double] zeroinitializer, align 16

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local double @func1(double noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %47, label %4

4:                                                ; preds = %2
  %5 = load ptr, ptr @A, align 8, !tbaa !5
  %6 = icmp ult i64 %1, 4
  br i1 %6, label %7, label %9

7:                                                ; preds = %19, %4
  %8 = phi i64 [ 0, %4 ], [ %10, %19 ]
  br label %27

9:                                                ; preds = %4
  %10 = and i64 %1, -4
  %11 = insertelement <2 x double> poison, double %0, i64 0
  %12 = shufflevector <2 x double> %11, <2 x double> poison, <2 x i32> zeroinitializer
  br label %13

13:                                               ; preds = %13, %9
  %14 = phi i64 [ 0, %9 ], [ %17, %13 ]
  %15 = getelementptr inbounds double, ptr %5, i64 %14
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 16
  store <2 x double> %12, ptr %15, align 8, !tbaa !10
  store <2 x double> %12, ptr %16, align 8, !tbaa !10
  %17 = add nuw i64 %14, 4
  %18 = icmp eq i64 %17, %10
  br i1 %18, label %19, label %13, !llvm.loop !12

19:                                               ; preds = %13
  %20 = icmp eq i64 %1, %10
  br i1 %20, label %21, label %7

21:                                               ; preds = %27, %19
  %22 = load ptr, ptr @A, align 8, !tbaa !5
  %23 = and i64 %1, 7
  %24 = icmp ult i64 %1, 8
  br i1 %24, label %32, label %25

25:                                               ; preds = %21
  %26 = and i64 %1, -8
  br label %49

27:                                               ; preds = %7, %27
  %28 = phi i64 [ %30, %27 ], [ %8, %7 ]
  %29 = getelementptr inbounds nuw double, ptr %5, i64 %28
  store double %0, ptr %29, align 8, !tbaa !10
  %30 = add nuw i64 %28, 1
  %31 = icmp eq i64 %30, %1
  br i1 %31, label %21, label %27, !llvm.loop !16

32:                                               ; preds = %49, %21
  %33 = phi double [ poison, %21 ], [ %83, %49 ]
  %34 = phi i64 [ 0, %21 ], [ %84, %49 ]
  %35 = phi double [ 0.000000e+00, %21 ], [ %83, %49 ]
  %36 = icmp eq i64 %23, 0
  br i1 %36, label %47, label %37

37:                                               ; preds = %32, %37
  %38 = phi i64 [ %44, %37 ], [ %34, %32 ]
  %39 = phi double [ %43, %37 ], [ %35, %32 ]
  %40 = phi i64 [ %45, %37 ], [ 0, %32 ]
  %41 = getelementptr inbounds nuw double, ptr %22, i64 %38
  %42 = load double, ptr %41, align 8, !tbaa !10
  %43 = fadd double %39, %42
  %44 = add nuw nsw i64 %38, 1
  %45 = add i64 %40, 1
  %46 = icmp eq i64 %45, %23
  br i1 %46, label %47, label %37, !llvm.loop !17

47:                                               ; preds = %32, %37, %2
  %48 = phi double [ 0.000000e+00, %2 ], [ %33, %32 ], [ %43, %37 ]
  ret double %48

49:                                               ; preds = %49, %25
  %50 = phi i64 [ 0, %25 ], [ %84, %49 ]
  %51 = phi double [ 0.000000e+00, %25 ], [ %83, %49 ]
  %52 = phi i64 [ 0, %25 ], [ %85, %49 ]
  %53 = getelementptr inbounds nuw double, ptr %22, i64 %50
  %54 = load double, ptr %53, align 8, !tbaa !10
  %55 = fadd double %51, %54
  %56 = or disjoint i64 %50, 1
  %57 = getelementptr inbounds nuw double, ptr %22, i64 %56
  %58 = load double, ptr %57, align 8, !tbaa !10
  %59 = fadd double %55, %58
  %60 = or disjoint i64 %50, 2
  %61 = getelementptr inbounds nuw double, ptr %22, i64 %60
  %62 = load double, ptr %61, align 8, !tbaa !10
  %63 = fadd double %59, %62
  %64 = or disjoint i64 %50, 3
  %65 = getelementptr inbounds nuw double, ptr %22, i64 %64
  %66 = load double, ptr %65, align 8, !tbaa !10
  %67 = fadd double %63, %66
  %68 = or disjoint i64 %50, 4
  %69 = getelementptr inbounds nuw double, ptr %22, i64 %68
  %70 = load double, ptr %69, align 8, !tbaa !10
  %71 = fadd double %67, %70
  %72 = or disjoint i64 %50, 5
  %73 = getelementptr inbounds nuw double, ptr %22, i64 %72
  %74 = load double, ptr %73, align 8, !tbaa !10
  %75 = fadd double %71, %74
  %76 = or disjoint i64 %50, 6
  %77 = getelementptr inbounds nuw double, ptr %22, i64 %76
  %78 = load double, ptr %77, align 8, !tbaa !10
  %79 = fadd double %75, %78
  %80 = or disjoint i64 %50, 7
  %81 = getelementptr inbounds nuw double, ptr %22, i64 %80
  %82 = load double, ptr %81, align 8, !tbaa !10
  %83 = fadd double %79, %82
  %84 = add nuw nsw i64 %50, 8
  %85 = add i64 %52, 8
  %86 = icmp eq i64 %85, %26
  br i1 %86, label %32, label %49, !llvm.loop !19
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local double @func2(double noundef %0, i64 noundef %1) local_unnamed_addr #1 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %45, label %4

4:                                                ; preds = %2
  %5 = icmp ult i64 %1, 4
  br i1 %5, label %6, label %8

6:                                                ; preds = %18, %4
  %7 = phi i64 [ 0, %4 ], [ %9, %18 ]
  br label %25

8:                                                ; preds = %4
  %9 = and i64 %1, -4
  %10 = insertelement <2 x double> poison, double %0, i64 0
  %11 = shufflevector <2 x double> %10, <2 x double> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %8
  %13 = phi i64 [ 0, %8 ], [ %16, %12 ]
  %14 = getelementptr inbounds [1000 x double], ptr @B, i64 0, i64 %13
  %15 = getelementptr inbounds nuw i8, ptr %14, i64 16
  store <2 x double> %11, ptr %14, align 16, !tbaa !10
  store <2 x double> %11, ptr %15, align 16, !tbaa !10
  %16 = add nuw i64 %13, 4
  %17 = icmp eq i64 %16, %9
  br i1 %17, label %18, label %12, !llvm.loop !20

18:                                               ; preds = %12
  %19 = icmp eq i64 %1, %9
  br i1 %19, label %20, label %6

20:                                               ; preds = %25, %18
  %21 = and i64 %1, 3
  %22 = icmp ult i64 %1, 4
  br i1 %22, label %30, label %23

23:                                               ; preds = %20
  %24 = and i64 %1, -4
  br label %47

25:                                               ; preds = %6, %25
  %26 = phi i64 [ %28, %25 ], [ %7, %6 ]
  %27 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %26
  store double %0, ptr %27, align 8, !tbaa !10
  %28 = add nuw i64 %26, 1
  %29 = icmp eq i64 %28, %1
  br i1 %29, label %20, label %25, !llvm.loop !21

30:                                               ; preds = %47, %20
  %31 = phi double [ poison, %20 ], [ %65, %47 ]
  %32 = phi i64 [ 0, %20 ], [ %66, %47 ]
  %33 = phi double [ 0.000000e+00, %20 ], [ %65, %47 ]
  %34 = icmp eq i64 %21, 0
  br i1 %34, label %45, label %35

35:                                               ; preds = %30, %35
  %36 = phi i64 [ %42, %35 ], [ %32, %30 ]
  %37 = phi double [ %41, %35 ], [ %33, %30 ]
  %38 = phi i64 [ %43, %35 ], [ 0, %30 ]
  %39 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %36
  %40 = load double, ptr %39, align 8, !tbaa !10
  %41 = fadd double %37, %40
  %42 = add nuw nsw i64 %36, 1
  %43 = add i64 %38, 1
  %44 = icmp eq i64 %43, %21
  br i1 %44, label %45, label %35, !llvm.loop !22

45:                                               ; preds = %30, %35, %2
  %46 = phi double [ 0.000000e+00, %2 ], [ %31, %30 ], [ %41, %35 ]
  ret double %46

47:                                               ; preds = %47, %23
  %48 = phi i64 [ 0, %23 ], [ %66, %47 ]
  %49 = phi double [ 0.000000e+00, %23 ], [ %65, %47 ]
  %50 = phi i64 [ 0, %23 ], [ %67, %47 ]
  %51 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %48
  %52 = load double, ptr %51, align 16, !tbaa !10
  %53 = fadd double %49, %52
  %54 = or disjoint i64 %48, 1
  %55 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %54
  %56 = load double, ptr %55, align 8, !tbaa !10
  %57 = fadd double %53, %56
  %58 = or disjoint i64 %48, 2
  %59 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %58
  %60 = load double, ptr %59, align 16, !tbaa !10
  %61 = fadd double %57, %60
  %62 = or disjoint i64 %48, 3
  %63 = getelementptr inbounds nuw [1000 x double], ptr @B, i64 0, i64 %62
  %64 = load double, ptr %63, align 8, !tbaa !10
  %65 = fadd double %61, %64
  %66 = add nuw nsw i64 %48, 4
  %67 = add i64 %50, 4
  %68 = icmp eq i64 %67, %24
  br i1 %68, label %30, label %47, !llvm.loop !23
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local double @func3(ptr captures(none) noundef %0, double noundef %1, i64 noundef %2) local_unnamed_addr #2 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %46, label %5

5:                                                ; preds = %3
  %6 = icmp ult i64 %2, 4
  br i1 %6, label %7, label %9

7:                                                ; preds = %19, %5
  %8 = phi i64 [ 0, %5 ], [ %10, %19 ]
  br label %26

9:                                                ; preds = %5
  %10 = and i64 %2, -4
  %11 = insertelement <2 x double> poison, double %1, i64 0
  %12 = shufflevector <2 x double> %11, <2 x double> poison, <2 x i32> zeroinitializer
  br label %13

13:                                               ; preds = %13, %9
  %14 = phi i64 [ 0, %9 ], [ %17, %13 ]
  %15 = getelementptr inbounds double, ptr %0, i64 %14
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 16
  store <2 x double> %12, ptr %15, align 8, !tbaa !10
  store <2 x double> %12, ptr %16, align 8, !tbaa !10
  %17 = add nuw i64 %14, 4
  %18 = icmp eq i64 %17, %10
  br i1 %18, label %19, label %13, !llvm.loop !24

19:                                               ; preds = %13
  %20 = icmp eq i64 %2, %10
  br i1 %20, label %21, label %7

21:                                               ; preds = %26, %19
  %22 = and i64 %2, 7
  %23 = icmp ult i64 %2, 8
  br i1 %23, label %31, label %24

24:                                               ; preds = %21
  %25 = and i64 %2, -8
  br label %48

26:                                               ; preds = %7, %26
  %27 = phi i64 [ %29, %26 ], [ %8, %7 ]
  %28 = getelementptr inbounds nuw double, ptr %0, i64 %27
  store double %1, ptr %28, align 8, !tbaa !10
  %29 = add nuw i64 %27, 1
  %30 = icmp eq i64 %29, %2
  br i1 %30, label %21, label %26, !llvm.loop !25

31:                                               ; preds = %48, %21
  %32 = phi double [ poison, %21 ], [ %82, %48 ]
  %33 = phi i64 [ 0, %21 ], [ %83, %48 ]
  %34 = phi double [ 0.000000e+00, %21 ], [ %82, %48 ]
  %35 = icmp eq i64 %22, 0
  br i1 %35, label %46, label %36

36:                                               ; preds = %31, %36
  %37 = phi i64 [ %43, %36 ], [ %33, %31 ]
  %38 = phi double [ %42, %36 ], [ %34, %31 ]
  %39 = phi i64 [ %44, %36 ], [ 0, %31 ]
  %40 = getelementptr inbounds nuw double, ptr %0, i64 %37
  %41 = load double, ptr %40, align 8, !tbaa !10
  %42 = fadd double %38, %41
  %43 = add nuw nsw i64 %37, 1
  %44 = add i64 %39, 1
  %45 = icmp eq i64 %44, %22
  br i1 %45, label %46, label %36, !llvm.loop !26

46:                                               ; preds = %31, %36, %3
  %47 = phi double [ 0.000000e+00, %3 ], [ %32, %31 ], [ %42, %36 ]
  ret double %47

48:                                               ; preds = %48, %24
  %49 = phi i64 [ 0, %24 ], [ %83, %48 ]
  %50 = phi double [ 0.000000e+00, %24 ], [ %82, %48 ]
  %51 = phi i64 [ 0, %24 ], [ %84, %48 ]
  %52 = getelementptr inbounds nuw double, ptr %0, i64 %49
  %53 = load double, ptr %52, align 8, !tbaa !10
  %54 = fadd double %50, %53
  %55 = or disjoint i64 %49, 1
  %56 = getelementptr inbounds nuw double, ptr %0, i64 %55
  %57 = load double, ptr %56, align 8, !tbaa !10
  %58 = fadd double %54, %57
  %59 = or disjoint i64 %49, 2
  %60 = getelementptr inbounds nuw double, ptr %0, i64 %59
  %61 = load double, ptr %60, align 8, !tbaa !10
  %62 = fadd double %58, %61
  %63 = or disjoint i64 %49, 3
  %64 = getelementptr inbounds nuw double, ptr %0, i64 %63
  %65 = load double, ptr %64, align 8, !tbaa !10
  %66 = fadd double %62, %65
  %67 = or disjoint i64 %49, 4
  %68 = getelementptr inbounds nuw double, ptr %0, i64 %67
  %69 = load double, ptr %68, align 8, !tbaa !10
  %70 = fadd double %66, %69
  %71 = or disjoint i64 %49, 5
  %72 = getelementptr inbounds nuw double, ptr %0, i64 %71
  %73 = load double, ptr %72, align 8, !tbaa !10
  %74 = fadd double %70, %73
  %75 = or disjoint i64 %49, 6
  %76 = getelementptr inbounds nuw double, ptr %0, i64 %75
  %77 = load double, ptr %76, align 8, !tbaa !10
  %78 = fadd double %74, %77
  %79 = or disjoint i64 %49, 7
  %80 = getelementptr inbounds nuw double, ptr %0, i64 %79
  %81 = load double, ptr %80, align 8, !tbaa !10
  %82 = fadd double %78, %81
  %83 = add nuw nsw i64 %49, 8
  %84 = add i64 %51, 8
  %85 = icmp eq i64 %84, %25
  br i1 %85, label %31, label %48, !llvm.loop !27
}

attributes #0 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 20.0.0git (https://github.com/jdoerfert/llvm-project.git 035afa9b5a6f2a0275c2d47d184e90ed2a7eac31)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"p1 double", !7, i64 0}
!7 = !{!"any pointer", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"double", !8, i64 0}
!12 = distinct !{!12, !13, !14, !15}
!13 = !{!"llvm.loop.mustprogress"}
!14 = !{!"llvm.loop.isvectorized", i32 1}
!15 = !{!"llvm.loop.unroll.runtime.disable"}
!16 = distinct !{!16, !13, !15, !14}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.unroll.disable"}
!19 = distinct !{!19, !13}
!20 = distinct !{!20, !13, !14, !15}
!21 = distinct !{!21, !13, !15, !14}
!22 = distinct !{!22, !18}
!23 = distinct !{!23, !13}
!24 = distinct !{!24, !13, !14, !15}
!25 = distinct !{!25, !13, !15, !14}
!26 = distinct !{!26, !18}
!27 = distinct !{!27, !13}
