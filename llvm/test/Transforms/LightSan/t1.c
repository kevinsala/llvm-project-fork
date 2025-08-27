#include <stdlib.h>
#include <stdio.h>

double A = 0.0;
double *B = NULL;

void* foobar(double, double *);

int foo(int a, double *b) {
	*b = a;
	return a;
}

double bar(int a) {
	double b;
	double c;
	foo(a, &b);
	foobar(b, &b);
	fprintf(stdout, "%f %d %p %p\n", b, a, &A, &c);
	return b;
}

double bar2(int a) {
	fprintf(stdout, "%d\n", a);
	return 0.0;
}

int main(int argc, char **argv) {
	bar(argc);
	double b = bar2(argc);
	foobar(argc, B);
}
