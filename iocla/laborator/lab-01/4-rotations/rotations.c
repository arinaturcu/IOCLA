#include <stdio.h>

void rotate_left(int *number, int bits)
{
	*number = ((unsigned int)*number << bits)|((unsigned int)*number >> (32 - bits));
}

void rotate_right(int *number, int bits)
{
	*number = ((unsigned int)*number >> bits)|((unsigned int)*number << (32 - bits));
}

int main()
{
    int number = 0x80000000;

    rotate_left(&number, 1);
    printf("Rotated: %u\n", number);

	return 0;
}

