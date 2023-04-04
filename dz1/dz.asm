%include "lib64.asm"
section .data ; сегмент инициализированных переменных
Input_str db "Input string(34 symbols): ",10 ; выводимое сообщение
lenstr equ $-Input_str
Res_text db "The result is: ", 10
section .bss ; сегмент неинициализированных переменных
string resb 34
counter resb 2
buf_counter resb 2
section .text ; сегмент кода
global _start
_start:
; write string
 mov rax, 1; системная функция 1 (write)
 mov rdi, 1; дескриптор файла stdout=1
 mov rsi, Input_str ; адрес выводимой строки
 mov rdx, lenstr ; длина строки
 ; вызов системной функции
 syscall
  
 ; read
 mov rax, 0; системная функция 0 (read)
 mov rdi, 0; дескриптор файла stdin=0
 mov rsi, string; адрес вводимой строки
 mov rdx, 34; длина строки
 ; вызов системной функции
 syscall


; counting
mov byte[counter], 0
mov rdx, 0
mov rsi, 0
mov rbx,0 ;индекс
mov rcx, 34
jmp cycle
check:
    cmp al, 'e'
    je yes
    jmp back
yes:
    inc rsi
    cmp rsi, 2
    jge check_word
    jmp back 
     
check_word:
    cmp rdx, 1
    jne plus 
    jmp back
plus: 
    inc byte[counter]
    mov rdx, 1
cycle:
    mov al, [rbx+string]
    cmp al, ' '
    jne check
    mov rsi, 0
    mov rdx, 0
  back:
    inc rbx
    loop cycle
    
;output
mov rsi, buf_counter
mov rax, [counter]
call IntToStr64

mov rax, 1; системная функция 1 (write)
mov rdi, 1; дескриптор файла stdout=1
mov rsi, Res_text ; адрес выводимой строки
mov rdx, 15 ; длина строки
syscall  
                             
mov rax, 1; системная функция 1 (write)
mov rdi, 1; дескриптор файла stdout=1
mov rsi, buf_counter ; адрес выводимой строки
mov rdx, 5 ; длина строки
syscall 
mov rax, 60 ; системная функция 60
xor rdi, rdi ; return code 0
syscall