.data
input_n_hint: .asciiz "Input n: "
input_number_hint: .asciiz "Input next number: "
output_hint: .asciiz "Result: "

.text
.globl main
main:
# Print input hint
ori $v0, $zero, 4 # Set the system call to 4 (print string)
la $a0, input_n_hint
syscall

# Read an integer and store it
ori $v0, $zero, 5
syscall
or $s0, $v0, $zero

# Loop variable i stored in $s1
read:
# Print input hint
or $v0, $zero, 4
la $a0, input_number_hint
syscall
# Read an integer
ori $v0, $zero, 5
syscall
# save to 4*i($gp)
sll $t0, $s1, 2
add $t0, $t0, $gp
sw $v0, ($t0)
add $s1, $s1, 1
slt $t1, $s1, $s0
ori $t2, $zero, 1
beq $t1, $t2, read # Read

# Do bubble sorting
# n - 1
addi $t7, $s0, -1

# For i($s1) from 0 to n - 2
or $s1, $zero, $zero
num2:
# For j($s2) from 0 to n - 2
or $s2, $zero, $zero
num1:

# Order: number1 number2 (adjacent)
# Get number 1, put to $t1
sll $t0, $s2, 2
add $t0, $t0, $gp
lw $t1, ($t0)
# Get number 2, put to $t2
lw $t2, 4($t0)
# If $t1 > $t2 swap($t1, $t2)
sgt $t3, $t1, $t2
beq $t3, $zero, exit
sw $t1, 4($t0)
sw $t2, ($t0)
exit:

add $s2, $s2, 1
slt $t1, $s2, $t7
bne $t1, $zero, num1 # num1
add $s1, $s1, 1
slt $t1, $s1, $t7
bne $t1, $zero, num2 # num2

# Write
or $s1, $zero, $zero
write:
# save to 4*i($gp)
ori $v0, $zero, 1
sll $t0, $s1, 2
add $t0, $t0, $gp
lw $a0, ($t0)
syscall
ori $v0, $zero, 11
ori $a0, $zero, 32
syscall
add $s1, $s1, 1
slt $t1, $s1, $s0
bne $t1, $zero, write # Write

# Write a line break
ori $v0, $zero, 11
ori $a0, $zero, 10
syscall
