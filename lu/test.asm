.data
test_matrix_file: .asciiz "/Users/zeroisone/Desktop/testmat.bin"
hint: .asciiz "Test matrix\n"

.text
.globl main
main:
# Load test matrix from file
addi $v0, $zero, 13
la $a0, test_matrix_file
addi $a1, $zero, 0 # read only
syscall
addi $v0, $zero, 14
add $a0, $v0, $zero
add $a1, $zero, $gp
add $a2, $zero, 2048
syscall

# Print test matrix
addi $v0, $zero, 4
la $a0, hint
syscall
addi $a0, $gp, 8
lw $a1, 0($gp) # 0-3
lw $a2, 4($gp) # 4-8
jal print_matrix

# Exit program
addi $v0, $zero, 10
syscall
