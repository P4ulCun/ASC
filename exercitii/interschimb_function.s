.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4

    format_scanf: .asciz "%d %d"
    format_print_yes: .asciz "Yes\n"
    format_print_no: .asciz "No\n"
    format_print: .asciz "x= %d si y= %d\n"
.text
interschimb:
    pushl %ebp
    movl %esp, %ebp
    movl 12(%esp), %ebx
    movl 8(%esp), %eax

    popl %ebp
    ret
.global main
main:
citire:
    pushl $y
    pushl $x
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx

program:
    pushl y
    pushl x
    call interschimb
    popl %ecx
    popl %ecx

    movl %ebx, x
    movl %eax, y
afisare:
    pushl y
    pushl x
    pushl $format_print
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
et_exit:
    pushl $0
    call fflush
    popl %ebx
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
