#include <assert.h>

void unreachable(void) {
	__builtin_unreachable();
}

void trap1(void) {
	__builtin_trap();
}

void trap2(void) {
	assert(0);
}
