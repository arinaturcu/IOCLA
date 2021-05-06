#include <stdio.h>
#include <stdlib.h>

void print_binary(int number, int nr_bits)
{
	unsigned int i;

	for (i = 1 << (nr_bits - 1); i > 0; i = i / 2) {
		if (number & i) {
			printf("1");
		} else {
			printf("0");
		}
    } 
    printf("\n");
}

void check_parity(int *numbers, int n)
{
	for (int i = 0; i < n; ++i) {
		if (*(numbers + i) & 1) {
			printf("%x\n", *(numbers + i));
		} else {
			print_binary(*(numbers + i), 32);
		}
	}
}

int main()
{
	int numbers[] = {341, 32, 63, 194, 65};

	check_parity(numbers, 5);

	return 0;
}

