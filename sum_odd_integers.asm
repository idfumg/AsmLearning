    ;; sum of odd integers

    section .data

    total dq 10
    count dq 0

    section .text
    global _start

_start:
    mov rcx, qword [total]
    mov rax, 1

sum_of_odds_loop:
    add qword [count], rax
    add rax, 2
    loop sum_of_odds_loop

exit:
    mov rax, 60
    mov rdi, 0
    syscall
