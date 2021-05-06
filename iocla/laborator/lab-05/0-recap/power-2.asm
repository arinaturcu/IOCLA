%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
    
    mov ecx, 31

    test eax, ebx
    jz label
    PRINTF32 `%d\n\x0`, ebx

label:
    dec ecx
    cmp ecx, 0
    jle end

    shl ebx, 1
    test eax, ebx

    jz label

    PRINTF32 `%d\n\x0`, ebx
    
    jmp label

end:
    leave
    ret
