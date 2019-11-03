        ;; nasm -felf64 symbols.asm -o symbols.o && ld -o symbols symbols.o
        ;; objdump -tf -m intel symbols.o
        ;; objdump -D -M intel-mnemonic -tf symbols.o

        section .data

datavar1:       dq 1488
datavar2:       dq 42

        section .bss

bssvar1:        resq 4 * 1024 * 1024
bssvar2:        resq 1

        section .text

        extern somewhere
        global _start

        mov rax, datavar1
        mov rax, bssvar1
        mov rax, bssvar2
        mov rdx, datavar1

_start:
        jmp _start

        ret

textlabel:      dq 0
