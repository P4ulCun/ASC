.section .note.GNU-stack,"",@progbits
.data
    player_choice: .space 4
    print_map: .asciz "   | 1 | 2 | 3 |\n----------------\n 1 | %c | %c | %c |\n----------------\n 2 | %c | %c | %c |\n----------------\n 3 | %c | %c | %c |\n----------------\n\n"
    game_mat: .asciz "---------"
    bara: .byte '-'
    print_msj_start: .asciz "Hai sa jucam X si O!\n\n"
    print_player_select: .asciz "Ca ce jucator vrei sa joci?\nCu X sau cu O: "
    scan_player_select: .asciz "%c"
    print_endl: .asciz "\n"
    x: .ascii "X"
    o: .ascii "O"
    i: .space 4
    j: .space 4
    print_index_select: .asciz "Introdu linia si coloana casutei unde vrei sa pui %c: "
    scan_index_select: .asciz "%d %d"
    print_index_test: .asciz "index = %d"
    print_try_again: .asciz "Introdu o pereche corecta de indecsi!\n"
    print_try_other_space: .asciz "Aceasta casuta e ocupata! Incearca alta!\n"
    print_winner: .asciz "Castigatorul meciului este: %c!\n"
    print_stale_mate: .asciz "Meciul s-a incheiat intr-o egalitate!\n"
    print_checker_test: .asciz "%c\n"
    print_string: .asciz "%s\n"
.text
map_afisare:
    lea game_mat, %edi

    movl $8, %eax
    pushl (%edi, %eax, 1)
    movl $7, %eax
    pushl (%edi, %eax, 1)
    movl $6, %eax
    pushl (%edi, %eax, 1)
    movl $5, %eax
    pushl (%edi, %eax, 1)
    movl $4, %eax
    pushl (%edi, %eax, 1)
    movl $3, %eax
    pushl (%edi, %eax, 1)
    movl $2, %eax
    pushl (%edi, %eax, 1)
    movl $1, %eax
    pushl (%edi, %eax, 1)
    movl $0, %eax
    pushl (%edi, %eax, 1)
    pushl $print_map
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    ret

is_index_valid:
    movl i, %ebx
    cmpl $0, %ebx
    jle not_valid

    cmpl $4, %ebx
    jge not_valid

    movl j, %ebx
    cmpl $0, %ebx
    jle not_valid

    cmpl $4, %ebx
    jge not_valid

    movl $1, %eax
    
    ret
not_valid:
    movl $0, %eax

    ret

is_space_empty:
    lea game_mat, %edi
    // calculez indexul unde se afla spatiul de la i j in game_mat
    movl i, %eax
    decl %eax
    //in eax se afla acum indexul corect i
    xorl %edx, %ecx
    movl $3, %ebx
    mull %ebx

    movl j, %ecx
    decl %ecx

    addl %ecx, %eax
    //in eax am indexul spatiului cautat

    /*pushl %eax
    pushl $print_index_test
    call printf
    popl %ebx
    popl %eax*/
    
    movb bara, %bl
    cmpb (%edi, %eax), %bl
    je empty_space

    movl $0, %esi

    ret
empty_space:
    movl $1, %esi

    ret

check_winner_lines:
    //check lines for winner
    movl $0, %ecx
loop_lines:
    cmpl $3, %ecx
    je lines_loop_done

    //am primul element pe fiecare linie in mat[ eax ]
    movl $3, %eax
    xorl %edx, %edx
    mull %ecx

    movl $1, %ebx
line_loop:
    cmpl $3, %ebx
    je check_line_potential_win

    movb (%edi, %eax, 1), %dl
    incl %eax
    cmpb %dl, (%edi, %eax, 1)
    jne check_next_line

    incl %ebx

    jmp line_loop

check_next_line:
    incl %ecx

    jmp loop_lines
check_line_potential_win:
    movl $3, %eax
    xorl %edx, %edx
    mull %ecx

    movb bara, %bl
    cmpb %bl, (%edi, %eax, 1)
    je check_next_line

    movb (%edi, %eax, 1), %al
    // a castigat mat[line][0]

    ret
lines_loop_done:
    movb $97, %al

    ret

check_winner_columns:
    //check colums for winner
    movl $0, %ecx
    //loop through columns
loop_columns:
    cmpl $3, %ecx
    je columns_loop_done

    //am primul element pe fiecare coloana in mat[ ecx ]

    movl $1, %ebx
    //loop through a column
column_loop:
    cmpl $3, %ebx
    je check_column_win

    movb (%edi, %ecx, 1), %dl
    
    pushl %edx
    movl $3, %eax
    xorl %edx, %edx
    mull %ebx
    popl %edx

    addl %ecx, %eax
//posibil un add pe aici
    cmpb %dl, (%edi, %eax, 1)
    jne check_next_column

    incl %ebx

    jmp column_loop

check_next_column:
    incl %ecx

    jmp loop_columns
check_column_win:
    movb bara, %bl
    cmpb %bl, (%edi, %ecx, 1)
    je check_next_column

    movb (%edi, %ecx, 1), %al
    // a castigat mat[0][column]

    ret
columns_loop_done:
    movl $0, %eax
    movb $98, %al

    ret

check_winner_diag_princ:
    movl $0, %ecx

    movl $3, %eax
    xorl %edx, %edx
    mull %ecx
    addl %ecx, %eax
    // formula pentru elementele de pe diagonala principala

    movl $1, %ecx
