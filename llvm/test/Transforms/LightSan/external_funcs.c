#include <stdlib.h>
#include <stdio.h>

void* func_decl(double *, double, double *);

__attribute__((noinline)) static double func_int(double *a, double *b) {
	*a = *b;
	return *a;
}

__attribute__((noinline)) void *func_def1(double a, double *b) {
	*b = a;
	return b;
}

__attribute__((noinline)) double func_def2(int a) {
	double b = 1.0, c = 2.0, d = 3.0;
	func_def1(d, &b);
	func_decl(&b, b, &c);
	func_int(&b, &c);
	fprintf(stdout, "%f %p %d %p\n", b, &d, a, &c);
	return b;
}

int main(int argc, char **argv) {
	func_def2(argc);
}
