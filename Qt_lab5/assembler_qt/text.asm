global COMPARE
segment .text
COMPARE:       ;rdi str1
        push RBP        ;rsi size1
        mov RBP,RSP     ;rdx str2
        cmp RSI, R10    ;r10 size2
        jle less        ;r8 str_res
        mov RCX, R10
        jmp cont
    less:
        mov RCX, RSI
    cont:
        mov RSI, RDX
        mov RDX, 0
        cld
    cycle:
        push rcx
        cmpsb
        jne enter
    add_char:
        mov rax, 0
        mov al, [rsi-1]
        mov [R8+RDX], AL
        inc RDX
        jmp loop_pl
    enter:
        mov byte[R8+RDX], ' '
        inc rdx
    loop_pl:
        pop rcx
        loop cycle

        mov rsp, rbp
        pop rbp
        ret
