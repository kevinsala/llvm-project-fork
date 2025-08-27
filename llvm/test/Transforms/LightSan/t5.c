#include <stdio.h>

extern int A;

int main() {
	fprintf(stderr, "%d\n", A);
}
