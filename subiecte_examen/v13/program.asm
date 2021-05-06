extern printf
extern fgets
extern stdin
extern atoi

section .rodata
    fmt db "%d ", 0
    NL db 10, 0

section .data
    ; array v and its length
    v dd 10, 20, 30, 40, 50, 60, 70, 90, 70, 70
    len dd 10

    ; buffer size to store data read from stdin
    buf_size dd 128

    ; test val
    val dd ?

section .text
global main

; print all elements of array v, starting at index 0, separated by a space.
; print_array(int *v, int len)
print_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    mov edx, [ebp+12]

    xor ecx, ecx

.again:
    mov eax, [ebx + ecx * 4]
    push edx
    push ecx
    push eax
    push fmt
    call printf
    add esp, 8

    pop ecx
    pop edx

    inc ecx
    cmp ecx, edx
    jne .again

    leave
    ret

; Replace all occurences of a value val with 0 in array v.
; void replace(int *v, int len, int val)
replace:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8] ; v
    mov edx, [ebp+12]; len
    mov esi, [ebp+16]; val

    xor ecx, ecx ; loop index
.again:
    mov edi, [ebx + ecx * 4]
    cmp esi, edi
    jne .continue
    ;val found, replace with 0
    mov dword [ebx + ecx * 4], 0
.continue:
    inc ecx
    cmp ecx, edx
    jne .again

    leave
    ret

main:
    push ebp
    mov ebp, esp

    sub esp, 28
    mov dword [ebp-4], 0x12345678

    push dword [stdin]
    push buf_size
    lea eax, [ebp - 28]
    push eax
    call fgets
    add esp, 0xc

    ; convert string to integer
    lea eax, [ebp - 28]
    push eax
    call atoi
    add esp, 4

    ; store integer read from stdin to val
    mov dword [val], eax

    ; print val
    push dword [val]
    push fmt
    call printf
    add esp, 8

    ; NEWLINE
    push dword NL
    call printf
    add esp, 4

    ; print elements of array v
    push dword [len]
    push v
    call print_array
    add esp, 8

    ; NEWLINE
    push dword NL
    call printf
    add esp, 4

    ; replace with 0 all occurences of value val in array v
    push dword [val]
    push dword [len]
    push v
    call replace
    add esp, 12

   ; print elements of array v again
    push dword [len]
    push v
    call print_array
    add esp, 8

    ; NEWLINE
    push dword NL
    call printf
    add esp, 4

out:
    ; Return 0.
    xor eax, eax
    leave
    ret
