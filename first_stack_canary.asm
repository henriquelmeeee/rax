; First Stack Canary implementation with ASM
; by Henrique

global _start

section .text

crash:
  mov rax, 60
  mov rdi, 1
  syscall

init_canary:
  push 0x25 ; adiciona o valor do stack canary original na stack
  mov rax, qword [rsp] ; armazena ele em rax
  add rsp, 8 ; volta para o ret address
  ret

_start:
  call init_canary ; inicializa o stack canary
  sub rsp, 16 ; volta para o stack pointer original (no momento do push no init_canary) -- passa pelo ret addr (8 bytes) + 8 bytes para o primeiro byte do stack canary
  cmp rax, qword [rsp] ; verifica se o valor do stack canary continua o mesmo
  jne crash ; pula para uma rotina de handle em caso do canary estar corrompido
  mov rax, 60 
  mov rdi, 1  ; <-- exit
  syscall
