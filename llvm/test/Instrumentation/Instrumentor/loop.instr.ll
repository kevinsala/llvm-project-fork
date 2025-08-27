; ModuleID = 'loop.ll'
source_filename = "loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = dso_local local_unnamed_addr global ptr null, align 8
@B = dso_local local_unnamed_addr global [1000 x double] zeroinitializer, align 16
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__instrumentor_ctor, ptr null }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__instrumentor_dtor, ptr null }]
@__instrumentor_str = private unnamed_addr constant [8 x i8] c"loop.ll\00", align 1
@__instrumentor_str.1 = private unnamed_addr constant [25 x i8] c"x86_64-unknown-linux-gnu\00", align 1
@__instrumentor_A = global ptr null
@__instrumentor_str.2 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@__instrumentor_B = global ptr null
@__instrumentor_str.3 = private unnamed_addr constant [2 x i8] c"B\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local double @func1(double noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = alloca <2 x double>, align 16
  %4 = icmp eq i64 %1, 0
  br i1 %4, label %66, label %5

5:                                                ; preds = %2
  %6 = load ptr, ptr @__instrumentor_A, align 8
  %7 = call ptr @__instrumentor_pre_load(ptr %6, i32 0, i64 8, i32 14, i64 8, i32 0, i8 1, i8 0, ptr null)
  %8 = load ptr, ptr %7, align 8, !tbaa !5
  %9 = ptrtoint ptr %8 to i64
  %10 = call i64 @__instrumentor_post_load(ptr %7, i32 0, i64 %9, i64 8, i32 14, i64 8, i32 0, i8 1, i8 0, ptr null)
  %11 = inttoptr i64 %10 to ptr
  %12 = icmp ult i64 %1, 4
  br i1 %12, label %13, label %15

13:                                               ; preds = %27, %5
  %14 = phi i64 [ 0, %5 ], [ %16, %27 ]
  br label %40

15:                                               ; preds = %5
  %16 = and i64 %1, -4
  %17 = insertelement <2 x double> poison, double %0, i64 0
  %18 = shufflevector <2 x double> %17, <2 x double> poison, <2 x i32> zeroinitializer
  br label %19

19:                                               ; preds = %19, %15
  %20 = phi i64 [ 0, %15 ], [ %25, %19 ]
  %21 = getelementptr inbounds double, ptr %11, i64 %20
  %22 = getelementptr inbounds nuw i8, ptr %21, i64 16
  store <2 x double> %18, ptr %3, align 16
  %23 = call ptr @__instrumentor_pre_store_ind(ptr %21, i32 0, ptr %3, i64 16, i32 17, i64 8, i32 0, i8 1, i8 0, ptr null)
  store <2 x double> %18, ptr %23, align 8, !tbaa !10
  store <2 x double> %18, ptr %3, align 16
  %24 = call ptr @__instrumentor_pre_store_ind(ptr %22, i32 0, ptr %3, i64 16, i32 17, i64 8, i32 0, i8 1, i8 0, ptr null)
  store <2 x double> %18, ptr %24, align 8, !tbaa !10
  %25 = add nuw i64 %20, 4
  %26 = icmp eq i64 %25, %16
  br i1 %26, label %27, label %19, !llvm.loop !12

27:                                               ; preds = %19
  %28 = icmp eq i64 %1, %16
  br i1 %28, label %29, label %13

29:                                               ; preds = %40, %27
  %30 = load ptr, ptr @__instrumentor_A, align 8
  %31 = call ptr @__instrumentor_pre_load(ptr %30, i32 0, i64 8, i32 14, i64 8, i32 0, i8 1, i8 0, ptr null)
  %32 = load ptr, ptr %31, align 8, !tbaa !5
  %33 = ptrtoint ptr %32 to i64
  %34 = call i64 @__instrumentor_post_load(ptr %31, i32 0, i64 %33, i64 8, i32 14, i64 8, i32 0, i8 1, i8 0, ptr null)
  %35 = inttoptr i64 %34 to ptr
  %36 = and i64 %1, 7
  %37 = icmp ult i64 %1, 8
  br i1 %37, label %47, label %38

