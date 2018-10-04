    ;; Convert 12345 -> "12345"

    section .data

    NULL equ 0
    EXIT_SUCCESS equ 0
    SYSCALL_exit equ 60

    number dd 1498

    section .bss

    number_string resb 10

    section .text
    global _start

_start:

    ;; division by 10 and pushking onto the stack
    mov eax, dword [number]
    mov rcx, 0                  ; digit count
    mov ebx, 10                 ; divider

divide_loop:
    mov edx, 0                  ; clear high part for div quad word
    div ebx
    push rdx
    inc rcx
    cmp eax, 0
    jne divide_loop

    ;; convert remainders and store into the string
    mov rbx, number_string
    mov rdi, 0                  ; current idx

pop_loop:
    pop rax
    add al, "0"
    mov byte [rbx + rdi], al
    inc rdi
    loop pop_loop

    ;; null terminate the string
    mov byte[rbx + rdi], NULL

exit:
    mov rax, SYSCALL_exit
    mov rdi, EXIT_SUCCESS
    syscall
