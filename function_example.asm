    ;; calling convention - its about how parameters lays on the stack,
    ;; registers and how performs value return
    ;; There is a standard calling convention System V AMD64 ABI

    ;; call instruction pushes rip register onto the stack
    ;; ret instruction pops and saves top of the stack into the rip register.

    ;; prologue - is the code at the beginning of the function
    ;; epilogue - is the code at the end of the function

    ;; The operations performed by the prologue and epilogue are generaly specified by standard
    ;; calling convention and deal with stack, registers, passed arguments and stack dynamic local variables.

    ;; Parameter passing through registers (calling convention):
    ;; rdi, rsi, rdx, rcx, r8,  r9
    ;; edi, esi, edx, ecx, r8d, r9d
    ;; di,  si,  dx,  cx,  r8w, r9w
    ;; dil, sil, dl,  cl,  r8b, r9b

    ;; Other arguments passed through the stack
    ;; The standard calling convention requires that, when passing arguments (values or addresses)
    ;; on the stack, the arguments   should   be  pushed   in   reverse   order.    That   is
    ;; "someFunc (one, two,three, four, five, six, seven, eight, nine)” would imply a push order
    ;; of: nine, eight, and then seven

    ;; rax - for return value

    ;; Example of function wich computes sum and average value

    section .data

    list dd 1, 2, 3, 4
    list_length dd 4
    sum dd 0
    average dd 0

    section .code
    global _start
    global sum_and_average

    ;; FUNCTION
sum_and_average:                ;(list, list_length, sum, average)
    push rbp                    ;prologue
    mov rbp, rsp
    push r12

    mov r12, 0                  ;counter/index
    mov rax, 0                  ;sum
sum_loop:
    add eax, dword [rdi + r12 * 4]
    inc r12
    cmp r12, rsi
    jl sum_loop

    mov dword [rdx], eax

    cdq
    idiv esi
    mov dword [rcx], eax

    pop r12
    pop rbp
    ret

    ;; FUNCTION
_start:
    mov rdi, list
    mov esi, dword [list_length]
    mov rdx, sum
    mov rcx, average
    call sum_and_average

    mov rax, 60
    mov rdi, 0
    syscall
