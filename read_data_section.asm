; read 100 bytes from data section
section .data
msg db 'H'
n dq 1
section .text
global _start
loop:
  add qword [n], 1
  mov rax, 1  
  mov rdi, 1
  mov rsi, msg
  mov rdx, [n]
  syscall
  cmp qword [n], 100
  jne loop
  push qword _start+15
  ret

  
_start:
  mov qword [n], 1
  cmp qword [n], 100
  jne loop
  mov rax, 60
  mov rdi, 1
  syscall
