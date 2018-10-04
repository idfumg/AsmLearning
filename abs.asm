    %macro abs 1
        cmp %1, 0
        jge %%done
        neg %1
%%done:
    %endmacro

    section .data

    section .text
    global _start

_start:

    mov rax, -1
    abs eax

exit:
    mov rax, 60
    mov rdi, 0
    syscall
