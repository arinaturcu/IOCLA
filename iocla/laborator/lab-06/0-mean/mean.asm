%include "../utils/printf32.asm"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

section .data
    num_array dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    decimal_point db ".",0

section .text
    extern printf
    global main

main:
    xor eax, eax
    mov ecx, ARRAY_SIZE

    ; TODO1 - compute the sum of the vector numbers - store it in eax

sum_numbers:
    add ax, word [num_array + 2 * ecx - 2]
    loop sum_numbers

    PRINTF32 `Sum of numbers: %hu\n\x0`, eax

    xor edx, edx
    mov bx, ARRAY_SIZE
    div bx

    PRINTF32 `Mean of numbers: %d\x0`, eax
    PRINTF32 `.\x0`

    mov ecx, DECIMAL_PLACES

compute_decimal_place:
    ; TODO3 - compute the current decimal place - store it in ax

    xor eax, eax
    mov al, dl           ; store the previous reminder
    mov bl, 10           ; multiply by 10
    mul bl               ; the result is in AX (AH + AL)

    mov bl, ARRAY_SIZE
    div bl

    mov dl, al           ; put the digit to print in AL
    mov dh, ah           ; store current reminder
    xor eax, eax
    mov al, dl
    mov dl, dh           ; put the previous reminder in DL

    PRINTF32 `%d\x0`, eax
    dec ecx
    cmp ecx, 0
    jg compute_decimal_place

    PRINTF32 `\n\x0`

end:
    xor eax, eax
    ret
