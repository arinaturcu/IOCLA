#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max;
	int i;

	/* TODO: Implement finding the maximum value in the vector */
<<<<<<< HEAD

	max = *v;
	i = 0;

start:
	if (i >= sizeof(v) / sizeof(int)) {
		goto finish;
	}

	if (*(v + i) > max) {
		max = *(v + i);
	}

	i++;
	goto start;

finish:
	printf("Max value: %d\n", max);
=======
	max = v[0];
	i = 1;
>>>>>>> dc278e3d7d56bd74aec242293ab9eb9c089a6d74
}
