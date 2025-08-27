#include <stddef.h>

double *A;
double B[1000];

double func1(double V, size_t N) {
	for (size_t I = 0; I < N; ++I)
		A[I] = V;

	double Sum = 0;
	for (int I = 0; I < N; ++I)
		Sum += A[I];

	return Sum;
}

double func2(double V, size_t N) {
	for (size_t I = 0; I < N; ++I)
		B[I] = V;

	double Sum = 0;
	for (int I = 0; I < N; ++I)
		Sum += B[I];

	return Sum;
}

double func3(double *C, double V, size_t N) {
	for (size_t I = 0; I < N; ++I)
		C[I] = V;

	double Sum = 0;
	for (int I = 0; I < N; ++I)
		Sum += C[I];

	return Sum;
}
