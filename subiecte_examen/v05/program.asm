extern fgets
extern printf
extern stdin
extern strlen
extern putchar
extern malloc

section .data
    fmt_newline: db 0xd, 0xa, 0
    len dd 128

section .bss
    arr resd 1
    mask resd 1

section .text
global main

do_something:
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]
    mov esi, [ebp + 12]
    mov ecx, [ebp + 16]

    xor ecx, ecx
to_network:
    xor edx, edx
    mov dl, byte[esi + ecx]
    shl edx, 8
    mov dl, byte[esi + 4*ecx + 1]
    shl edx, 8
    mov dl, byte[esi + 4*ecx + 2]
    shl edx, 8
    mov dl, byte[esi + 4*ecx + 3]

    mov dword[edi + 4*ecx], edx

    inc ecx
    cmp ecx, dword[ebp + 16]
    jl to_network

    mov eax, ecx
    leave
    ret

main:
    enter 33, 0
    mov dword[ebp-4], 0xdead10cc

    push dword [stdin]
    push len
    lea eax, [ebp - 33]
    push eax
    call fgets
    add esp, 0xc

    lea eax, [ebp - 33]
    push eax
    call strlen
    add esp, 4
    dec eax
    mov byte[ebp + 1*eax - 33], 0
    mov dword[len], eax

    mov edx, dword[mask]
    not edx
    dec edx
    and eax, edx
    shr eax, 2
    jz the_end_my_dear

    push len
    call malloc
    add esp, 4
    mov dword[arr], eax

    push eax
    lea eax, [ebp-33]
    push eax
    push dword[arr]
    call do_something
    add esp, 12

    mov ecx, dword[len]
    xor edx, edx
    mov eax, dword[arr]
show_me:
    pusha
    xor ebx, ebx
    mov bl, byte[eax + edx]
    push ebx
    call putchar
    add esp, 4
    popa
    inc edx
    cmp edx, ecx
    jne show_me

    push fmt_newline
    call printf
    add esp, 4

the_end_my_dear:
    xor eax, eax
    leave
    ret
