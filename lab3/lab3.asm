%include "lib64.asm"
section .data ; сегмент инициализированных переменных
Input_Q db "Input q: ",10 ; выводимое сообщение
lenQ equ $-Input_Q
Input_D db "Input d: ",10 ;
lenD equ $-Input_D
Res_text db "The result is: ", 10
section .bss ; сегмент неинициализированных переменных
q resw 1
Buf_Q resb 10 ; буфер для вводимой строки
d resw 1
Buf_D resb 10 ; буфер для вводимой строки
res resw 1 ; буфер для вводимой строки
Buf_res resb 10 ; буфер для вводимой строки
section .text ; сегмент кода
global _start
_start:
; write q
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_Q ; адрес выводимой строки
    mov rdx, lenQ ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_Q; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_Q
    call StrToInt64
    mov [q], rax

;write d
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_D ; адрес выводимой строки
    mov rdx, lenD ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_D; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_D
    call StrToInt64
    mov [d], rax
mov rax,[q]
cmp rax,10 ; сравнение q и 10
jl less ; переход по меньше
jmp else ; переход на конец ветвления
less:
mul rax
mov rcx, [d]
sub rcx, 5
cmp rcx, 0 ;ОДЗ
jz continue ;ОДЗ
idiv rcx
mov [res], rax
mov rcx, [d]
add [res], rcx
jmp continue

else:
mov rax, [d]
sub rax, [q]
imul rax, 5
mov [res], rax
continue:
;output
mov rsi, Buf_res
mov rax, [res]
call IntToStr64

mov rax, 1; системная функция 1 (write)
mov rdi, 1; дескриптор файла stdout=1
mov rsi, Res_text ; адрес выводимой строки
mov rdx, 15 ; длина строки
syscall  
                             
mov rax, 1; системная функция 1 (write)
mov rdi, 1; дескриптор файла stdout=1
mov rsi, Buf_res ; адрес выводимой строки
mov rdx, 5 ; длина строки
syscall    
; exit
mov rax, 60 ; системная функция 60
xor rdi, rdi ; return code 0syscall