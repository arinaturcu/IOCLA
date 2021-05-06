%include "../utils/printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    string_format db "%s", 10, 0
    int_format db "%d", 10, 0
    char_format db "%c", 10, 0

    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

    print_int_format db 10, 'int_x: %d', 10, 0
    print_char_format db 'char_y: %c', 10, 0
    print_string_format db 'string_s: %s', 10, 0

section .text
extern printf
global main

get_int:
    ; TODO --- return the int value from struct
    ; int get_int(struct my_struct *obj)

    mov     eax, dword [sample_obj + int_x]
    ret

get_char:
    ; TODO --- return the char value from struct
    ; char get_char(struct my_struct *obj)

    xor     eax, eax
    mov     al, byte [sample_obj + char_y]
    ret

get_string:
    ; TODO --- return a pointer to the string value from struct
    ; char* get_string(struct my_struct *obj)

    mov     eax, sample_obj + string_s
    ret

set_int:
    ; TODO --- set the int value from struct with the new one
    ; void set_int(struct my_struct *obj, int x)
    mov     ebx, dword [esp + 8]
    mov     dword [sample_obj + int_x], ebx
    ret

set_char:
    ; TODO --- set the char value from struct with the new one
    ; void set_char(struct my_struct *obj, char y)
    mov     ebx, dword [esp + 8]
    mov     byte [sample_obj + char_y], bl
    ret    

set_string:
    ; TODO --- set the string value from struct with the new one
    ; void set_string(struct my_struct *obj, char* s)
    mov     ebx, dword [esp + 8]
    mov     ecx, sample_obj + string_s

replace:
    mov     dl, byte [ebx]
    mov     byte [ecx], dl

    inc     ecx
    inc     ebx
    cmp     byte [ebx], 0
    jne     replace

    mov     byte [ecx], 0

    ret

main:
    push ebp
    mov ebp, esp

    push ebx

    mov edx, [new_int]
    push edx
    push sample_obj
    call set_int
    add esp, 8

    push sample_obj
    call get_int
    add esp, 4

    ;uncomment when get_int is ready
    push eax
    push int_format
    call printf
    add esp, 8

    movzx edx, byte [new_char]
    ; movzx is the same as
    ; xor edx, edx
    ; mov dl, byte [new_char]
    push edx
    push sample_obj
    call set_char
    add esp, 8

    push sample_obj
    call get_char
    add esp, 4

    ;uncomment when get_char is ready
    push eax
    push char_format
    call printf
    add esp, 8

    mov edx, new_string
    push edx
    push sample_obj
    call set_string
    add esp, 8

    push sample_obj
    call get_string
    add esp, 4

    ;uncomment when get_string is ready
    push eax
    push string_format
    call printf
    add esp, 8

    ; printed with printf

    pop     ebx
    mov     ebx, sample_obj

    push    dword [ebx + int_x]
    push    print_int_format
    call    printf
    add     esp, 8

    xor     edx, edx
    mov     dl, byte [ebx + char_y]
    push    edx
    push    print_char_format
    call    printf
    add     esp, 8

    mov     edx, ebx
    add     edx, string_s
    push    edx
    push    print_string_format
    call    printf
    add     esp, 8

    xor eax, eax
    leave
    ret
