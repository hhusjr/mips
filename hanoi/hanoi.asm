.data
inform:    .asciiz "Enter number of disks>"
move_disk: .asciiz "Move disk"
from_peg:  .asciiz " from peg"
to_peg:    .asciiz " to peg"
end_st:    .asciiz ".\n"

.text
.globl main
main:
addi $v0, $zero, 4
la $a0, inform
syscall
addi $v0, $zero, 5
syscall

add  $a0, $v0, $zero
addi $a1, $zero, 1
addi $a2, $zero, 2
addi $a3, $zero, 3
jal hanoi

addi $v0, $zero, 10
syscall

# hanoi(int n, int start, int finish, int extra)
hanoi:
addiu $sp, $sp, -24
sw $ra, ($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
add $s0, $a0, $zero
add $s1, $a1, $zero
add $s2, $a2, $zero
add $s3, $a3, $zero

beq $s0, $zero, hanoi_exit

addi $a0, $s0, -1
add $a1, $s1, $zero
add $a2, $s3, $zero
add $a3, $s2, $zero
jal hanoi

addi $v0, $zero, 4
la $a0, move_disk
syscall

addi $v0, $zero, 1
add $a0, $zero, $s0
syscall

addi $v0, $zero, 4
la $a0, from_peg
syscall

addi $v0, $zero, 1
add $a0, $zero, $s1
syscall

addi $v0, $zero, 4
la $a0, to_peg
syscall

addi $v0, $zero, 1
add $a0, $zero, $s2
syscall

addi $v0, $zero, 4
la $a0, end_st
syscall

addi $a0, $s0, -1
add $a1, $s3, $zero
add $a2, $s2, $zero
add $a3, $s1, $zero
jal hanoi

hanoi_exit:
lw $s3, 16($sp)
lw $s2, 12($sp)
lw $s1, 8($sp)
lw $s0, 4($sp)
lw $ra, ($sp)
addiu $sp, $sp, 24
jr $ra
