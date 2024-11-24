.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    half_n: .space 4
    formatscanf: .asciz "%d"
    prime_print: .asciz "numarul %d este prim!\n"
    not_prime_print: .asciz "numarul %d nu este prim :(\n"
.text
.global main
main:
citire:
    pushl $n
    pushl $formatscanf
    call scanf
    popl %ebx
    popl %ebx

setup:
    movl $2, %ecx
    movl n, %eax
    xorl %edx, %edx
    divl %ecx
    movl %eax, half_n
prime_loop:
    cmpl half_n, %ecx
    jg for_end

    xorl %edx, %edx
    movl n, %eax
    divl %ecx

    cmpl $0, %edx
    je not_prime

    addl $1, %ecx
    jmp prime_loop
for_end:
    movl $prime_print, %eax
    jmp afisare
not_prime:
    movl $not_prime_print, %eax
afisare:
    pushl n
    pushl %eax
    call printf
    popl %ebx
    popl %ebx

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
