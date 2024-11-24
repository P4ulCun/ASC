.section .note.GNU-stack,"",@progbits
.data
    a: .space 4
    b: .space 4
    c: .space 4
    min: .space 4
    formatscanf: .asciz "%d %d %d"
    formatprintf: .asciz "min = %d\n"
.text
.global main
main:
citire:
    pushl $c
    pushl $b
    pushl $a
    pushl $formatscanf
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

problema:
    movl a, %eax
    cmpl b, %eax
    jg flag
    movl %eax, min
    jmp cmp_min_c
flag:
    movl b, %eax
    movl %eax, min

cmp_min_c:
    movl c, %eax
    cmpl min, %eax
    jg flag1
    movl %eax, min
flag1:

afisare:
    pushl min
    pushl $formatprintf
    call printf
    popl %ebx
    popl %ebx

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
