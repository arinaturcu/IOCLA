#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* delete_first(char *s, char *pattern) {
	char *newS = strdup(s);
	
	char *first = strstr(newS, pattern);

	int patt_size = strlen(pattern);

	memmove(first, first + patt_size, strlen(first + patt_size) + 1);

	return newS;
}

int main(){
	char *s = "Ana are mere";
	char *pattern = "re";

	printf("%s\n", delete_first(s, pattern));

	return 0;
}
