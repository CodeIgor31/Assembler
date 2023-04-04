%include "../print.asm"
section .data ; сегмент инициализированных переменных
QMsg db "Enter q",10 ; выводимое сообщение
Qlen equ $ - QMsg
AMsg db "Enter a",10 ; выводимое сообщение
Alen equ $ - AMsg
RMsg db "Enter r",10 ; выводимое сообщение
Rlen equ $ - RMsg
section .bss ; сегмент неинициализированных переменных
q resw 1 ; буфер для вводимой строки
lenq equ $-q
a resw 1 ; буфер для вводимой строки
lena equ $-a
r resw 1 ; буфер для вводимой строки
lenr equ $-r
res resw 1
Reslen equ $-res
section .text ; сегмент кода
global _start
_start:
; write
;mov rax, 1 ; системная функция 1 (write)
;mov rdi, 1 ; дескриптор файла stdout=1
;mov rsi, QMsg ; адрес выводимой строки
;mov rdx, Qlen ; длина строки
;syscall ; вызов системной функции

;mov rax, 0
;mov rdi, 0
;mov rsi, q
;mov rdx, lenq
;syscall

;mov rax, 1 ; системная функция 1 (write)
;mov rdi, 1 ; дескриптор файла stdout=1
;mov rsi, AMsg ; адрес выводимой строки
;mov rdx, Alen ; длина строки
;syscall ; вызов системной функции

;mov rax, 0
;mov rdi, 0
;mov rsi, a
;mov rdx, lena
;syscall

;mov rax, 1 ; системная функция 1 (write)
;mov rdi, 1 ; дескриптор файла stdout=1
;mov rsi, RMsg ; адрес выводимой строки
;mov rdx, Rlen ; длина строки
;syscall ; вызов системной функции

; read
;mov rax, 0
;mov rdi, 0
;mov rsi, r
;mov rdx, lenr
;syscall
mov word[q], 1
mov word[r], 10
mov word[a], 0
;count
mov ax, [r]
mov bx, [r]
mul bx
mov [res], ax
 
mov ax, 2
imul word[q]
imul word[a]
sub [res], ax

mov ax, [a]
mov bx, [a]
mul bx
mul bx
mov cx, ax

cwd
idiv word[q]
mov cx, ax
add [res], cx

;mov rsi,[res]
;call StrToInt64
;cmp rbx, 0
;jne 1


mov rax, 1 ; системная функция 1 (write)
mov rdi, 1 ; дескриптор файла stdout=1
mov rsi, res ; адрес выводимой строки
mov rdx, Reslen ; длина строки
syscall ; вызов системной функции

; exit
mov rax, 60 ; системная функция 60
xor rdi, rdi ; return code 0
syscall