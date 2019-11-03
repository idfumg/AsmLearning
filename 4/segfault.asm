        ;; nasm -felf64 segfault.asm -o segfault.o && ld -o segfault segfault.o && ./segfault
        ;; code segment starts at 0x400000
        ;; you can see it in /proc/PID/maps

        section .data
correct:        dq -1

        section .text

        global _start
_start:
        mov rax, 1

        mov rax, [0x400000 - 1]

        mov rax, 60
        xor rdi, rdi
        syscall
