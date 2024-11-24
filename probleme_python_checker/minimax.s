.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    m: .space 4
    mat: .space 40000

    format_scanf_n_m: .asciz "%d %d"
    format_endl: .asciz "\n"
    format_print_int: .asciz "%d"
    format_print_yes: .asciz "Yes\n"
    format_print_no: .asciz "No\n"
.text
minimax:

.global main
main:
citire:
    pushl $s
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx

    lea s, %edi
program:
    movl %ecx, len

    pushl $s
    pushl $0
    pushl len
    call palindrome
    popl %eax
    popl %eax
    popl %eax

et_exit:
    pushl $0
    call fflush
    popl %ebx
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
