.section .note.GNU-stack,"",@progbits
.data
    //s: .space 101
    s: .space 101
    len: .space 4

    format_scanf: .asciz "%s"
    format_endl: .asciz "\n"
    format_print_char: .asciz "%c"
    format_print_yes: .asciz "Yes\n"
    format_print_no: .asciz "No\n"
    format_print: .asciz "lenght = %d\n"
.text
palindrome:
    pushl %ebp
    movl %esp, %ebp
    
    //lea 16(%ebp), %edi

    movl $0, %ecx

    /*xorl %edx, %edx
    movl 8(%ebp), %eax
    movl $2, %ebx
    divl %ebx*/

    // pushl %eax
    // len/2

    movl 8(%ebp), %eax
    decl %eax
    //pushl %eax
    // len -1

    movl %eax, %ecx
    movl $0, %ebx
    // 2 pointer
par:
    cmpl %ecx, %ebx
    jge is_palindrome

    movb (%edi, %ebx, 1), %dl
    cmpb (%edi, %ecx, 1), %dl
    jne not_palindrome

    incl %ebx
    decl %ecx

    jmp par
not_palindrome:
    //movl $0, %ebx\

    pushl $format_print_no
    call printf
    popl %eax

    jmp palindrome_ret
is_palindrome:
    //movl $1, %ebx

    pushl $format_print_yes
    call printf
    popl %eax

palindrome_ret:
    popl %ebp

    ret
.global main
main:
citire:
    pushl $s
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx

    lea s, %edi
    movl $0, %ecx
    movl $0, %ebx
    //ebx = \0 terminator de sir

    movl $0, %ecx
    movl $0, %ebx
    lea s, %edi
len_loop:
    cmpb (%edi, %ecx, 1), %bl
    je program

    incl %ecx
    jmp len_loop
program:
    movl %ecx, len

    pushl $s
    pushl $0
    pushl len
    call palindrome
    popl %eax
    popl %eax
    popl %eax

et_exit:
    pushl $0
    call fflush
    popl %ebx
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
