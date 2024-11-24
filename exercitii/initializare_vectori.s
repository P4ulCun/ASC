.section .note.GNU-stack,"",@progbits
.data
    v: .space 800
    n: .space 4
    x: .space 4
    formatscanf: .asciz "%d"
    formatprint: .asciz "%d "
    print_flush: .asciz "\n"
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
    lea v, %edi

citire_vect:
    cmpl n, %ecx
    je gata_citire

    //citesc fiecare element
    pushl %ecx
    pushl $x
    pushl $formatscanf
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx

    movl x, %eax
    movl %eax, (%edi, %ecx, 4)
    incl %ecx
    jmp citire_vect

gata_citire:
    movl $0, %ecx
afisare_vector:
    cmpl n, %ecx
    jge et_exit

    pushl %ecx
    pushl (%edi, %ecx, 4)
    pushl $formatprint
    call printf
    popl %ebx
    popl %ebx
    popl %ecx

    incl %ecx
    jmp afisare_vector
et_exit:
    pushl $print_flush
    call printf
    popl %ebx

    movl $1, %eax
    movl $0, %ebx
    int $0x80
