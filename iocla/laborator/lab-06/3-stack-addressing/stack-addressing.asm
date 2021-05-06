%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    push ecx
    loop push_nums

    mov edx, esp                       ; save current pointer in EDX

    ; push 0
    ; push "mere"
    ; push "are "
    ; push "Ana "

    sub esp, 1
    mov [esp], byte 0
    sub esp, 4
    mov [esp], dword "mere"
    sub esp, 4
    mov [esp], dword "are "
    sub esp, 4
    mov [esp], dword "Ana "

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    mov ecx, ebp           
    sub ecx, esp                       ; number of bytes in [ESP:EBP]

print_stack:
    mov eax, ebp
    sub eax, ecx
    PRINTF32 `0x%hx: \x0`, eax         ; print address
    PRINTF32 `%hhu\n\x0`, [eax]        ; print byte from address

    loop print_stack
    
    ; TODO 3: print the string

    mov ecx, edx
    sub ecx, esp

print_string_on_stack:
    mov eax, edx
    sub eax, ecx
    PRINTF32 `%c\x0`, [eax]           ; print byte from address

    loop print_string_on_stack

    PRINTF32 `\n\x0`

    ; TODO 4: print the array on the stack, element by element.

    mov ecx, NUM

print_array_on_stack:
    mov edx, ebp

    xor eax, eax                      ; EAX = 4 * ECX
    mov al, cl
    mov bl, 4
    mul bl

    sub edx, eax
    PRINTF32 `%d \x0`, [edx]
    loop print_array_on_stack

    PRINTF32 `\n\x0`

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
