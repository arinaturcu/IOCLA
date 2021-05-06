section .data
    before_format db "before %s", 13, 10, 0
    after_format db "after %s", 13, 10, 0
    mystring db "aB.cdefghij", 0

section .text

    extern printf
    extern puts
    global main

toupper:
    push    ebp
    mov     ebp, esp

    mov     eax, dword [ebp + 8]

modify_one_byte:
    cmp     byte [eax], byte 61h     ; 'a' = 0x61 = 97
    jl      next
    cmp     byte [eax], byte 7Ah     ; 'z' = 0x5A = 122
    jg      next

    sub     byte [eax], 20h

next:
    inc     eax
    cmp     byte [eax], 0
    jne     modify_one_byte

    leave
    ret

main:
    push ebp
    mov ebp, esp

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    leave
    ret
