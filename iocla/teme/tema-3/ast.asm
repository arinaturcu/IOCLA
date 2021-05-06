
section .data
    delim db " ", 0
    format db "%s", 10, 0
    debug db "buna ", 0
    is_neg db 0

section .bss
    root resd 1

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern malloc
extern strdup
extern strtok
extern printf

global create_tree
global iocla_atoi

iocla_atoi: 
    push    ebp
    mov     ebp, esp

    push    ebx
    push    ecx
    push    edx

    mov     ebx, [ebp + 8]          ; the funcion parameter
    mov     ecx, 10

    xor     edx, edx                ; form the number in edx

    cmp     byte [ebx], 0x2D        ; check if number is negative by looking for '-' character
    jne     start
    inc     byte [is_neg]
    inc     ebx

    mov     ecx, 10
    xor     edx, edx                ; form the number in edx

start: 
    mov     eax, edx                ; edx = edx * 10 + (byte[ebx] - '0')
    mul     ecx
    mov     dword edx, eax
    xor     eax, eax
    mov     al, byte [ebx]
    sub     al, byte 0x30           ; 0x30 = '0'
    add     edx, eax

    inc     ebx                     
    cmp     byte [ebx], byte 0      ; check if the current character is '\0'
    jne     start

    cmp     byte [is_neg], 0
    je      end
    neg     dword edx

end:
    mov     eax, edx
    mov     byte [is_neg], 0
    pop     edx
    pop     ecx
    pop     ebx
    leave
    ret

my_create_node:
    push    ebp
    mov     ebp, esp

    push    ebx
    push    ecx
    push    edx

    mov     edx, dword [ebp + 8]                  ; data

    mov     ecx, 12    
    push    ecx                                   ; allocates memory for node
    call    malloc
    add     esp, 4
    push    eax

    push    dword [ebp + 8]
    call    strdup
    add     esp, 4
    mov     ebx, eax

    pop     eax
    mov     dword [eax], ebx
    mov     dword [eax + 4], dword 0
    mov     dword [eax + 8], dword 0 

    pop     edx
    pop     ecx
    pop     ebx

    leave
    ret


is_number:                                    ; checks if data of a given node is number
    push    ebp                               ; returns 1 if data is number and 0 if data is operand
    mov     ebp, esp

    push    ebx
    xor     eax, eax

    mov     ebx, [ebp + 8]                         ; ebx is pointer to data

    cmp     byte [ebx], 45                         ; 45 = '-'
    je      check_negative
    cmp     byte [ebx], 43                         ; 43 = '+'
    je      end_is_not_number
    cmp     byte [ebx], 42                         ; 42 = '*'
    je      end_is_not_number
    cmp     byte [ebx], 47                         ; 47 = '/'
    je      end_is_not_number

    inc     eax
    jmp     end_is_not_number

check_negative:
    cmp     byte [ebx + 1], 48
    jl      end_is_not_number
    cmp     byte [ebx + 1], 57
    jg      end_is_not_number
    inc     eax

end_is_not_number:
    pop     ebx
    leave
    ret

get_next:
    push    ebp
    mov     ebp, esp

    push    delim
    push    dword 0
    call    strtok
    add     esp, 8

    leave
    ret

add_nodes:                            ; adds the nodes to the tree
    push    ebp
    mov     ebp, esp

    mov     edx, [ebp + 8]            ; root address
    mov     ebx, [ebp + 12]           ; string (current string)

    cmp     byte [ebx], 0             ; if (current_string starts with '\0') return
    je      end_add

    push    edx                       ; create a new node
    push    ebx
    call    my_create_node
    add     esp, 4
    pop     edx

    mov     [edx], eax

    push    edx
    push    ebx
    call    is_number
    add     esp, 4
    pop     edx

    cmp     eax, 1                    ; if ebx is number return because numbers
    je      end_add                   ; are leaves

    push    edx
    call    get_next
    mov     ebx, eax 
    pop     edx

    push    edx                       ; recursive call
    mov     edx, [edx]
    add     edx, 4
    push    ebx
    push    edx
    call    add_nodes
    add     esp, 8

    pop edx

    push    edx
    call    get_next
    mov     ebx, eax
    pop     edx

    push    edx                       ; recursive call
    mov     edx, [edx]
    add     edx, 8
    push    ebx
    push    edx
    call    add_nodes
    add     esp, 8

    pop     edx

end_add:
    mov eax, edx
    leave
    ret

create_tree:
    enter   0, 0
    
    push    ebx
    push    ecx
    push    edx

    mov     ebx, [ebp + 8]                    ; string

    xor     eax, eax

    push    delim
    push    ebx
    call    strtok
    add     esp, 8
    mov     ebx, eax                          ; ebx = string with ' ' replaced with '\0'  

    push    ebx                               ; string
    push    root                              ; root address
    call    add_nodes
    add     esp, 8

    mov     eax, [root]

    pop     edx
    pop     ecx
    pop     ebx

    leave
    ret
