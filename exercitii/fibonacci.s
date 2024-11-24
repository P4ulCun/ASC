.section .note.GNU-stack,"",@progbits
.data
n: .long 10
f1: .long 0
f2: .long 1
sir: .space 2
.text
.global main
main:

    movl $0, %eax
    movl $1, %ecx
    
et_loop:
    cmp n, %ecx
    jge et_exit
    
    movl $0, %eax
    add $1, %ecx
    add f1, %eax
    add f2, %eax
    
    movl f2, %ebx
    movl %ebx, f1
    movl %eax, f2

    jmp et_loop
et_exit:
    //in f2 sau eax e rezultatul, al n-lea termen al sirului lui fibonnaci
    movl $0, %edx
    movl $10, %ebx
    divl %ebx
    add $48, %edx
    movl %edx, sir

    movl %eax,f2
    movl $sir,%eax
    movl $128, %ecx
    mul %ecx
    movl %eax,sir
    movl f2,%eax

    divl %ebx
    add $48, %edx
    add %edx, sir

    movl $4, %eax
    movl $1, %ebx
    movl $sir, %ecx
    movl $2, %edx
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80
