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
    movl $0, %eax
mini_loop:
    //trec prin linii si verific coloanele de la start_idx la end_idx
    cmpl 8(%ebp), %ecx
    je minimax_ret

    //ebx este end_index
    movl %eax, %ebx
    addl 12(%ebp), %ebx

    //in edx e minimul
    movl (%edi, %eax, 4), %edx
    incl %eax

//while start < end
mini_loop_while:
    cmpl %ebx, %eax
    jge max_loop

    cmpl %edx, (%edi, %eax, 4)
    jge mini_loop_while_inc

    movl (%edi, %eax, 4), %edx
mini_loop_while_inc:
    incl %eax
    jmp mini_loop_while

max_loop:
    cmpl %esi, %edx
    jle mini_loop_incremet

    movl %edx, %esi
mini_loop_incremet:
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

    incl %ecx
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
