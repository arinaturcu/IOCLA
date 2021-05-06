%include "../utils/printf32.asm"

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    mov eax, 15
    push eax
    dec eax
    PRINTF32 `%hhu\n\x0`, eax    
    pop eax
    PRINTF32 `%hhu\n\x0`, eax

end:
    leave
    ret
