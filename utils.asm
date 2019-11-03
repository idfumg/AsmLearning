        ;; nasm -felf64 utils.asm -o utils.o

        ;; Your functions accept arguments in rdi, rsi, rdx, rcx, r8, and r9

        section .data
newline_char:   db 0xA
digitals:       db "0123456789", 0
char_buf:    db 0

        global exit
exit:                           ; (rsi)
        mov rax, 60
        mov rdi, rsi
        syscall

        global string_length
string_length:                  ; (rsi)
        xor rax, rax

        .loop:

        cmp byte[rsi + rax], 0
        je .end
        inc rax
        jmp .loop

        .end:
        ret

        global print_char
print_char:
        push rcx
        mov rax, 1
        mov rdi, 1
        mov rsi, rsi
        mov rdx, 1
        syscall
        pop rcx
        ret

        global print_newline
print_newline:
        push rsi
        mov rsi, newline_char
        call print_char
        pop rsi
        ret

        global print_string
print_string:                   ;(rsi)
        xor rax, rax

        .loop:

        cmp byte[rsi + rax], 0
        je .end

        push rsi
        push rax

        lea rsi, [rsi + rax]
        call print_char

        pop rax
        pop rsi

        inc rax
        jmp .loop

        .end:
        ret

        global print_n_times
print_n_times:
        .loop:

        test rcx, rcx
        jz .end

        mov rsi, rsi
        push rcx
        call print_char
        pop rcx

        dec rcx
        jmp .loop

        .end:
        ret

        global print_uint
print_uint:
        xor rcx, rcx

        test rsi, rsi
        jz .print_stack_loop_zero_param

        .loop:

        test rsi, rsi
        jz .print_stack_loop

        mov rax, rsi
        mov rbx, 10
        mov rdx, 0
        div rbx

        mov rsi, rax
        mov rax, [digitals + rdx]

        inc rcx
        push rax

        jmp .loop

        .print_stack_loop_zero_param:

        inc rcx
        push "0"

        .print_stack_loop:

        test rcx, rcx
        jz .print_stack_loop_end

        mov rsi, rsp
        call print_char
        pop rax
        dec rcx

        jmp .print_stack_loop

        .print_stack_loop_end:

        ret

        global print_int
print_int:
        xor rcx, rcx

        test rsi, rsi
        jz .print_stack_loop_zero_param

        mov rax, 0
        cmp rsi, rax
        jge .loop

        neg rsi
        push rsi
        push "-"
        mov rsi, rsp
        call print_char
        pop rsi
        pop rsi

        .loop:

        test rsi, rsi
        jz .print_stack_loop

        mov rax, rsi
        mov rbx, 10
        mov rdx, 0
        div rbx

        mov rsi, rax
        mov rax, [digitals + rdx]

        inc rcx
        push rax

        jmp .loop

        .print_stack_loop_zero_param:

        inc rcx
        push "0"

        .print_stack_loop:

        test rcx, rcx
        jz .print_stack_loop_end

        mov rsi, rsp
        call print_char
        pop rax
        dec rcx

        jmp .print_stack_loop

        .print_stack_loop_end:

        ret

        global string_equals
string_equals:
        .loop:

        mov al, byte[rbx]
        test al, al
        jz .end_equals_1

        mov cl, byte[rdx]
        test cl, cl
        jz .end_equals_2

        cmp al, cl
        jnz .end_not_equals

        inc rbx
        inc rdx

        jmp .loop

        .end_not_equals:
        mov rax, 0
        ret

        .end_equals_1:
        mov rcx, [rdx]
        test rcx, rcx
        jnz .end_not_equals
        mov rax, 1
        ret

        .end_equals_2:
        mov rax, [rbx]
        test rax, rax
        jnz .end_not_equals
        mov rax, 1
        ret

        global string_copy
string_copy:
        mov r9, rdx
        dec rcx

        .loop:

        test rcx, rcx
        jz .end_buffer_is_too_small

        mov al, byte[rbx]
        test al, al
        jz .end

        mov byte[rdx], al
        inc rdx
        inc rbx
        dec rcx

        jmp .loop

        .end:
        inc rdx
        mov rdx, 0
        mov rax, r9
        ret

        .end_buffer_is_too_small:
        mov rax, 0
        ret

        global parse_uint
parse_uint:
        xor rbx, rbx
        xor rcx, rcx
        xor r9, r9
        mov r8, 10

        .loop:

        mov al, byte[rsi]
        test al, al
        jz .end

        sub rax, 48
        mov rbx, rax
        mov rax, r9
        mul r8
        and rbx, 0x00000000000000FF
        add rax, rbx
        mov r9, rax

        inc rsi
        jmp .loop

        .end:
        mov rax, r9
        mov rdx, rcx
        ret

        global parse_int
parse_int:
        xor rbx, rbx
        xor rcx, rcx
        xor r9, r9
        mov r8, 10
        mov r10, 0

        mov al, byte[rsi]
        cmp al, "-"
        jne .loop

        mov r10, 1
        inc rsi

        .loop:

        mov al, byte[rsi]
        test al, al
        jz .end

        sub rax, 48
        mov rbx, rax
        mov rax, r9
        mul r8
        and rbx, 0x00000000000000FF
        add rax, rbx
        mov r9, rax

        inc rsi
        jmp .loop

        .end:
        cmp r10, 1
        jne .end_final

        neg r9

        .end_final:
        mov rax, r9
        mov rdx, rcx
        ret
