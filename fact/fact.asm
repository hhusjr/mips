.data
str: .asciiz "The result is "

.text
.globl main
main:
addi $a0, $zero, 6

la $a0, str
addi $v0, $zero, 4
syscall

jal fact

addi $a0, $v0, 0
addi $v0, $zero, 1
syscall

j done

fact:
addiu $sp, $sp, -16
bne $a0, $zero, else
addi $v0, $zero, 1
j exit
else:
sw $a0, -8($sp)
sw $ra, -16($sp)
addi $a0, $a0, -1
jal fact
lw $ra, -16($sp)
lw $a0, -8($sp)
mul $v0, $v0, $a0
exit:
addiu $sp, $sp, 16
jr $ra

done:
