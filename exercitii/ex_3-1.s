.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    max: .long 0
    x: .space 4
    formatscanf: .asciz "%d"
    format_print: .asciz "max este %d si nr aparitii este %d\n"
.text
.global main
main:
citire:
    pushl $n
    pushl $formatscanf
    call scanf
    popl %ebx
    popl %ebx
    movl $0, %ecx
    
    movl $1, %ebx
vect_loop:
// ebx e cnt aparitii
    cmpl n, %ecx
    je et_exit

    pushl %ecx
    pushl $x
    pushl $formatscanf
    call scanf
    popl %eax
    popl %eax
    popl %ecx

    movl x, %eax
    cmpl max, %eax
    je flag

    cmpl max, %eax
    jl flag2
    movl %eax, max
    movl $1, %ebx
    incl %ecx
    jmp vect_loop

flag:
    incl %ebx
    incl %ecx
    jmp vect_loop
flag2:
    incl %ecx
    jmp vect_loop
et_exit:
    pushl %ebx
    pushl max
    pushl $format_print
    call printf
    popl %eax
    popl %eax
    popl %eax

    movl $1, %eax
    movl $0, %ebx
    int $0x80
