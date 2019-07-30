        ;; nasm -felf64 hello.asm -o hello.o && ld -o hello hello.o && ./hello

        section .data
message:        db "hello, world!", 10

        section .text
        global _start

_start:
        mov rax, 1              ; write syscall
        mov rdi, 1              ; stdout
        mov rsi, message
        mov rdx, 14
        syscall

        mov rax, 60             ; exit syscall
        xor rdi, rdi
        syscall
