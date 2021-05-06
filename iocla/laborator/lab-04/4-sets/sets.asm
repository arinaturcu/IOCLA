%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; toate rezultatele sunt pastrate in edx inainte sa fie afisate

    ; TODO1: reuniunea a doua multimi
    mov edx, eax
    or  edx, ebx
    PRINTF32 `%u\n\x0`, edx

    ; TODO2: adaugarea unui element in multime
    mov edx, 1              ; adaug pe pozitia 5 si 11
    shl edx, 6 
    add edx, 1 
    shl edx, 5 
    or  edx, eax 
    PRINTF32 `%u\n\x0`, edx

    ; TODO3: intersectia a doua multimi
    mov edx, eax 
    and edx, ebx 
    PRINTF32 `%u\n\x0`, edx

    ; TODO4: complementul unei multimi
    mov edx, eax
    not edx 
    PRINTF32 `%u\n\x0`, edx

    ; TODO5: eliminarea unui element
    mov edx, 1
    shl edx, 7
    not edx
    and edx, eax 
    PRINTF32 `%u\n\x0`, edx
    
    ; TODO6: diferenta de multimi EAX-EBX
    mov edx, eax
    xor edx, ebx
    PRINTF32 `%u\n\x0`, edx

    xor eax, eax
    ret
