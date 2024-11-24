.section .note.GNU-stack,"",@progbits
.data
    s: space 12
.text
.global main
main:
    
et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
