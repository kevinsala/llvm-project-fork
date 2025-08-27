#include <hip/hip_runtime.h>
#include <cstdio>

__device__ void func(int *array, int size) {
	array[0] = 200;
}

__global__ void kernel(int *array, int size) {
	printf("kernel: array[%d] %d\n", 0, array[0]);
	func(array, size);
	printf("kernel: array %p size %d\n", array, size);
	printf("kernel: array[%d] %d\n", 0, array[0]);
}

int main(int argc, char **argv) {
	const int size = 10;
	int *d_array;

	printf("str: %s\n", argv[10]);

	hipMalloc((void**)&d_array, size * sizeof(int));

	kernel<<<1, 1>>>(d_array, size);

	hipFree(d_array);
}
