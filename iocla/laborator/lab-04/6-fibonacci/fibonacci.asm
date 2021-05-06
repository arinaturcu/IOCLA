%include "../io.mac"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7

    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    
    mov ecx, eax;    ; increment
    mov ebx, 0
    mov edx, 1
    
fib:
    mov eax, ebx
    add eax, edx
    
    mov ebx, edx
    mov edx, eax
    
    loop fib
    
    PRINTF32 `%d\n\x0`, eax

    ret
    
