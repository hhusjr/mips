# LU Decomposition implemented by MIPS Assembly
# By Junru Shen

# Parameters:
# mat: The begin address of the matrix, in column-prior format, each number 4 bytes, stored in register $a0
# r: The row number of the matrix, stored in register $a1
# c: The column number of the matrix, stored in register $a2
# The LU Decomposition will make in-place change to the matrix!
# If LU Decomposition OK, return 1, otherwise return 0
.text
.globl lu_decomposition
lu_decomposition:
# Reserve stack space and preserve registers
addiu $sp, $sp, -40
sw $fp, 36($sp)
addi $fp, $sp, 36
sw $s0, -4($fp)
sw $s1, -8($fp)
sw $s2, -12($fp)
sw $s3, -16($fp)
sw $s4, -20($fp)
sw $s5, -24($fp)
sw $s6, -28($fp)

# Some temporary values
sll $t0, $a1, 2
addi $t1, $t0, 4

# Initialize right_end and bottom_end
mul $s2, $t0, $a2
add $s2, $s2, $a0
add $s3, $a0, $t0

# Main loop, enumerating the stage of decomposition
add $s0, $zero, $zero
add $t3, $zero, $zero
add $s1, $zero, $a0

slt $t7, $s0, $a1
beq $t7, $zero, main_loop_Ex
main_loop:

# Store 4 * cur in $t2
sll $t2, $s0, 2
# Store 4r * cur in $t3
add $t3, $t3, $t0

# Calculating elements in U matrix
add $s4, $zero, $s1

beq $s4, $s2, u_loop_Ex
u_loop:
 
lwc1 $f0, 0($s4)

# Sub dot product result from f0 loop
add $s5, $t2, $a0
sub $s6, $s4, $t2

beq $s6, $s1, u_sub_dot_Ex
u_sub_dot:

lwc1 $f1, 0($s5)
lwc1 $f2, 0($s6)
mul.s $f3, $f1, $f2
sub.s $f0, $f0, $f3

add $s5, $s5, $t0
addi $s6, $s6, 4

bne $s6, $s1, u_sub_dot
u_sub_dot_Ex:
# End Sub dot product result from f0 loop

# Save U element
swc1 $f0, 0($s4)

add $s4, $s4, $t0

bne $s4, $s2, u_loop
u_loop_Ex:
# End U loop

lwc1 $f4, 0($s1)

# L loop
add $s4, $zero, $s1

beq $s4, $s3, l_loop_Ex
l_loop:

lwc1 $f0, 0($s4)

# Sub dot product result from f0 loop
sub $s5, $s4, $t3
add $s6, $t3, $a0

beq $s5, $s1, l_sub_dot_Ex
l_sub_dot:

lwc1 $f1, 0($s5)
lwc1 $f2, 0($s6)
mul.s $f3, $f1, $f2
sub.s $f0, $f0, $f3

add $s5, $s5, $t0
addi $s6, $s6, 4

bne $s5, $s1, l_sub_dot
l_sub_dot_Ex:
# End Sub dot product result from f0 loop

# / mat[diag, diag]
div.s $f0, $f0, $f4

# Save L element
swc1 $f0, 0($s4)

addi $s4, $s4, 4

bne $s4, $s3, l_loop
l_loop_Ex:
# End L loop

add $s1, $s1, $t1
addi $s0, $s0, 1

slt $t7, $s0, $a1
bne $t7, $zero, main_loop

main_loop_Ex:
# End Main loop

# Restore registers
lw $s0, -4($fp)
lw $s1, -8($fp)
lw $s2, -12($fp)
lw $s3, -16($fp)
lw $s4, -20($fp)
lw $s5, -24($fp)
lw $s6, -28($fp)
lw $fp, 36($sp)
addiu $sp, $sp, 40

# Return
jr $ra
