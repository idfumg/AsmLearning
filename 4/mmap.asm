               ; nasm -felf64 mmap.asm -o mmap.o && ld -o mmap mmap.o && ./mmap

        %define O_RDONLY 0
        %define PROT_READ 0x1
        %define MAP_PRIVATE 0x2

        section .data

fname:  db "test.txt", 0

        section .text

        global _start

print_char:
        push rcx
        mov rax, 1
        mov rdi, 1
        mov rsi, rsi
        mov rdx, 1
        syscall
        pop rcx
        ret

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

_start:
        ;; open
        mov rax, 2
        mov rdi, fname
        mov rsi, O_RDONLY
        mov rdx, 0
        syscall

        ;; mmap
        mov r8, rax             ; file descriptor in rax
        mov rax, 9
        mov rdi, 0
        mov rsi, 4096
        mov rdx, PROT_READ
        mov r10, MAP_PRIVATE
        mov r9, 0
        syscall

        mov rsi, rax
        call print_string

        mov rax, 60
        xor rdi, rdi
        syscall
