#include <stdio.h>

void main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;

	/* TODO: Implement binary search */

startwhile:
	if (start > end) {
		goto notfound;
	}

	if (v[start + (end - start) / 2] == dest) {
		goto found;
	}

	if (v[start + (end - start) / 2] < dest) {
        start = start + (end - start) / 2 + 1;
	}

	if (v[start + (end - start) / 2] > dest) {
		end = start + (end - start) / 2 - 1;
	}

	goto startwhile;

found:
	printf("Gasit la pozitia %d\n", start + (end - start) / 2);
	goto finish;

notfound:
	printf("Nu a fost gasit\n");

finish:
	return;
}
