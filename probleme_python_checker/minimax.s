.section .note.GNU-stack,"",@progbits
.data
    n: .space 4
    m: .space 4
    elem: .space 4
    mat: .space 40000

    format_scanf_n_m: .asciz "%d %d"
    format_scanf_elem: .asciz "%d"
    format_endl: .asciz "\n"
    format_print_int: .asciz "%d "
    format_print_yes: .asciz "Yes\n"
    format_print_no: .asciz "No\n"
    format_print_sol: .asciz "maximul dintre minimul elementelor coloanelor este %d\n"
.text
minimax:
//merge pt elemente pozitive
    pushl %ebp
    movl %esp, %ebp

    lea mat, %edi

    movl $0, %ecx

    // in esi tin maximul
    movl $-1, %esi
    //eax este start_index
mini_loop:
    //aleg linia
    cmpl 8(%ebp), %ecx
    jge minimax_ret

    /*pushl %ecx
    pushl $format_print_int
    call printf
    popl %ebx
    popl %ebx*/

    // min = elementul de pe prima linie
    
    movl (%edi, %ecx, 4), %edx
    movl $1, %eax
    //trec prin elementele de pe coloana j
coloana:
    cmpl 12(%ebp), %eax
    jge maxim

    /*pushl %eax
    pushl $format_print_int
    call printf
    popl %ebx
    popl %ebx

    pushl $format_endl
    call printf
    popl %ebx*/

    //in ebx o sa am indexul elementului curent
    /*pushl %eax
    pushl %edx
    movl 12(%ebp), %eax
    xorl %edx, %edx
    mull %ecx
    movl %eax, %ebx
    popl %edx
    popl %eax*/

    pushl %eax
    pushl %edx
    movl 12(%ebp), %ebx
    xorl %edx, %edx
    mull %ebx
    popl %edx
    popl %eax

    addl %ecx, %ebx
    //nu e add
    //addl %eax, %ebx
    //ebx index
    //in edx e minimul
    
    cmpl %edx, (%edi, %ebx, 4)
    jge coloana_inc

    movl (%edi, %ebx, 4), %edx
coloana_inc:
    incl %eax
    jmp coloana

maxim:
    cmpl %esi, %edx
    jle mini_loop_inc

    movl %edx, %esi
mini_loop_inc:
    incl %ecx
    jmp mini_loop

minimax_ret:
    popl %ebp
    ret
.global main
main:
citire:
    pushl $m
    pushl $n
    pushl $format_scanf_n_m
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx

    lea mat, %edi

    movl n, %eax
    xorl %edx, %edx
    movl m, %ebx
    mull %ebx

    movl $0, %ecx
citire_mat:
    cmpl %eax, %ecx
    je program

    pushl %eax
    pushl %ecx
    pushl $elem
    pushl $format_scanf_elem
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx
    popl %eax

    movl elem, %ebx
    movl %ebx, (%edi, %ecx, 4)

    //incl %ecx
    jmp citire_mat
program:

    pushl mat
    pushl m
    pushl n
    call minimax
    popl %ebx
    popl %ebx
    popl %ebx

afisare:

    pushl %esi
    pushl $format_print_sol
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
