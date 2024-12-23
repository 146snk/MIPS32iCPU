j JUMP
addi $zero, $zero, 0
JUMP: addi $s0, $zero, 22
addi $t1, $zero, 15
add $s1, $s0, $t1
addu $s1, $s0, $t1
sub $t2, $s0, $t1
subu $s1, $s0, $t1
andi $s1, $t1, 0x3c
and $s1, $s0, $t1
or $s1, $s0, $t1
ori $s1, $t1, 0x3c
xor $s1, $s0, $t1
xori $s1, $t1, 0x3c
nor $s1, $s0, $t1
slt $s1, $s0, $t1
slti $s2, $t1, 10
sltu $s1, $s0, $t1
#sltui $s2, $t1, 10
lui $s2, 0xf00f
sll $s3, $s2, 6
srl $s3, $s2, 6
sra $s3, $s2, 6
sllv $s3, $s2, $t3
srlv $s3, $s2, $t3
#srrv $s3, $s2, $t3
sw $s3, 0($zero)
addi $t0,$zero,0xff
sb $t0, 4($zero)
sb $t0, 8($zero)
sh $t0, 10($zero)
lb $s4, 4($zero)
lbu $s5, 4($zero)
lh $s4, 4($zero)
lhu $s5, 4($zero)
lw $s4, 4($zero)

