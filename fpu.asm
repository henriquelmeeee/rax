section .data
  dq float_number1 1.50
  dq float_number2 2.50
section .text

global _start

_start:
  fld [float_number1] ; carrega float_number1 em S0
  fld [float_number2] ; carrega float_number2 em S0
  ; float_number1 ficará em S1
  faddp s0, s1 
  ; faz s0+s1, armazena o resultado em s1, move s1 para s0 por conta do     ; pop
  
  ; agora S0 = float_number1 + float_number2
  ; vamos adicionar mais uma vez
  
  fld [float_number2] ; ficará em S0
  ; portanto, resultado (S0) será movido para S1
  faddp s0, s1
  ; s0 = s0 + float_number2
