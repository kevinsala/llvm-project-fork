// LLVM Instrumentor stub runtime

#include <stdint.h>
#include <stdio.h>

void __instrumentor_pre_load(void *pointer, int32_t pointer_as, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load pre -- pointer: %p, pointer_as: %i, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_pre_store(void *pointer, int32_t pointer_as, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store pre -- pointer: %p, pointer_as: %i, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_pre_store_ind(void *pointer, int32_t pointer_as, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store pre -- pointer: %p, pointer_as: %i, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_post_load(void *pointer, int32_t pointer_as, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load post -- pointer: %p, pointer_as: %i, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_post_load_ind(void *pointer, int32_t pointer_as, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load post -- pointer: %p, pointer_as: %i, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_post_store(void *pointer, int32_t pointer_as, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store post -- pointer: %p, pointer_as: %i, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_post_store_ind(void *pointer, int32_t pointer_as, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store post -- pointer: %p, pointer_as: %i, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

