section .text
    global _start

_start:
    call teste1
    mov ebx, 0
    mov eax, 1
    int 0x80

print_string:
    pusha
    mov ebx, 1
    mov eax, 4
    int 0x80
    popa
    ret

int_to_string:
    ; eax contém o número a ser convertido
    pusha
    mov edi, buffer_end
    mov ecx, 10

    convert_loop:
        xor edx, edx
        div ecx
        add dl, '0'
        dec edi
        mov [edi], dl
        test eax, eax
        jnz convert_loop

    mov edx, buffer_end
    sub edx, edi
    mov ecx, edi
    call print_string
    popa
    ret

teste1:
    pusha
    mov ebp, esp
    call teste2
    popa
    ret

teste2:
    pusha
    mov ebp, esp
    call stack_trace
    popa
    ret

stack_trace:
    pusha
    mov ebp, esp

    sub esp, 8
    ; esp       = actual_ebp
    ; esp-4     = *actual_ebp (next_ebp)
    mov [esp], ebp
    mov eax, [ebp]
    mov [esp-4], eax
    loop:
        cmp DWORD [esp-4], 2 ; if(*actual_ebp > 2)
        jnl end

        mov edx, len1
        mov ecx, msg1
        call print_string

        mov eax, [esp] ; eax = actual_ebp
        cmp eax, 2 ; if de novo
        jnl end
        
        mov eax, [eax] ; eax = *actual_ebp (next ebp)
        mov [esp-4], eax ; next_ebp = eax = *actual_ebp

        mov [esp], eax ; actual_ebp = (void*)*actual_ebp
        
        mov eax, [esp] ; eax = actual_ebp
        sub eax, 4 ; ret addr
        call int_to_string
        

        jmp loop

    end:
        add esp, 8
        popa
        ret

section .data
msg1 db "Call @", 0
len1 equ $ - msg1
buffer db 10 dup(0)
buffer_end equ $