loop_diag_princ:
    cmpl $3, %ecx
    je diag_princ_loop_done

    movb (%edi, %eax, 1), %dl

    pushl %edx
    movl $3, %eax
    xorl %edx, %edx
    mull %ecx
    popl %edx
    addl %ecx, %eax

    cmpb (%edi, %eax, 1), %dl
    jne diag_principala_not

    incl %ecx

    jmp loop_diag_princ
diag_princ_loop_done:
    movl $0, %eax
    movb bara, %bl
    cmpb %bl, (%edi, %eax, 1)
    je diag_principala_not
    
    movb (%edi, %eax, 1), %al

    ret

diag_principala_not:
    movb $99, %al

    ret

check_winner_diag_secund:
    movl $0, %ecx
    movl $2, %ebx
    //two pointer la coordonatele elementelor de pe diagonala secundara
    movl $3, %eax
    xorl %edx, %edx
    mull %ecx
    addl %ecx, %eax
    // formula pentru elementele din matrice

    movl $1, %ecx
    movl $1, %ebx
    //fac two pointer
loop_diag_sec:
    cmpl $3, %ecx
    je diag_sec_loop_done

    movb (%edi, %eax, 1), %dl

    pushl %edx
    movl $3, %eax
    xorl %edx, %edx
    mull %ecx
    popl %edx
    addl %ebx, %eax

    cmpb (%edi, %eax, 1), %dl
    jne diag_secund_not

    incl %ecx
    decl %ebx

    jmp loop_diag_sec
diag_sec_loop_done:
    movl $2, %eax
    movb bara, %bl
    cmpb %bl, (%edi, %eax, 1)
    je diag_secund_not
    
    movb (%edi, %eax, 1), %al

    ret

diag_secund_not:
    movb $100, %al

    ret

.global main
main:

    pushl $print_msj_start
    call printf
    popl %ebx

    call map_afisare

    /* pushl $print_player_select
    call printf
    popl %ebx */

    /* pushl $player_choice
    pushl $scan_player_select
    call scanf
    popl %ebx
    popl %ebx */

    //si acum verific player choice daca e x sau o sau X sau O sau 0
/*  movl $player_choice, %eax
    cmpl $x, %eax
    je x_choice

    movl $x, %ebx
    subl $32, %ebx
    cmpl %ebx, %eax
    je x_choice

    cmpl $o, %eax
    je o_choice

    movl $o, %ebx
    subl $32, %ebx
    cmpl %ebx, %eax
    je o_choice

    cmpl $0, %eax
    je o_choice

x_choice:
    movl $1, %edx
    jmp program
    //edx e un flag
o_choice:
    movl $0, %edx */
    
    //movl x, %edx
    //edx e flag

program:
    movl $0, %ecx
game_loop:
    cmpl $9, %ecx
    jge game_loop_stale_mate

    movl %ecx, %eax
    movl $2, %ebx
    xorl %edx, %edx
    divl %ebx
    // aflu paritatea indexului ecx
    cmpl $1, %edx
    je o_turn
    // x_turn
    movb x, %dl
    jmp scan_index
o_turn:
    movb o, %dl
scan_index:
    pushl %ecx
    pushl %edx
    pushl $print_index_select
    call printf
    popl %ebx
    popl %edx
    popl %ecx

    pushl %edx
    pushl %ecx
    pushl $0
    call fflush
    popl %ebx
    popl %ecx
    popl %edx

    pushl %edx
    pushl %ecx
    pushl $j
    pushl $i
    pushl $scan_index_select
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ecx
    popl %edx

    //verific daca indexul introdus este valid
    call is_index_valid
    //in eax sa primesc false sau true
    cmpl $1, %eax
    je valid_index

    pushl %edx
    pushl %ecx
    pushl $print_try_again
    call printf
    popl %ebx
    popl %ecx
    popl %edx

    jmp scan_index
valid_index:

    pushl %ecx
    pushl %edx
    call is_space_empty
    popl %edx
    popl %ecx
//returneaza in esi 1 daca e gol spatiul, deci valid, si 0 in caz contrar
//de asemenea returneaza in eax indexul saptiului de coordonate i si j din matrice

    cmpl $1, %esi
    je valid_space

    pushl %ecx
    pushl %edx
    pushl $print_try_other_space
    call printf
    popl %ebx
    popl %edx
    popl %ecx

    jmp scan_index
valid_space:
    movb %dl, (%edi, %eax, 1)
    
    //schimb in matrice inputul
    pushl %ecx
    pushl %edx
    pushl $print_endl
    call printf
    popl %ebx
    popl %edx
    popl %ecx

    pushl %ecx
    call map_afisare
    popl %ecx

check_winners:
    pushl %ecx
    call check_winner_lines
    popl %ecx
    //imi da return la rezultat in %al
    //cmpb x, %al
    //je game_loop_done_win
    cmpb $97, %al
    jne game_loop_done_win
    
    pushl %ecx
    call check_winner_columns
    popl %ecx

    //imi da return la rezultat in %al
    cmpb $98, %al
    jne game_loop_done_win
    
    pushl %ecx
    call check_winner_diag_princ
    popl %ecx
    //imi da return la rezultat in %al
    cmpb $99, %al
    jne game_loop_done_win

    pushl %ecx
    call check_winner_diag_secund
    popl %ecx
    //imi da return la rezultat in %al
    cmpb $100, %al
    jne game_loop_done_win

game_loop_continue:
    incl %ecx
    jmp game_loop

game_loop_done_win:
    pushl %eax
    pushl $print_winner
    call printf
    popl %ebx
    popl %eax

    jmp et_exit
game_loop_stale_mate:
    pushl $print_stale_mate
    call printf
    popl %ebx
et_exit:
    pushl $0
    call fflush
    popl %eax
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
