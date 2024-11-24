.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    format_scanf: .asciz "%d"
    format_print: .asciz "factorialul numarului %d este %d\n"
.text
factorial:
    movl 4(%esp), %ecx
    cmpl $1, %ecx
    jg factorial_continue_recc

    ret
factorial_continue_recc:
    movl 4(%esp), %ebx

    xorl %edx, %edx
    mul %ebx

    decl %ebx
    pushl %ebx
    call factorial
    popl %ebx

    ret
.global main
main:
citire:
    pushl $n
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx

    movl $1, %eax
    pushl n
    call factorial
    popl %ebx

//in eax e rezultatul

afisare:
    pushl %eax
    pushl n
    pushl $format_print
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
et_exit:
    pushl $0
    call fflush
    popl %eax
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
