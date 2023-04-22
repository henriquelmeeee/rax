global _start

section .text
msg db 'Hello, World!', 0
_start:
    mov eax, 4 ; id 4 syscall write
    mov ebx, 1 ; fd stdout
    mov ecx, dword (msg) ; msg address (buffer)
    mov edx, 14 ; 2 bytes write
    int 0x80 ; syscall (interrupt)
    mov eax, 1 ; id 4 syscall exit
    xor ebx, ebx ; set to zero the exitcode
    int 0x80 ; syscall (interrupt)
