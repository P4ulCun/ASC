.section .note.GNU-stack,"",@progbits
.data
.text
.global main
main:

et_exit:
    pushl $0
    call fflush
    popl %eax
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
