section .data ; сегмент инициализированных переменных
A db 35
B db 40
section .bss ; сегмент неинициализированных переменных
C resb 10
lenIn equ $-C
section .text ; сегмент кода
global _start
_start:
; count
mov rax, [A] 
add rax, [B]
mov [C], rax
mov rcx, [C] ; адрес выводимой строки

; print
mov rax, 1
mov rdi, 1
mov rsi, C
mov rdx, 10
syscall

; exit
mov rax, 60 ; системная функция 60
xor rdi, rdi ; return code 0
syscall

;mov rax, 1 ; системная функция 1 (write)
;mov rdi, 1 ; дескриптор файла stdout=1
;mov rsi, ExitMsg ; адрес выводимой строки
;mov rdx, lenExit ; длина строки
;syscall ; вызов системной функции