%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    int_array dd 2, -34, 9, 193, 99995, -18472, 123, -4, 1, -15
    print_format_neg db "Negative values ", 0
    print_format_pos db "Positive values ", 0

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE
    xor eax, eax                              ; count positive numbers
    xor ebx, ebx                              ; count negative numbers

count:
    mov edx, dword [int_array + 4 * ecx - 4]
    cmp edx, 0
    jl add_negative

add_positive:
    inc eax
    loop count

    cmp ecx, 0
    je print

add_negative:
    inc ebx
    loop count

print:
    PRINTF32 `%s\x0`, print_format_pos        ; print positive
    PRINTF32 `%d\n\x0`, eax

    PRINTF32 `%s\x0`, print_format_neg        ; print negative
    PRINTF32 `%d\n\x0`, ebx

end:
    leave
    ret