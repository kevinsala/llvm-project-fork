#include <stdio.h>

int main(int argc, char **argv) {
	int rt = fputs(argv[0], stdout);
	return rt;
}
