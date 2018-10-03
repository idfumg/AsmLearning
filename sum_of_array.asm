    ;; sum of array values

    section .data

    total dq 0
    list dq 1002, 1004, 1006, 1008, 10010, 10011
    list_length equ 5
    list_element_size equ 4

    section .text
    global _start

_start:
    mov rcx, list_length
    mov rsi, 0                  ;index
sum_loop:
    mov rax, qword [list + (rsi * list_element_size)]
    add qword [total], rax
    inc rsi
    loop sum_loop

exit:
    mov rax, 60
    mov rsi, 0
    syscall
