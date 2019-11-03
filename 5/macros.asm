        ;; nasm -felf64 macros.asm -o macros.o && ld -o macros macros.o && ./macros

        %macro print 1
          %ifid %1
            mov rsi, %1
            call print_string
          %else
            %ifnum %1
              mov rsi, %1
              call print_uint
            %else
              %error "String literals are not supported yet"
            %endif
          %endif
        %endmacro

        section .data

myhello:        db "hello", 10, 0

        section .text

        extern print_string
        extern print_uint
        extern exit

        global _start
_start:
        print myhello
        print 42

        mov rsi, 0
        call exit
