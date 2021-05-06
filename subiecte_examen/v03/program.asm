extern fgets
extern printf
extern stdin
extern strlen

section .data
    fmt_char: db "%c",  0
    fmt_newline: db 0xd, 0xa, 0
    len dd 128

section .bss
    arr resd 128
    mask resd 1

section .text
global main

do_something:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebp + 16]

wierd:
    mov dx, word[ebx + 2*(ecx - 1)]
    xchg dh, dl
    mov word[eax + 2*(ecx - 1)], dx
    dec ecx
    jnz wierd

    leave
    ret

main:
    enter 51, 0
    mov dword[ebp-12], 0x8badf00d

    push dword [stdin]
    push len
    lea eax, [ebp - 51]
    push eax
    call fgets
    add esp, 0xc

    lea eax, [ebp - 51]
    push eax
    call strlen
    add esp, 4
    dec eax
    mov byte[ebp + 1*eax - 51], 0
    mov dword[len], eax

    mov edx, dword[mask]
    not edx
    dec edx
    and eax, edx
    shr eax, 1
    jz the_end_my_dear

    push eax
    lea eax, [ebp-51]
    push eax
    push arr
    call do_something
    add esp, 12

    mov ecx, dword[len]
    xor edx, edx
    mov eax, arr
show_me:
    pusha
    push word[eax + edx]
    push fmt_char
    call printf
    add esp, 6
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
