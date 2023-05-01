section .data
  msg db "String ",0
  inp db "bbbbbbbbbbb", 0
  n dd 0
  occ db 0

section .text
  global _start

  add_occ:
    add byte [occ], 1
    jmp number_of_occurrences+15

  number_of_occurrences:
    mov ebx, [n]
    cmp byte [inp + ebx], 'a'
    je add_occ

    add byte [n], 1
    cmp byte [n], 12
    jne number_of_occurrences

    ret

_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, 7
  syscall
  xor rax, rax
  mov rdi, 0
  mov rsi, inp
  mov rdx, 12
  syscall
  call number_of_occurrences
  mov rax, 1
  mov rdi, 1
  mov rsi, occ
  mov rdx, 4
  syscall
  mov rax, 60
  mov rdi, 1
  syscall

