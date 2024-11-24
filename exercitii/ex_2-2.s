.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4
    rez1: .space 4
    rez2: .space 4
    s1: .asciz "PASS\n"
    s2: .asciz "FAIL\n"
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
    movl %eax, rez1

    movl y, %eax
    movl $16, %ebx
    mull %ebx
    addl %eax, rez1

problema2:
    movl y, %eax
    movl $256, %ebx
    mull %ebx
    addl x, %eax
    xorl %edx, %edx
    movl $16, %ebx
    divl %ebx
    movl %eax, rez2

    movl rez1, %eax
    movl rez2, %ebx
    cmpl %eax, %ebx
    je egale

    pushl $s2
    call printf
    popl %ebx
    jmp et_exit
egale:
    pushl $s1
    call printf
    popl %ebx
et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
