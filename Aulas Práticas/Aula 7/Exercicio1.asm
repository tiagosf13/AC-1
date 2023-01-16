# Mapa de registos
# $t0 - len
# $t1 - &s[0]
# $t2 - &t[i]

	.data
str : 	.asciiz "ITED - orievA ed edadisrevinU\n"
	.eqv print_int10, 1
	.eqv print_string, 4
	.text
	.globl main
	
main	:	addiu $sp, $sp, -4	# prologo
		sw $ra, 0($sp)
		
		la $a0, str
		jal	strlen		# strlen(str)
		
		or $a0, $0, $v0
		li $v0, print_int10
		syscall			# print_int10(str)
		
		la $a0, str
		jal	strrev
		or $a0, $0, $v0
		li $v0, print_string
		syscall			# print_str(strrev(str))
		
		li $v0, 0
				
		lw $ra, 0($sp)
		addiu $sp, $sp, 4	# epilogo
		jr	$ra


# sub terminal
# dst : $a0
# src : $a1
# i : $t0
strcpy	:	li $t0, 0		# i = 0;
do	:	add $t1, $a0, $t0, 	# $t1 = &src[i]				
		add $t2, $a1, $t0	# $t2 = &dst[i]
		
		lb $t3, 0($t1)		# $t3 = src[i]
		sb $t3, 0($t2)		# dst[i] = $t3
		addi $t0, $t0, 1	# i++;
		bne $t3, '\0', do
		or $v0, $0, $a0	
		jr	$ra		# return dst		

# sub intermedia
# str : $a0 -> $s0
# p1 : $s1
# p2 : 	$s2	
strrev	:	addiu $sp, $sp, -16	# prologo
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		
		or $s0, $0, $a0
		or $s1, $0, $a0		# p1 = str;
		or $s2, $0, $a0		# p2 = str;
		
while1	:	lb $t0, 0($s2)		# while(*p2 = '\0') {
		beq $t0, '\0', endw1
		addiu $s2, $s2, 1	# p2++;
		j	while1		# }

endw1	:	addiu $s2, $s2, -1	# p2--;

while2	:	bgeu $s1, $s2, endw2	# while(p1 < p2){
		or $a0, $0, $s1
		or $a1, $0, $s2
		jal	exchange	# exchange(p1, p2);
		addiu $s1, $s1, 1	# p1++;
		addiu $s2, $s2, -1	# p2--;
		j	while2		# }

endw2	:	or $v0, $0, $s0		# return str;
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		
		addiu $sp, $sp, 16
		
		jr	$ra
		
# sub terminal
# c1 : $a0
# c2 : $a1
exchange:	lb $t0, 0($a0)
		lb $t1, 0($a1)
		
		sb $t0, 0($a1)
		sb $t1, 0($a0)
		
		jr	$ra
		

# sub terminal
# s : $a0
# len : $t0
strlen	:	li $t0, 0		# len = 0;
		
while	:	lb $t1, 0($a0)		# while(*s++ != '/0'){
		addiu $a0, $a0, 1	
		beq $t1, '\0', endw	
		addi $t0, $t0, 1	# len++;

		j	while		# }
	
	
endw:		or $v0, $0, $t0		
		jr	$ra		# return (len);