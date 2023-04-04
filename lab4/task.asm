%include "lib64.asm"

section .data ; сегмент инициализированных переменных
    A_text db "Your Matrix: ", 10
section .bss ; сегмент неинициализированных переменных
    Matrix resd 21;
    Buf_A resd 1 ; буфер для вводимой строки
    Buf_B resd 1; буфер для выводимой строки
   
section .text ; сегмент кода

global _start
_start:
    ;Init matrix
	mov rbx,0 ;индекс
    	mov rcx, 21
        cycle:
            push rcx
            push rbx
            mov rax, 0; системная функция 0 (read)
            mov rdi, 0; дескриптор файла stdin=0
            mov rsi, Buf_A; адрес вводимой строки
            mov rdx, 4; длина строки
            syscall
            mov rsi, Buf_A
            call StrToInt64
            pop rbx
            mov [rbx*4+Matrix], rax
            inc rbx
            pop rcx
         loop cycle

        	mov rbx,-1 ;индекс
        	mov rcx,21
        
    render: 
         inc rbx
         mov rax, rbx
         shr rax,1 ;сдвигаем все биты вправо с выносом крайнего в cf
         jc not_chet 
         mov dword[rbx*4 + Matrix], 0
       not_chet: loop render
       
       
      ; Вывод
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, A_text ; адрес выводимой строки
    mov rdx, 13 ; длина строки
    syscall  
      
    mov rbx,0 ;индекс
    mov rcx, 21
    output:
        push rcx
        mov rsi, Buf_B
        mov rax, [rbx*4+Matrix]
        call IntToStr64
        push rbx
        mov rdx, rax
        mov rax, 1; системная функция 1 (write)
        mov rdi, 1; дескриптор файла stdout=1
        mov rsi, Buf_B ; адрес выводимой строки
        syscall 
        pop rbx   
        inc rbx
        pop rcx
    loop output
    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall
