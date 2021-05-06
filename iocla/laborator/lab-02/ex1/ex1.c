#include <stdio.h>

/**
 * Afisati adresele elementelor din vectorul "v" impreuna cu valorile
 * de la acestea.
 * Parcurgeti adresele, pe rand, din octet in octet,
 * din 2 in 2 octeti si apoi din 4 in 4.
 */

int main() {
    int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};
    // din 2 in 2 bytes
    unsigned short *short_ptr = (unsigned short*)v;

    for (int i = 0; i < sizeof(v)/2; i ++) {
        printf("%p -> 0x%X\n", short_ptr + i, *(short_ptr + i));
    }

    printf("\n\n");
    // din 4 in 4 bytes
    unsigned int *int_ptr = (unsigned int*)v;

    for (int i = 0; i < sizeof(v)/4; i ++) {
        printf("%p -> 0x%X\n", int_ptr + i, *(int_ptr + i));
    }

    return 0;
}
