section .data
    before_format db "before: %s", 13, 10, 0
    after_format  db "after: %s", 13, 10, 0
    mystring      db "ana", 0, "are", 0, "mere", 0
    size          dd 13

section .text

    extern printf
    extern puts
    global main

put_spaces:
    push    ebp
    mov     ebp, esp

    mov     ebx, dword [ebp + 8]
    mov     ecx, dword [size]
    dec     ecx

test_one_byte:
    cmp     byte [ebx], 0
    jne     repeat
    mov     byte [ebx], 0x20

repeat:
    inc     ebx
    loop    test_one_byte

    leave
    ret

rot13:
    push    ebp
    mov     ebp, esp

    mov     eax, dword [ebp + 8]

    push    eax                       ; put spaces
    call    put_spaces
    add     esp, 4

modify_one_byte:
    cmp     byte [eax], byte 0x61     ; 'a' = 0x61 = 97
    jl      check_upper
    cmp     byte [eax], byte 0x7A     ; 'z' = 0x7A = 122
    jg      next

    add     byte [eax], byte 0xD
    cmp     byte [eax], byte 0x7A     ; check if the character is outside of alphabet
    jle     next

    sub     byte [eax], 26
    jmp     next

check_upper:
    cmp     byte [eax], byte 0x41
    jl      next
    cmp     byte [eax], byte 0x5A
    jg      next

    add     byte [eax], byte 0xD
    cmp     byte [eax], byte 0x5A    ; check if the character is outside of alphabet
    jle     next

    sub     byte [eax], byte 26

next:
    inc     eax
    cmp     byte [eax], 0
    jne     modify_one_byte

    leave
    ret

main:
    push    ebp
    mov     ebp, esp

    push    mystring
    push    before_format
    call    printf
    add     esp, 8

    push    mystring
    call    rot13
    add     esp, 4

    push    mystring
    push    after_format
    call    printf
    add     esp, 8

    leave
    ret
