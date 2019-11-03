        ;; nasm -f elf64 -o libso_main.o libso_main.asm
        ;; nasm -f elf64 -o libso.o libso.asm
        ;; ld -shared -o libso.so libso.o --dynamic-linker=/lib64/ld-linux-x86-64.so.2
        ;; ld -o libso_main libso_main.o -d libso.so

        global _start

        extern func

        section .text

_start:
        mov rdi, 10
        call func

        mov rdi, rax
        mov rax, 60
        syscall
