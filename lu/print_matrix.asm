# Matrix printer implemented by MIPS Assembly
# By Junru Shen
# Used for simulation in MARS or SPIM only

# Parameters:
# mat: The begin address of the matrix, in column-prior format, each number 4 bytes, stored in register $a0
# r: The row number of the matrix, stored in register $a1
# c: The column number of the matrix, stored in register $a2
.text
.globl print_matrix
print_matrix:
add $t0, $zero, $zero
add $t1, $zero, $zero
loop_row:
loop_col:
# Row: t0, Col: t1, pos: t1 * r + t0
mul $t2, $t1, $a1
add $t2, $t2, $t0
add $t2, $t2, $a0
# Output number
lw $a0, 0($t2)
addi $v0, $zero, 1
syscall
# Output space
addi $v0, $zero, 11
addi $a0, $zero, 32
syscall
bne $t1, $a2, loop_col
# Output line break
addi $v0, $zero, 11
addi $a0, $zero, 10
syscall
bne $t0, $a1, loop_row
jr $ra
