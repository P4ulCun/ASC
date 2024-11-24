.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    y: .space 4
    formatscanf: .asciz "%d %d"
    formatprintf: .asciz "x = %d , y = %d\n"
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
    movl x,%eax
    movl y,%ebx
    movl %eax, y
    movl %ebx, x
afisare:
    pushl y
    pushl x
    pushl $formatprintf
    call printf
    popl %ebx
    popl %ebx
    popl %ebx

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
