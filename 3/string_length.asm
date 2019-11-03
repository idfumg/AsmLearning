        ;; nasm -felf64 string_length.asm -o string_length.o && ld -o string_length string_length.o && ./string_length

        section .data

test_string:    db "abcdef", 0

        section .text

strlen:
        xor rax, rax

        .loop:
        cmp byte[rdi + rax], 0
        je .end
        inc rax
        jmp .loop

        .end:
        ret

        global _start
_start:
        mov rdi, test_string
        call strlen
        mov rdi, rax
        mov rax, 60
        syscall
