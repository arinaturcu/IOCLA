%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    int_array dd 2, 34, 9, 193, 99995, 18472, 123, 4, 1, 15
    print_format_odd db "Odd numbers ", 0
    print_format_even db "Even numbers ", 0
    count_odd  dd 0
    count_even dd 0

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE

count:
    mov dx, word [int_array + 4 * ecx - 2]
    mov ax, word [int_array + 4 * ecx - 4]
    mov bx, 2
    div bx

    cmp dx, 0
    je add_even

add_odd:
    inc dword [count_odd]
    loop count

    cmp ecx, 0
    je print

add_even:
    inc dword [count_even]
    loop count

print:
    PRINTF32 `%s\x0`, print_format_odd        ; print positive
    PRINTF32 `%d\n\x0`, [count_odd]

    PRINTF32 `%s\x0`, print_format_even       ; print negative
    PRINTF32 `%d\n\x0`, [count_even]

end:
    leave
    ret