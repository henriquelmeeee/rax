global _start

section .text
msg db 'Programa finalizado com sucesso', 0
len equ $ - msg
end:
  mov rax, 60
  xor rdi, rdi
  syscall

print:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, len 
  syscall
  jmp end


loop:
  sub edi, 1
  cmp edx, edi
  je print

  jmp loop

_start:
  mov edx, 1
  mov edi, 8
  cmp edx, edi
  je print

  jmp loop
