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
sll $s7, $s0, 2
add $s7, $s7, $gp
addi $s6, $s7, -4

# Loop variable i stored in $s1
or $s1, $gp, $zero
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
slt $t1, $s1, $s7
bne $t1, $zero, read # Read

# Do bubble sorting
# For i($s1) from gp to gp + 4 * (n - 2)
or $s1, $gp, $zero
num2:
# For j($s2) from gp to gp + 4 * (b - 2)
or $s2, $gp, $zero
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

add $s2, $s2, 4
slt $t1, $s2, $s6
bne $t1, $zero, num1 # num1
add $s1, $s1, 4
slt $t1, $s1, $s6
bne $t1, $zero, num2 # num2

# Write
or $s1, $gp, $zero
write:
# save to 4*i($gp)
ori $v0, $zero, 1
lw $a0, ($s1)
syscall
ori $v0, $zero, 11
ori $a0, $zero, 32
syscall
add $s1, $s1, 4
slt $t1, $s1, $s7
bne $t1, $zero, write # Write

# Write a line break
ori $v0, $zero, 11
ori $a0, $zero, 10
syscall
