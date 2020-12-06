.text
.globl main
# Program entry
main:
# Initialize the prime counter $s0
add $s0, $zero, $zero
# Current number
add $s1, $zero, 1
# Loop over each number
number_loop:
add $a0, $s1, $zero
jal test_prime
beq $v0, $zero, after_output
# Increase prime counter
addi $s0, $s0, 1
# Output the prime number
addi $v0, $zero, 1
add $a0, $s1, $zero
syscall
# Output a line break
addi $v0, $zero, 11
addi $a0, $zero, 10
syscall
after_output:
addi $s1, $s1, 1
bne $s0, 100, number_loop
addi $v0, $zero, 10
syscall

# Test if a number is a prime or not
test_prime:
# Check if n == 1 or not
bne $a0, 1, body
add $v0, $zero, $zero
jr $ra
body:
# Allocate stack frame
addiu $sp, $sp, -24
# Save callee-save registers: s0
sw $s0, ($sp)
# for (i = 2; i * i <= n; i = i + 1), n stored in a0, i stored in s0
# Set loop variable s0 to 2
addi $s0, $zero, 2
# Set the is_prime flag to true
addi $v0, $zero, 1
loop:
mul $t0, $s0, $s0
sle $t1, $t0, $a0
beq $t1, $zero, exit
# Check if n % i
div $a0, $s0
mfhi $t0
# if n % i != 0, then continue
bne $t0, 0, no_prime_exit
add $v0, $zero, $zero
j exit
no_prime_exit:
addi $s0, $s0, 1
j loop
exit:
# Pop s0
lw $s0, ($sp)
addiu $sp, $sp, 24
jr $ra
