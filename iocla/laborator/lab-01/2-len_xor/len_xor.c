#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int my_strlen(const char *str)
{
	int contor = 0;
	
	while (*str) {
		contor++;
		str++;
	}
	
	return contor;	
}

void equality_check(const char *str)
{
	int len = my_strlen(str);
	
	for (int i = 0; i < len; ++i) {
		int next = (i + (1 << i)) % len;
		
		if (!((*(str + i)) ^ (*(str + next)))) {
			printf("%x\n", (int)(str + i));
		}
	}
}

int main(void)
{
	char *str;
	
	str = "ababababacccbacbacbacbacbabc";
	
	printf("%d\n", my_strlen(str));
	equality_check(str);

	return 0;
}

