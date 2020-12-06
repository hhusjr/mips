.data
input_n_hint: .asciiz "Input n: "
input_number_hint: .asciiz "Input next number: "
output_hint: .asciiz "Result: "

.text
.globl bubble_sort
# begin: a0
# end:   a1
# callee-save registers: s0, s1, s2, s5, s6
bubble_sort:
# Save registers
addiu $sp, $sp, -20
sw $s0, 16($sp)
sw $s1, 12($sp)
sw $s2, 8($sp)
sw $s5, 4($sp)
sw $s6, 0($sp)

addi $s6, $a1, -4
add $s5, $zero, $s6

# Loop variable i stored in $s1
or $s1, $a0, $zero
read:
# Print input hint
ori $v0, $zero, 4
la $a0, input_number_hint
syscall
# Read an integer
ori $v0, $zero, 5
syscall
# save to $s1 position
sw $v0, ($s1)
add $s1, $s1, 4
slt $t1, $s1, $a1
bne $t1, $zero, read # Read

# Do bubble sorting
# For i($s1) from gp to gp + 4 * (n - 2)
or $s1, $a0, $zero
num2:
# For j($s2) from gp to gp + 4 * (b - 2)
or $s2, $a0, $zero
num1:

# Order: number1 number2 (adjacent)
# Get number 1, put to $t1
lw $t1, ($s2)
# Get number 2, put to $t2
lw $t2, 4($s2)
# If $t1 > $t2 swap($t1, $t2)
sgt $t3, $t1, $t2
beq $t3, $zero, exit
sw $t1, 4($s2)
sw $t2, ($s2)
exit:

addi $s2, $s2, 4
slt $t1, $s2, $s5
bne $t1, $zero, num1 # num1
addi $s1, $s1, 4
addi $s5, $s5, -4
slt $t1, $s1, $s6
bne $t1, $zero, num2 # num2

# Restore registers and stack pointer
lw $s0, 16($sp)
lw $s1, 12($sp)
lw $s2, 8($sp)
lw $s5, 4($sp)
lw $s6, 0($sp)
addiu $sp, $sp, 20
