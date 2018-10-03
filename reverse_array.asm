    section .data

    numbers db 97, 98, 99, 100, 101
    numbers_length equ 5
    numbers_element_size equ 1

    new_line db 10

    section .text
    global _start

_start:

    ;; write numbers
    mov rax, 1
    mov rdi, 1
    mov rsi, numbers
    mov rdx, 5
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, new_line
    mov rdx, 1
    syscall

    mov rcx, numbers_length
    mov rbx, numbers
    mov r12, 0

push_loop:
    push qword [rbx + (r12 * numbers_element_size)]
    inc r12
    loop push_loop

    mov rcx, numbers_length
    mov rbx, numbers
    mov r12, 0

pop_loop:
    pop rax
    mov byte [rbx + (r12 * numbers_element_size)], al
    inc r12
    loop pop_loop

    ;; write numbers
    mov rax, 1
    mov rdi, 1
    mov rsi, numbers
    mov rdx, 5
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, new_line
    mov rdx, 1
    syscall

exit:
    mov rax, 60
    mov rdi, 0
    syscall
