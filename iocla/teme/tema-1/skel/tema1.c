// Arina Emanuela Turcu 323CA

#include <stdarg.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

static char *itoa(unsigned int value, int base, int usign)
{
	static char result[32] = {0};
	char *p1 = result;
	char *p2 = result;
	int is_neg = 0;

	// check if number is negative
	if (value & (1 << 31))
		is_neg = 1;

	if (is_neg && !usign) 
		value = ~(value - 1);

	do {
		*p1++ = "0123456789abcdef"[value % base];
		value /= base;
	} while (value);

	// apply negative sign
	if (is_neg && !usign)
		*p1++ = '-';

	*p1-- = '\0';

	// reverse
	while (p2 < p1) {
		char tmp_char = *p1;
		*p1-- = *p2;
		*p2++ = tmp_char;
	}

	return result;
}

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

int iocla_printf(const char *format, ...)
{
	va_list args;
	int x;
	char *buff;
	int count_char = 0;
	int len;

	va_start(args, format);
	len = strlen(format);

	for (int i = 0; i < len; ++i) {
		if (format[i] == '%') {
			switch (format[i + 1]) {
			case 'd':
				x = va_arg(args, int);
				buff = itoa(x, 10, 0);

				write_stdout(buff, strlen(buff));
				count_char += strlen(buff);
				break;

			case 'u':
				x = va_arg(args, unsigned int);
				buff = itoa(x, 10, 1);

				write_stdout(buff, strlen(buff));
				count_char += strlen(buff);
				break;

			case 'x':
				x = va_arg(args, int);
				buff = itoa(x, 16, 1);

				write_stdout(buff, strlen(buff));
				count_char += strlen(buff);
				break;

			case 'c':
				buff = malloc(sizeof(char));
				buff[0] = va_arg(args, int);

				write_stdout(buff, 1);
				free(buff);
				count_char++;
				break;

			case 's':
				buff = va_arg(args, char *);

				write_stdout(buff, strlen(buff));
				count_char += strlen(buff);
				break;

			case '%':
				write_stdout(&format[i + 1], 1);
				count_char++;
				break;
			}

			i++;
		} else {
			write_stdout(&format[i], 1);
			count_char++;
		}
	}

	va_end(args);
	return count_char;
}
