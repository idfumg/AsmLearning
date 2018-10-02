    ;; sum of squares 1**2 + 2**2 + ... + n**2

    section .data

    total dq 0
    n dq 10

    section .text
    global _start

_start:
    mov rcx, qword [n]
    mov rbx, 1                  ; counter
sum_of_squares_loop:
    mov rax, rbx
    mul rax
    add qword [total], rax
    inc rbx
    loop sum_of_squares_loop

exit:
    mov rax, 60
    mov rdi, 0
    syscall
