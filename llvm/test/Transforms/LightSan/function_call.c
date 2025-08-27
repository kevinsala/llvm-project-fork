#include <stdlib.h>
#include <stdio.h>

void* foobar(double, double *);

int foo(int a, double *b) {
	*b = a;
	return a;
}

double bar(int a) {
	double b;
	foo(a, &b);
	foobar(b, &b);
	fprintf(stdout, "%f %d\n", b, a);
	return b;
}

int main(int argc, char **argv) {

}
