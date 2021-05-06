extern fgets
extern printf
extern stdin
extern malloc
extern atoi
extern strcspn

section .data
	fmt_dec: db "%d ", 0
    fmt_crlf: db  0xd, 0xa, 0
    len dw 128

section .bss
    arr resd 128

section .text
global main

do_something:
    push ebp
    mov ebp, esp

    xor ebx, ebx
    mov edi, [ebp + 8]
    mov esi, [ebp + 12]
    mov ecx, [ebp + 16]

loop:
    mov eax, dword [esi]
    mul eax
    mov dword[edi], eax
    inc ebx
    add esi, 4
    add edi, 4
    cmp ebx, ecx
    jl loop

    mov eax, [ebp + 8]
    leave
    ret

main:
    enter 43, 0
    xor ecx, ecx
    mov dword[ebp + ecx - 8], 0xac0010ff

    push dword [stdin]
    push len
    lea eax, [ebp - 43]
    push eax
    call fgets
    add esp, 12

    lea eax, [ebp-43]
    push eax
    call atoi
    add esp, 4

    cmp eax, 0
    jle the_end

    xor ebx, ebx
    mov bx, word[len]
    cmp eax, ebx
    jg the_end

    mov ecx, eax
init:
    mov dword[arr + 4*ecx - 4], ecx
    loopnz init

    mov edx, eax
    shl edx, 2
    push edx
    call malloc
    pop edx

    shr edx, 2
    push edx
    push arr
    push eax
    call do_something
    add esp, 8
    pop edx

    xor ecx, ecx
show_me:
    push ecx
    push eax
    push edx
    push dword[eax + 4*ecx]
    push fmt_dec
    call printf
    add esp, 8
    pop edx
    pop eax
    pop ecx

    inc ecx
    cmp ecx, edx
    jl show_me

    push fmt_crlf
    call printf
    add esp, 4

the_end:
    xor eax, eax
    leave
    ret


  