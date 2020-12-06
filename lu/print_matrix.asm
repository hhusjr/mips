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
# Save params
add $t5, $zero, $a0
add $t6, $zero, $a1
add $t7, $zero, $a2

add $t0, $zero, $zero

loop_row:
add $t1, $zero, $zero
loop_col:
# Row: t0, Col: t1, pos: 4 * (t1 * r + t0)
mul $t2, $t1, $t6
add $t2, $t2, $t0
sll $t2, $t2, 2
add $t2, $t2, $t5
# Output number
lwc1 $f12, 0($t2)
addi $v0, $zero, 2
syscall
# Output space
addi $v0, $zero, 11
addi $a0, $zero, 32
syscall
add $t1, $t1, 1
bne $t1, $t7, loop_col
# Output line break
addi $v0, $zero, 11
addi $a0, $zero, 10
syscall
add $t0, $t0, 1
bne $t0, $t6, loop_row
jr $ra
