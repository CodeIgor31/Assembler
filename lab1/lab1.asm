section .data ; сегмент инициализированных переменных
ExitMsg db "Press Enter to Exit",10 ; выводимое сообщение
lenExit equ $-ExitMsg
A dw -30
B dw 21
val1 db 255
chart dw 256
lue3 dw -128
v5 db 10h
bin db 100101B
beta db 23,23h,0ch
sdk db "Hello",10
min dw -32767
ar dd 12345678h
valar times 5 db 8

celoe dw 25
negat dd -35
name db 'Yagmurov Igor', "Ягмуров Игорь"

first db 37
sec dw 37
third dw 25h
fourth dw 100101b
fifth db "%"

f dd 9472
f_2 dd 2500h
f3 dd 10010100000000b

F1 dw 65535
F2 dd 65535
section .bss ; сегмент неинициализированных переменных
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf
X resd 1
alu resw 10
ff1 resb 5

section .text ; сегмент кода
global _start
_start:

;1.2.13
add word[F1],1
add dword[F2],1

; 1.2.10
mov eax,[A] ; загрузить число A в регистр EAX
add eax,5
sub eax,[B] ; вычесть число B, результат в EAX
mov[X],eax ; сохранить результат в памяти
; write
mov rax, 1 ; системная функция 1 (write)
mov rdi, 1 ; дескриптор файла stdout=1
mov rsi, ExitMsg ; адрес выводимой строки
mov rdx, lenExit ; длина строки
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