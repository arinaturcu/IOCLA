#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char *s)
{
	char *end;
	
	while (*s) end = (s++);
	
	while (*end) {
		printf("%c", *end);
		end--;
	}
	
	printf("\n");
}

int main()
{
	mirror("AnaAreMere");

	return 0;
}

