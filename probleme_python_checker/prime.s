.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    format_scanf: .asciz "%d"
    format_is_prime: .asciz "numarul %d este prim!\n"
    format_not_prime: .asciz "numarul %d nu este prim!\n"
.text
prime:
    pushl %ebp
    movl %esp, %ebp

    //place holder 7
    movl $7, %eax
    pushl %eax
    movl 8(%ebp), %eax
    cmpl $1, %eax
    jle prime_not
    popl %eax

    movl 8(%ebp), %eax
    movl $2, %ebx
    divl %ebx

    pushl %eax
    // n/2 e -4(%ebp)
    movl $2, %ecx

prime_loop:
    cmpl -4(%ebp),%ecx
    jg prime_is

    xorl %edx, %edx
    movl 8(%ebp), %eax
    divl %ecx

    cmpl $0, %edx
    je prime_not

    incl %ecx
    jmp prime_loop
prime_is:
    popl %eax
    movl $1, %eax
    jmp prime_ret
prime_not:
    popl %eax
    movl $0, %eax
prime_ret:
    popl %ebp

    ret
.global main
main:
citire:
    pushl $n
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx

    pushl n
    call prime
    popl %ebx
    // in eax se stocheaza 0 daca nu e prim si 1 daca e prim
    
    cmpl $1, %eax
    je is_prime

    movl $format_not_prime, %ebx
    jmp afisare
is_prime:
    movl $format_is_prime, %ebx
afisare:
    pushl n
    pushl %ebx
    call printf
    popl %ebx
    popl %ebx
et_exit:
    pushl $0
    call fflush
    popl %eax
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
