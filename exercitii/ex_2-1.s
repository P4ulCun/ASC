.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4
    rez: .space 4
    formatscanf: .asciz "%d %d"
    formatprintf: .asciz "x = %d , y = %d\n"
    formatrez: .asciz "rez = %d\n"
.text
.global main
main:
citire:
    pushl $y
    pushl $x
    pushl $formatscanf
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx

problema:
    movl x, %eax
    xorl %edx, %edx
    movl $16, %ebx
    divl %ebx
    movl %eax, rez

    movl y, %eax
    movl $16, %ebx
    mull %ebx
    addl %eax, rez
afisare:
    pushl rez
    pushl $formatrez
    call printf
    popl %ebx
    popl %ebx
problema2:
    movl y, %eax
    movl $256, %ebx
    mull %ebx
    addl x, %eax
    xorl %edx, %edx
    movl $16, %ebx
    divl %ebx
    movl %eax, rez

    pushl rez
    pushl $formatrez
    call printf
    popl %ebx
    popl %ebx
et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
