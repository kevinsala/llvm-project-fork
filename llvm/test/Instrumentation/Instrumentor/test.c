// LLVM Instrumentor stub runtime

#include <stdint.h>
#include <stdio.h>

void __instrumentor_pre_module(char *module_name, char *name) {
  printf("module pre -- module_name: %s, name: %s\n", module_name, name);
}

void __instrumentor_post_module(char *module_name, char *name) {
  printf("module post -- module_name: %s, name: %s\n", module_name, name);
}

void *__instrumentor_pre_globals(void *address, char *name, int64_t initial_value, int32_t initial_value_size, int8_t is_constant) {
  printf("globals pre -- address: %p, name: %s, initial_value: %lli, initial_value_size: %i, is_constant: %i\n", address, name, initial_value, initial_value_size, is_constant);
  return address;
}

void *__instrumentor_pre_globals_ind(void *address, char *name, int64_t *initial_value_ptr, int32_t initial_value_size, int8_t is_constant) {
  printf("globals pre -- address: %p, name: %s, initial_value: %p, initial_value_size: %i, is_constant: %i\n", address, name, initial_value_ptr, initial_value_size, is_constant);
  return address;
}

void __instrumentor_pre_function(void *address, char *name, int32_t num_arguments, void *arguments, int8_t is_main) {
  printf("function pre -- address: %p, name: %s, num_arguments: %i, arguments: %p, is_main: %i\n", address, name, num_arguments, arguments, is_main);
}

void __instrumentor_pre_unreachable() {
  printf("unreachable pre -- \n");
}

void __instrumentor_pre_call(void *callee, char *callee_name, int64_t intrinsic_id, void *allocation_info, int32_t num_parameters, void *parameters, int8_t is_definition) {
  printf("call pre -- callee: %p, callee_name: %s, intrinsic_id: %lli, allocation_info: %p, num_parameters: %i, parameters: %p, is_definition: %i\n", callee, callee_name, intrinsic_id, allocation_info, num_parameters, parameters, is_definition);
}

void *__instrumentor_pre_load(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load pre -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
  return pointer;
}

void __instrumentor_pre_ptrtoint(void *pointer) {
  printf("ptrtoint pre -- pointer: %p\n", pointer);
}

void __instrumentor_pre_ptrtoint_ind(void **pointer_ptr, int32_t pointer_size) {
  printf("ptrtoint pre -- pointer: %p, pointer_size: %i\n", pointer_ptr, pointer_size);
}

int8_t __instrumentor_pre_br(int8_t is_conditional, int8_t value, int64_t num_successors) {
  printf("br pre -- is_conditional: %i, value: %i, num_successors: %lli\n", is_conditional, value, num_successors);
  return value;
}

int64_t __instrumentor_pre_alloca(int64_t size, int64_t alignment) {
  printf("alloca pre -- size: %lli, alignment: %lli\n", size, alignment);
  return size;
}

void *__instrumentor_pre_store(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store pre -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
  return pointer;
}

void *__instrumentor_pre_store_ind(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store pre -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
  return pointer;
}

void __instrumentor_pre_icmp(int8_t is_ptr_cmp, int32_t cmp_predicate_kind, int64_t lhs, int64_t rhs) {
  printf("icmp pre -- is_ptr_cmp: %i, cmp_predicate_kind: %i, lhs: %lli, rhs: %lli\n", is_ptr_cmp, cmp_predicate_kind, lhs, rhs);
}

void __instrumentor_pre_icmp_ind(int8_t is_ptr_cmp, int32_t cmp_predicate_kind, int64_t *lhs_ptr, int32_t lhs_size, int64_t *rhs_ptr, int32_t rhs_size) {
  printf("icmp pre -- is_ptr_cmp: %i, cmp_predicate_kind: %i, lhs: %p, lhs_size: %i, rhs: %p, rhs_size: %i\n", is_ptr_cmp, cmp_predicate_kind, lhs_ptr, lhs_size, rhs_ptr, rhs_size);
}

