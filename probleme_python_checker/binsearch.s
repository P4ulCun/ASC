.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    x: .space 4
    len: .space 4
    elem: .space 4
    vect: .space 4000

    format_scanf_n_x: .asciz "%d %d"
    format_scanf_elem: .asciz "%d"
    format_print: .asciz "valoarea cautata e pe pozitia: %d\n"
    format_print_vect: .asciz "%d "
.text
binsearch:
    pushl %ebp
    movl %esp, %ebp

    // index = -1, un ok
    movl $-1, %esi

    //while loop
    movl 12(%ebp), %ecx
    movl 8(%ebp), %edx
binsearch_loop:
    //while st <= dr
    cmpl %edx, %ecx
    jg binsearch_ret

    
    // calculez mid in eax
    movl %edx, %eax
    addl %ecx, %eax

    pushl %ecx
    pushl %edx

    movl $2, %ebx
    xorl %edx, %edx
    divl %ebx
    //
    popl %edx
    popl %ecx

    //compar x (%ebx) cu v[mid] (v[eax])
    movl 16(%ebp), %ebx

    //search left
    cmpl %ebx, (%edi, %eax, 4)
    jle else1

    decl %eax
    movl %eax, %edx

    jmp binsearch_loop
    //search right
else1:
    cmpl %ebx, (%edi, %eax, 4)
    jge else2

    incl %eax
    movl %eax, %ecx

    jmp binsearch_loop
    //search mid
else2:
    cmpl %ebx, (%edi, %eax, 4)
    jne binsearch_loop

    movl %eax, %esi
    // update index and move right
    incl %eax
    movl %eax, %ecx

    jmp binsearch_loop

binsearch_ret:
    popl %ebp
    //in esi e indexul
    ret
.global main
main:
citire:
    pushl $n
    pushl $format_scanf_elem
    call scanf
    popl %ebx
    popl %ebx

    pushl $x
    pushl $format_scanf_elem
    call scanf
    popl %ebx
    popl %ebx

    lea vect, %edi
    movl $0, %ecx
citire_vect:
    cmpl n, %ecx
    je program

    pushl %ecx
    pushl $elem
    pushl $format_scanf_elem
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx

    movl elem, %eax
    movl %eax, (%edi, %ecx, 4)

    incl %ecx
    jmp citire_vect
    
program:
    movl %ecx, len
    decl %ecx

    pushl vect
    pushl x
    pushl $0
    pushl %ecx
    call binsearch
    popl %ebx
    popl %ebx
    popl %ebx 
    popl %ebx

afisare:
    pushl %esi
    pushl $format_print
    call printf
    popl %ebx
    popl %ebx
et_exit:
    pushl $0
    call fflush
    popl %ebx
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