38:                                               ; preds = %29
  %39 = and i64 %1, -8
  br label %68

40:                                               ; preds = %40, %13
  %41 = phi i64 [ %45, %40 ], [ %14, %13 ]
  %42 = getelementptr inbounds nuw double, ptr %11, i64 %41
  %43 = bitcast double %0 to i64
  %44 = call ptr @__instrumentor_pre_store(ptr %42, i32 0, i64 %43, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  store double %0, ptr %44, align 8, !tbaa !10
  %45 = add nuw i64 %41, 1
  %46 = icmp eq i64 %45, %1
  br i1 %46, label %29, label %40, !llvm.loop !16

47:                                               ; preds = %68, %29
  %48 = phi double [ poison, %29 ], [ %134, %68 ]
  %49 = phi i64 [ 0, %29 ], [ %135, %68 ]
  %50 = phi double [ 0.000000e+00, %29 ], [ %134, %68 ]
  %51 = icmp eq i64 %36, 0
  br i1 %51, label %66, label %52

52:                                               ; preds = %52, %47
  %53 = phi i64 [ %63, %52 ], [ %49, %47 ]
  %54 = phi double [ %62, %52 ], [ %50, %47 ]
  %55 = phi i64 [ %64, %52 ], [ 0, %47 ]
  %56 = getelementptr inbounds nuw double, ptr %35, i64 %53
  %57 = call ptr @__instrumentor_pre_load(ptr %56, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %58 = load double, ptr %57, align 8, !tbaa !10
  %59 = bitcast double %58 to i64
  %60 = call i64 @__instrumentor_post_load(ptr %57, i32 0, i64 %59, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %61 = bitcast i64 %60 to double
  %62 = fadd double %54, %61
  %63 = add nuw nsw i64 %53, 1
  %64 = add i64 %55, 1
  %65 = icmp eq i64 %64, %36
  br i1 %65, label %66, label %52, !llvm.loop !17

66:                                               ; preds = %52, %47, %2
  %67 = phi double [ 0.000000e+00, %2 ], [ %48, %47 ], [ %62, %52 ]
  ret double %67

68:                                               ; preds = %68, %38
  %69 = phi i64 [ 0, %38 ], [ %135, %68 ]
  %70 = phi double [ 0.000000e+00, %38 ], [ %134, %68 ]
  %71 = phi i64 [ 0, %38 ], [ %136, %68 ]
  %72 = getelementptr inbounds nuw double, ptr %35, i64 %69
  %73 = call ptr @__instrumentor_pre_load(ptr %72, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %74 = load double, ptr %73, align 8, !tbaa !10
  %75 = bitcast double %74 to i64
  %76 = call i64 @__instrumentor_post_load(ptr %73, i32 0, i64 %75, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %77 = bitcast i64 %76 to double
  %78 = fadd double %70, %77
  %79 = or disjoint i64 %69, 1
  %80 = getelementptr inbounds nuw double, ptr %35, i64 %79
  %81 = call ptr @__instrumentor_pre_load(ptr %80, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %82 = load double, ptr %81, align 8, !tbaa !10
  %83 = bitcast double %82 to i64
  %84 = call i64 @__instrumentor_post_load(ptr %81, i32 0, i64 %83, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %85 = bitcast i64 %84 to double
  %86 = fadd double %78, %85
  %87 = or disjoint i64 %69, 2
  %88 = getelementptr inbounds nuw double, ptr %35, i64 %87
  %89 = call ptr @__instrumentor_pre_load(ptr %88, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %90 = load double, ptr %89, align 8, !tbaa !10
  %91 = bitcast double %90 to i64
  %92 = call i64 @__instrumentor_post_load(ptr %89, i32 0, i64 %91, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %93 = bitcast i64 %92 to double
  %94 = fadd double %86, %93
  %95 = or disjoint i64 %69, 3
  %96 = getelementptr inbounds nuw double, ptr %35, i64 %95
  %97 = call ptr @__instrumentor_pre_load(ptr %96, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %98 = load double, ptr %97, align 8, !tbaa !10
  %99 = bitcast double %98 to i64
  %100 = call i64 @__instrumentor_post_load(ptr %97, i32 0, i64 %99, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %101 = bitcast i64 %100 to double
  %102 = fadd double %94, %101
  %103 = or disjoint i64 %69, 4
  %104 = getelementptr inbounds nuw double, ptr %35, i64 %103
  %105 = call ptr @__instrumentor_pre_load(ptr %104, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %106 = load double, ptr %105, align 8, !tbaa !10
  %107 = bitcast double %106 to i64
  %108 = call i64 @__instrumentor_post_load(ptr %105, i32 0, i64 %107, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %109 = bitcast i64 %108 to double
  %110 = fadd double %102, %109
  %111 = or disjoint i64 %69, 5
  %112 = getelementptr inbounds nuw double, ptr %35, i64 %111
  %113 = call ptr @__instrumentor_pre_load(ptr %112, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %114 = load double, ptr %113, align 8, !tbaa !10
  %115 = bitcast double %114 to i64
  %116 = call i64 @__instrumentor_post_load(ptr %113, i32 0, i64 %115, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %117 = bitcast i64 %116 to double
  %118 = fadd double %110, %117
  %119 = or disjoint i64 %69, 6
  %120 = getelementptr inbounds nuw double, ptr %35, i64 %119
  %121 = call ptr @__instrumentor_pre_load(ptr %120, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %122 = load double, ptr %121, align 8, !tbaa !10
  %123 = bitcast double %122 to i64
  %124 = call i64 @__instrumentor_post_load(ptr %121, i32 0, i64 %123, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %125 = bitcast i64 %124 to double
  %126 = fadd double %118, %125
  %127 = or disjoint i64 %69, 7
  %128 = getelementptr inbounds nuw double, ptr %35, i64 %127
  %129 = call ptr @__instrumentor_pre_load(ptr %128, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %130 = load double, ptr %129, align 8, !tbaa !10
  %131 = bitcast double %130 to i64
  %132 = call i64 @__instrumentor_post_load(ptr %129, i32 0, i64 %131, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %133 = bitcast i64 %132 to double
  %134 = fadd double %126, %133
  %135 = add nuw nsw i64 %69, 8
  %136 = add i64 %71, 8
  %137 = icmp eq i64 %136, %39
  br i1 %137, label %47, label %68, !llvm.loop !19
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local double @func2(double noundef %0, i64 noundef %1) local_unnamed_addr #1 {
  %3 = alloca <2 x double>, align 16
  %4 = icmp eq i64 %1, 0
  br i1 %4, label %57, label %5

5:                                                ; preds = %2
  %6 = icmp ult i64 %1, 4
  br i1 %6, label %7, label %9

7:                                                ; preds = %22, %5
  %8 = phi i64 [ 0, %5 ], [ %10, %22 ]
  br label %29

9:                                                ; preds = %5
  %10 = and i64 %1, -4
  %11 = insertelement <2 x double> poison, double %0, i64 0
  %12 = shufflevector <2 x double> %11, <2 x double> poison, <2 x i32> zeroinitializer
  br label %13

13:                                               ; preds = %13, %9
  %14 = phi i64 [ 0, %9 ], [ %20, %13 ]
  %15 = load ptr, ptr @__instrumentor_B, align 8
  %16 = getelementptr inbounds [1000 x double], ptr %15, i64 0, i64 %14
  %17 = getelementptr inbounds nuw i8, ptr %16, i64 16
  store <2 x double> %12, ptr %3, align 16
  %18 = call ptr @__instrumentor_pre_store_ind(ptr %16, i32 0, ptr %3, i64 16, i32 17, i64 16, i32 0, i8 1, i8 0, ptr null)
  store <2 x double> %12, ptr %18, align 16, !tbaa !10
  store <2 x double> %12, ptr %3, align 16
  %19 = call ptr @__instrumentor_pre_store_ind(ptr %17, i32 0, ptr %3, i64 16, i32 17, i64 16, i32 0, i8 1, i8 0, ptr null)
  store <2 x double> %12, ptr %19, align 16, !tbaa !10
  %20 = add nuw i64 %14, 4
  %21 = icmp eq i64 %20, %10
  br i1 %21, label %22, label %13, !llvm.loop !20

22:                                               ; preds = %13
  %23 = icmp eq i64 %1, %10
  br i1 %23, label %24, label %7

24:                                               ; preds = %29, %22
  %25 = and i64 %1, 3
  %26 = icmp ult i64 %1, 4
  br i1 %26, label %37, label %27

27:                                               ; preds = %24
  %28 = and i64 %1, -4
  br label %59

29:                                               ; preds = %29, %7
  %30 = phi i64 [ %35, %29 ], [ %8, %7 ]
  %31 = load ptr, ptr @__instrumentor_B, align 8
  %32 = getelementptr inbounds nuw [1000 x double], ptr %31, i64 0, i64 %30
  %33 = bitcast double %0 to i64
  %34 = call ptr @__instrumentor_pre_store(ptr %32, i32 0, i64 %33, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  store double %0, ptr %34, align 8, !tbaa !10
  %35 = add nuw i64 %30, 1
  %36 = icmp eq i64 %35, %1
  br i1 %36, label %24, label %29, !llvm.loop !21

37:                                               ; preds = %59, %24
  %38 = phi double [ poison, %24 ], [ %97, %59 ]
  %39 = phi i64 [ 0, %24 ], [ %98, %59 ]
  %40 = phi double [ 0.000000e+00, %24 ], [ %97, %59 ]
  %41 = icmp eq i64 %25, 0
  br i1 %41, label %57, label %42

42:                                               ; preds = %42, %37
  %43 = phi i64 [ %54, %42 ], [ %39, %37 ]
  %44 = phi double [ %53, %42 ], [ %40, %37 ]
  %45 = phi i64 [ %55, %42 ], [ 0, %37 ]
  %46 = load ptr, ptr @__instrumentor_B, align 8
  %47 = getelementptr inbounds nuw [1000 x double], ptr %46, i64 0, i64 %43
  %48 = call ptr @__instrumentor_pre_load(ptr %47, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %49 = load double, ptr %48, align 8, !tbaa !10
  %50 = bitcast double %49 to i64
  %51 = call i64 @__instrumentor_post_load(ptr %48, i32 0, i64 %50, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %52 = bitcast i64 %51 to double
  %53 = fadd double %44, %52
  %54 = add nuw nsw i64 %43, 1
  %55 = add i64 %45, 1
  %56 = icmp eq i64 %55, %25
  br i1 %56, label %57, label %42, !llvm.loop !22

57:                                               ; preds = %42, %37, %2
  %58 = phi double [ 0.000000e+00, %2 ], [ %38, %37 ], [ %53, %42 ]
  ret double %58

59:                                               ; preds = %59, %27
  %60 = phi i64 [ 0, %27 ], [ %98, %59 ]
  %61 = phi double [ 0.000000e+00, %27 ], [ %97, %59 ]
  %62 = phi i64 [ 0, %27 ], [ %99, %59 ]
  %63 = load ptr, ptr @__instrumentor_B, align 8
  %64 = getelementptr inbounds nuw [1000 x double], ptr %63, i64 0, i64 %60
  %65 = call ptr @__instrumentor_pre_load(ptr %64, i32 0, i64 8, i32 3, i64 16, i32 0, i8 1, i8 0, ptr null)
  %66 = load double, ptr %65, align 16, !tbaa !10
  %67 = bitcast double %66 to i64
  %68 = call i64 @__instrumentor_post_load(ptr %65, i32 0, i64 %67, i64 8, i32 3, i64 16, i32 0, i8 1, i8 0, ptr null)
  %69 = bitcast i64 %68 to double
  %70 = fadd double %61, %69
  %71 = or disjoint i64 %60, 1
  %72 = load ptr, ptr @__instrumentor_B, align 8
  %73 = getelementptr inbounds nuw [1000 x double], ptr %72, i64 0, i64 %71
  %74 = call ptr @__instrumentor_pre_load(ptr %73, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %75 = load double, ptr %74, align 8, !tbaa !10
  %76 = bitcast double %75 to i64
  %77 = call i64 @__instrumentor_post_load(ptr %74, i32 0, i64 %76, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %78 = bitcast i64 %77 to double
  %79 = fadd double %70, %78
  %80 = or disjoint i64 %60, 2
  %81 = load ptr, ptr @__instrumentor_B, align 8
  %82 = getelementptr inbounds nuw [1000 x double], ptr %81, i64 0, i64 %80
  %83 = call ptr @__instrumentor_pre_load(ptr %82, i32 0, i64 8, i32 3, i64 16, i32 0, i8 1, i8 0, ptr null)
  %84 = load double, ptr %83, align 16, !tbaa !10
  %85 = bitcast double %84 to i64
  %86 = call i64 @__instrumentor_post_load(ptr %83, i32 0, i64 %85, i64 8, i32 3, i64 16, i32 0, i8 1, i8 0, ptr null)
  %87 = bitcast i64 %86 to double
  %88 = fadd double %79, %87
  %89 = or disjoint i64 %60, 3
  %90 = load ptr, ptr @__instrumentor_B, align 8
  %91 = getelementptr inbounds nuw [1000 x double], ptr %90, i64 0, i64 %89
  %92 = call ptr @__instrumentor_pre_load(ptr %91, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %93 = load double, ptr %92, align 8, !tbaa !10
  %94 = bitcast double %93 to i64
  %95 = call i64 @__instrumentor_post_load(ptr %92, i32 0, i64 %94, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %96 = bitcast i64 %95 to double
  %97 = fadd double %88, %96
  %98 = add nuw nsw i64 %60, 4
  %99 = add i64 %62, 4
  %100 = icmp eq i64 %99, %28
  br i1 %100, label %37, label %59, !llvm.loop !23
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local double @func3(ptr captures(none) noundef %0, double noundef %1, i64 noundef %2) local_unnamed_addr #2 {
  %4 = alloca <2 x double>, align 16
  %5 = call ptr @__instrumentor_post_base_pointer(ptr %0)
  %6 = icmp eq i64 %2, 0
  br i1 %6, label %56, label %7

7:                                                ; preds = %3
  %8 = icmp ult i64 %2, 4
  br i1 %8, label %9, label %11

9:                                                ; preds = %23, %7
  %10 = phi i64 [ 0, %7 ], [ %12, %23 ]
  br label %30

11:                                               ; preds = %7
  %12 = and i64 %2, -4
  %13 = insertelement <2 x double> poison, double %1, i64 0
  %14 = shufflevector <2 x double> %13, <2 x double> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %11
  %16 = phi i64 [ 0, %11 ], [ %21, %15 ]
  %17 = getelementptr inbounds double, ptr %0, i64 %16
  %18 = getelementptr inbounds nuw i8, ptr %17, i64 16
  store <2 x double> %14, ptr %4, align 16
  %19 = call ptr @__instrumentor_pre_store_ind(ptr %17, i32 0, ptr %4, i64 16, i32 17, i64 8, i32 0, i8 1, i8 0, ptr %5)
  store <2 x double> %14, ptr %19, align 8, !tbaa !10
  store <2 x double> %14, ptr %4, align 16
  %20 = call ptr @__instrumentor_pre_store_ind(ptr %18, i32 0, ptr %4, i64 16, i32 17, i64 8, i32 0, i8 1, i8 0, ptr %5)
  store <2 x double> %14, ptr %20, align 8, !tbaa !10
  %21 = add nuw i64 %16, 4
  %22 = icmp eq i64 %21, %12
  br i1 %22, label %23, label %15, !llvm.loop !24

23:                                               ; preds = %15
  %24 = icmp eq i64 %2, %12
  br i1 %24, label %25, label %9

25:                                               ; preds = %30, %23
  %26 = and i64 %2, 7
  %27 = icmp ult i64 %2, 8
  br i1 %27, label %37, label %28

28:                                               ; preds = %25
  %29 = and i64 %2, -8
  br label %58

30:                                               ; preds = %30, %9
  %31 = phi i64 [ %35, %30 ], [ %10, %9 ]
  %32 = getelementptr inbounds nuw double, ptr %0, i64 %31
  %33 = bitcast double %1 to i64
  %34 = call ptr @__instrumentor_pre_store(ptr %32, i32 0, i64 %33, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  store double %1, ptr %34, align 8, !tbaa !10
  %35 = add nuw i64 %31, 1
  %36 = icmp eq i64 %35, %2
  br i1 %36, label %25, label %30, !llvm.loop !25

37:                                               ; preds = %58, %25
  %38 = phi double [ poison, %25 ], [ %124, %58 ]
  %39 = phi i64 [ 0, %25 ], [ %125, %58 ]
  %40 = phi double [ 0.000000e+00, %25 ], [ %124, %58 ]
  %41 = icmp eq i64 %26, 0
  br i1 %41, label %56, label %42

42:                                               ; preds = %42, %37
  %43 = phi i64 [ %53, %42 ], [ %39, %37 ]
  %44 = phi double [ %52, %42 ], [ %40, %37 ]
  %45 = phi i64 [ %54, %42 ], [ 0, %37 ]
  %46 = getelementptr inbounds nuw double, ptr %0, i64 %43
  %47 = call ptr @__instrumentor_pre_load(ptr %46, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %48 = load double, ptr %47, align 8, !tbaa !10
  %49 = bitcast double %48 to i64
  %50 = call i64 @__instrumentor_post_load(ptr %47, i32 0, i64 %49, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %51 = bitcast i64 %50 to double
  %52 = fadd double %44, %51
  %53 = add nuw nsw i64 %43, 1
  %54 = add i64 %45, 1
  %55 = icmp eq i64 %54, %26
  br i1 %55, label %56, label %42, !llvm.loop !26

56:                                               ; preds = %42, %37, %3
  %57 = phi double [ 0.000000e+00, %3 ], [ %38, %37 ], [ %52, %42 ]
  ret double %57

58:                                               ; preds = %58, %28
  %59 = phi i64 [ 0, %28 ], [ %125, %58 ]
  %60 = phi double [ 0.000000e+00, %28 ], [ %124, %58 ]
  %61 = phi i64 [ 0, %28 ], [ %126, %58 ]
  %62 = getelementptr inbounds nuw double, ptr %0, i64 %59
  %63 = call ptr @__instrumentor_pre_load(ptr %62, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %64 = load double, ptr %63, align 8, !tbaa !10
  %65 = bitcast double %64 to i64
  %66 = call i64 @__instrumentor_post_load(ptr %63, i32 0, i64 %65, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %67 = bitcast i64 %66 to double
  %68 = fadd double %60, %67
  %69 = or disjoint i64 %59, 1
  %70 = getelementptr inbounds nuw double, ptr %0, i64 %69
  %71 = call ptr @__instrumentor_pre_load(ptr %70, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %72 = load double, ptr %71, align 8, !tbaa !10
  %73 = bitcast double %72 to i64
  %74 = call i64 @__instrumentor_post_load(ptr %71, i32 0, i64 %73, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %75 = bitcast i64 %74 to double
  %76 = fadd double %68, %75
  %77 = or disjoint i64 %59, 2
  %78 = getelementptr inbounds nuw double, ptr %0, i64 %77
  %79 = call ptr @__instrumentor_pre_load(ptr %78, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %80 = load double, ptr %79, align 8, !tbaa !10
  %81 = bitcast double %80 to i64
  %82 = call i64 @__instrumentor_post_load(ptr %79, i32 0, i64 %81, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %83 = bitcast i64 %82 to double
  %84 = fadd double %76, %83
  %85 = or disjoint i64 %59, 3
  %86 = getelementptr inbounds nuw double, ptr %0, i64 %85
  %87 = call ptr @__instrumentor_pre_load(ptr %86, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %88 = load double, ptr %87, align 8, !tbaa !10
  %89 = bitcast double %88 to i64
  %90 = call i64 @__instrumentor_post_load(ptr %87, i32 0, i64 %89, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %91 = bitcast i64 %90 to double
  %92 = fadd double %84, %91
  %93 = or disjoint i64 %59, 4
  %94 = getelementptr inbounds nuw double, ptr %0, i64 %93
  %95 = call ptr @__instrumentor_pre_load(ptr %94, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %96 = load double, ptr %95, align 8, !tbaa !10
  %97 = bitcast double %96 to i64
  %98 = call i64 @__instrumentor_post_load(ptr %95, i32 0, i64 %97, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %99 = bitcast i64 %98 to double
  %100 = fadd double %92, %99
  %101 = or disjoint i64 %59, 5
  %102 = getelementptr inbounds nuw double, ptr %0, i64 %101
  %103 = call ptr @__instrumentor_pre_load(ptr %102, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %104 = load double, ptr %103, align 8, !tbaa !10
  %105 = bitcast double %104 to i64
  %106 = call i64 @__instrumentor_post_load(ptr %103, i32 0, i64 %105, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %107 = bitcast i64 %106 to double
  %108 = fadd double %100, %107
  %109 = or disjoint i64 %59, 6
  %110 = getelementptr inbounds nuw double, ptr %0, i64 %109
  %111 = call ptr @__instrumentor_pre_load(ptr %110, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %112 = load double, ptr %111, align 8, !tbaa !10
  %113 = bitcast double %112 to i64
  %114 = call i64 @__instrumentor_post_load(ptr %111, i32 0, i64 %113, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %115 = bitcast i64 %114 to double
  %116 = fadd double %108, %115
  %117 = or disjoint i64 %59, 7
  %118 = getelementptr inbounds nuw double, ptr %0, i64 %117
  %119 = call ptr @__instrumentor_pre_load(ptr %118, i32 0, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr %5)
  %120 = load double, ptr %119, align 8, !tbaa !10
  %121 = bitcast double %120 to i64
  %122 = call i64 @__instrumentor_post_load(ptr %119, i32 0, i64 %121, i64 8, i32 3, i64 8, i32 0, i8 1, i8 0, ptr null)
  %123 = bitcast i64 %122 to double
  %124 = fadd double %116, %123
  %125 = add nuw nsw i64 %59, 8
  %126 = add i64 %61, 8
  %127 = icmp eq i64 %126, %29
  br i1 %127, label %37, label %58, !llvm.loop !27
}

define private void @__instrumentor_ctor() {
entry:
  %0 = call ptr @__instrumentor_post_global_var(ptr @A, i64 8, i64 8, i8 0, i8 1, ptr @__instrumentor_str.2, i8 0)
  store ptr %0, ptr @__instrumentor_A, align 8
  %1 = call ptr @__instrumentor_post_global_var(ptr @B, i64 8000, i64 16, i8 0, i8 1, ptr @__instrumentor_str.3, i8 0)
  store ptr %1, ptr @__instrumentor_B, align 8
  call void @__instrumentor_pre_module(ptr @__instrumentor_str, ptr @__instrumentor_str.1)
  ret void
}

define private void @__instrumentor_dtor() {
entry:
  call void @__instrumentor_post_module(ptr @__instrumentor_str, ptr @__instrumentor_str.1)
  ret void
}

declare void @__instrumentor_pre_module(ptr, ptr)

declare void @__instrumentor_post_module(ptr, ptr)

declare ptr @__instrumentor_post_base_pointer(ptr)

declare ptr @__instrumentor_pre_load(ptr, i32, i64, i32, i64, i32, i8, i8, ptr)

declare i64 @__instrumentor_post_load(ptr, i32, i64, i64, i32, i64, i32, i8, i8, ptr)

declare ptr @__instrumentor_pre_store_ind(ptr, i32, ptr, i64, i32, i64, i32, i8, i8, ptr)

declare ptr @__instrumentor_pre_store(ptr, i32, i64, i64, i32, i64, i32, i8, i8, ptr)

declare ptr @__instrumentor_post_global_var(ptr, i64, i64, i8, i8, ptr, i8)

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
