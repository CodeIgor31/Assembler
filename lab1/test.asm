section .data ; сегмент инициализированных переменных
ExitMsg db "Press Enter to Exit",10 ; выводимое сообщение
lenExit equ $-ExitMsg
A dw 5
B dw -5 
section .bss ; сегмент неинициализированных переменных
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf
section .text ; сегмент кода
global _start
_start:
; write
mov ax, [B]
syscall ; вызов системной функции
; read
mov rax, 0 ; системная функция 0 (read)
mov rdi, 0 ; дескриптор файла stdin=0
mov rsi, InBuf ; адрес вводимой строки
mov rdx, lenIn ; длина строки
syscall ; вызов системной функции
; exit
mov rax, 60 ; системная функция 60
xor rdi, rdi ; return code 0
syscall