int64_t __instrumentor_post_call(void *callee, char *callee_name, int64_t intrinsic_id, void *allocation_info, int64_t return_value, int32_t return_value_size, int32_t num_parameters, void *parameters, int8_t is_definition) {
  printf("call post -- callee: %p, callee_name: %s, intrinsic_id: %lli, allocation_info: %p, return_value: %lli, return_value_size: %i, num_parameters: %i, parameters: %p, is_definition: %i\n", callee, callee_name, intrinsic_id, allocation_info, return_value, return_value_size, num_parameters, parameters, is_definition);
  return return_value;
}

void __instrumentor_post_call_ind(void *callee, char *callee_name, int64_t intrinsic_id, void *allocation_info, int64_t *return_value_ptr, int32_t return_value_size, int32_t num_parameters, void *parameters, int8_t is_definition) {
  printf("call post -- callee: %p, callee_name: %s, intrinsic_id: %lli, allocation_info: %p, return_value: %p, return_value_size: %i, num_parameters: %i, parameters: %p, is_definition: %i\n", callee, callee_name, intrinsic_id, allocation_info, return_value_ptr, return_value_size, num_parameters, parameters, is_definition);
}

int64_t __instrumentor_post_load(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load post -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
  return value;
}

void __instrumentor_post_load_ind(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("load post -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

int64_t __instrumentor_post_ptrtoint(void *pointer, int64_t value) {
  printf("ptrtoint post -- pointer: %p, value: %lli\n", pointer, value);
  return value;
}

void __instrumentor_post_ptrtoint_ind(void **pointer_ptr, int32_t pointer_size, int64_t *value_ptr, int32_t value_size) {
  printf("ptrtoint post -- pointer: %p, pointer_size: %i, value: %p, value_size: %i\n", pointer_ptr, pointer_size, value_ptr, value_size);
}

void *__instrumentor_post_alloca(void *address, int64_t size, int64_t alignment) {
  printf("alloca post -- address: %p, size: %lli, alignment: %lli\n", address, size, alignment);
  return address;
}

void __instrumentor_post_store(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t value, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store post -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %lli, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

void __instrumentor_post_store_ind(void *pointer, int32_t pointer_as, void *base_pointer_info, void *loop_value_range_info, int64_t *value_ptr, int64_t value_size, int64_t alignment, int32_t value_type_id, int32_t atomicity_ordering, int8_t sync_scope_id, int8_t is_volatile) {
  printf("store post -- pointer: %p, pointer_as: %i, base_pointer_info: %p, loop_value_range_info: %p, value: %p, value_size: %lli, alignment: %lli, value_type_id: %i, atomicity_ordering: %i, sync_scope_id: %i, is_volatile: %i\n", pointer, pointer_as, base_pointer_info, loop_value_range_info, value_ptr, value_size, alignment, value_type_id, atomicity_ordering, sync_scope_id, is_volatile);
}

int8_t __instrumentor_post_icmp(int8_t value, int8_t is_ptr_cmp, int32_t cmp_predicate_kind, int64_t lhs, int64_t rhs) {
  printf("icmp post -- value: %i, is_ptr_cmp: %i, cmp_predicate_kind: %i, lhs: %lli, rhs: %lli\n", value, is_ptr_cmp, cmp_predicate_kind, lhs, rhs);
  return value;
}

int8_t __instrumentor_post_icmp_ind(int8_t value, int8_t is_ptr_cmp, int32_t cmp_predicate_kind, int64_t *lhs_ptr, int32_t lhs_size, int64_t *rhs_ptr, int32_t rhs_size) {
  printf("icmp post -- value: %i, is_ptr_cmp: %i, cmp_predicate_kind: %i, lhs: %p, lhs_size: %i, rhs: %p, rhs_size: %i\n", value, is_ptr_cmp, cmp_predicate_kind, lhs_ptr, lhs_size, rhs_ptr, rhs_size);
  return value;
}

void *__instrumentor_post_base_pointer_info(void *base_pointer, int32_t base_pointer_kind) {
  printf("base_pointer_info post -- base_pointer: %p, base_pointer_kind: %i\n", base_pointer, base_pointer_kind);
  return 0;
}

void *__instrumentor_post_loop_value_range(int64_t initial_loop_val, int64_t final_loop_val, int64_t max_offset) {
  printf("loop_value_range post -- initial_loop_val: %lli, final_loop_val: %lli, max_offset: %lli\n", initial_loop_val, final_loop_val, max_offset);
  return 0;
}

