; ModuleID = 'load_store.ll'
source_filename = "load_store.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @__objsan_ctor, ptr null }]

@__adapter__Z15store_load_boolPb = alias i1 (ptr), ptr @_Z15store_load_boolPb
@__adapter__Z15store_load_charPc = alias i8 (ptr), ptr @_Z15store_load_charPc
@__adapter__Z16store_load_shortPs = alias i16 (ptr), ptr @_Z16store_load_shortPs
@__adapter__Z14store_load_intPi = alias i32 (ptr), ptr @_Z14store_load_intPi
@__adapter__Z15store_load_longPl = alias i64 (ptr), ptr @_Z15store_load_longPl
@__adapter__Z20store_load_long_longPx = alias i128 (ptr), ptr @_Z20store_load_long_longPx
@__adapter__Z16store_load_floatPf = alias float (ptr), ptr @_Z16store_load_floatPf
@__adapter__Z17store_load_doublePd = alias double (ptr), ptr @_Z17store_load_doublePd
@__adapter__Z22store_load_long_doublePe = alias x86_fp80 (ptr), ptr @_Z22store_load_long_doublePe

define noundef zeroext i1 @_Z15store_load_boolPb(ptr noundef captures(none) initializes((0, 1)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 2
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i8 1, ptr %7, align 1
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 1
  %9 = load i8, ptr %8, align 1
  %loadedv = trunc nuw i8 %9 to i1
  ret i1 %loadedv
}

define noundef signext i8 @_Z15store_load_charPc(ptr noundef captures(none) initializes((0, 1)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 2
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i8 1, ptr %7, align 1
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 1
  %9 = load i8, ptr %8, align 1
  ret i8 %9
}

define noundef signext i16 @_Z16store_load_shortPs(ptr noundef captures(none) initializes((0, 2)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 4
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i16 2, ptr %7, align 2
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 2
  %9 = load i16, ptr %8, align 2
  ret i16 %9
}

define noundef i32 @_Z14store_load_intPi(ptr noundef captures(none) initializes((0, 4)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 8
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i32 3, ptr %7, align 4
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 4
  %9 = load i32, ptr %8, align 4
  ret i32 %9
}

define noundef i64 @_Z15store_load_longPl(ptr noundef captures(none) initializes((0, 8)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 16
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i64 4, ptr %7, align 8
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 8
  %9 = load i64, ptr %8, align 8
  ret i64 %9
}

define noundef i128 @_Z20store_load_long_longPx(ptr noundef captures(none) initializes((0, 16)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 32
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store i128 5, ptr %7, align 8
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 16
  %9 = load i128, ptr %8, align 8
  ret i128 %9
}

define noundef float @_Z16store_load_floatPf(ptr noundef captures(none) initializes((0, 4)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 8
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store float 6.000000e+00, ptr %7, align 4
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 4
  %9 = load float, ptr %8, align 4
  ret float %9
}

define noundef double @_Z17store_load_doublePd(ptr noundef captures(none) initializes((0, 8)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 16
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store double 7.000000e+00, ptr %7, align 8
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 8
  %9 = load double, ptr %8, align 8
  ret double %9
}

define noundef x86_fp80 @_Z22store_load_long_doublePe(ptr noundef captures(none) initializes((0, 10)) %A) {
entry:
  %0 = alloca i8, align 1
  %1 = alloca i64, align 8
  %2 = call ptr @__objsan_post_base_pointer_info(ptr %A, ptr nonnull %1, ptr nonnull %0) #0
  %3 = load i64, ptr %1, align 8
  %4 = load i8, ptr %0, align 1
  %5 = getelementptr inbounds nuw i8, ptr %A, i64 26
  %6 = call ptr @__objsan_post_loop_value_ptr_range(ptr %A, ptr nonnull %5, i64 0, ptr %2, i64 %3, i8 %4, i8 1)
  %7 = call ptr @__objsan_get_mptr(ptr %A, ptr %2, i8 %4)
  store x86_fp80 0xK40028000000000000000, ptr %7, align 16
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 16
  %9 = load x86_fp80, ptr %8, align 16
  ret x86_fp80 %9
}

declare ptr @__objsan_post_base_pointer_info(ptr, ptr, ptr)

declare ptr @__objsan_get_mptr(ptr, ptr, i8)

define private void @__objsan_ctor() {
entry:
  ret void
}

declare ptr @__objsan_post_loop_value_ptr_range(ptr, ptr, i64, ptr, i64, i8, i8)

attributes #0 = { willreturn }
