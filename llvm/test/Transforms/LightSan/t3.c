#include <stdio.h>

extern int A;
extern int B;
__attribute__((weak)) int C = 1010;
int D;
int E = 10;

int main() {
	fprintf(stderr, "%d, %d, %d, %p, %d, %d\n", A, B, C, stderr, D, E);
}
