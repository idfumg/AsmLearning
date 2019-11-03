        ;; nasm -felf64 app.asm -o app.o && ld -o app app.o utils.o && ./app

        section .data
TEST_UINT:      equ 67890
TEST_INT:      equ -67890
test_string:    db "abcdefqwe", 0
test_string2:    db "abcdef", 0
test_buf:       times 100 db 0
test_number:    db "123560", 0
test_neg_number:    db "-123456", 0

        section .text

        extern print_string
        extern print_newline
        extern print_uint
        extern print_int
        extern string_length
        extern string_equals
        extern string_copy
        extern parse_uint
        extern parse_int
        extern exit

        global _start
_start:
        mov rsi, test_string
        call print_string
        call print_newline

        mov rsi, TEST_UINT
        call print_uint
        call print_newline

        mov rsi, 0
        call print_uint
        call print_newline

        mov rsi, TEST_INT
        call print_int
        call print_newline

        mov rsi, 0
        call print_int
        call print_newline

        mov rsi, test_string
        call string_length
        mov rsi, rax
        call print_uint
        call print_newline

        mov rbx, test_string
        mov rdx, test_string2
        call string_equals
        mov rsi, rax
        call print_uint
        call print_newline

        mov rbx, test_string
        mov rdx, test_buf
        mov rcx, 100
        call string_copy
        mov rsi, rax
        call print_string
        call print_newline

        mov rsi, test_number
        call parse_uint
        mov rsi, rax
        call print_uint
        call print_newline

        mov rsi, test_neg_number
        call parse_int
        mov rsi, rax
        call print_int
        call print_newline

        mov rsi, rax
        call exit
