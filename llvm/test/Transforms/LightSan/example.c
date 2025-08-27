#include <stdio.h>

int example(int a, int *b);

int main(int argc, char **argv) {
	return example(argc, &argc);
}
