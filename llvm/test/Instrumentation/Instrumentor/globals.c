int A1;
const int A2;
static int A3;
static const int A4;
extern int A5;
extern const int A6;

int *B1;
int * const B2;
static int * B3;
static int * const B4;
extern int * B5;
extern int * const B6;

int C1[100];
const int C2[100];
static int C3[100];
static const int C4[100];
extern int C5[100];
extern const int C6[100];

typedef long double x86_fp80;

x86_fp80 D1;
const x86_fp80 D2;
static x86_fp80 D3;
static const x86_fp80 D4;
extern x86_fp80 D5;
extern x86_fp80 D6;

void func();

int main() {
	func(&A1, &A2, &A3, &A4, &A5, &A6);
	func(&B1, &B2, &B3, &B4, &B5, &B6);
	func(&C1, &C2, &C3, &C4, &C5, &C6);
	func(&D1, &D2, &D3, &D4, &D5, &D6);
}
