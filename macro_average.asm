    ;; cdq
    ;; convert double word to quad word
    ;; copy most significant bit of eax to all bits of edx
    ;; (cwd convert word to double word)

    %macro average 3            ; list length result

    mov eax, 0
    mov ecx, dword [%2]
    mov r12, 0
    lea rbx, [%1]

%%sum_loop:
    add eax, dword [rbx + r12 * 4]
    inc r12
    loop %%sum_loop

    cdq
    idiv dword [%2]
    mov dword [%3], eax

    %endmacro

    section .data

    list dd 4, 5, 2, -3, 1
    list_length dd 5
    list_average dd 0

    section .text
    global _start

_start:
    average list, list_length, list_average

    mov rax, 60
    mov rdi, 0
    syscall
