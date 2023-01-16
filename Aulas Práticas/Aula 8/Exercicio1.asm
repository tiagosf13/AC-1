# Mapa de Registos
# $t0 = digit
# $t2 = *s
# $t3 = val
# $v0 = res, v

	.data
str1 :	.asciiz "5"
str :	.space 33
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv read_int, 5
	.text
	.globl main
	

main	:	addiu $sp, $sp, -4	# prologo
		sw $ra, 0($sp)
		
		la $a0, str
		jal	atoi
		
		or $a0, $0, $v0
		li $v0, print_int10	#  print_int10( atoi(str) ); 
		syscall
		
do2	:	li $v0, read_int
		syscall
		or $t3, $0, $v0		# val = read_int();
		
		or $a0, $0, $t3
		ori $a1, $0, 2
		la $a2, str
		jal	itoa
		
		or $a0, $0, $v0
		li $v0, print_string
		syscall

while2	:	bne $t3, 0, do2	# } while(val != 0)
		

 		li $v0, 0		# return 0;

		lw $ra, 0($sp)		# epilogo
		addiu $sp, $sp, 4

		lw $ra, 0($sp)		# epilogo
		addiu $sp, $sp, 4
		
		
		
		jr	$ra
		
	
atoi	:	li $t0, 0		# digit = 0;
		li $v0, 0		# res = 0;
		
while	:	lb $t2, 0($a0)		# while( (*s >= '0') && (*s <= '9') )
		blt $t2, '0', endw	# {
		bgt $t2, '9', endw
		addiu $a0, $a0, 1	
		
		sub $t0, $t2, '0'	# digit = *s++ - '0';
		
		mul $v0, $v0, 2	# res = res * 10 + digit
		add $v0, $v0, $t0	
		
		
		j	while		# }


endw	:	jr	$ra		# return(res)


toascii	:	addiu $v0, $a0, '0'	# v += '0';
if	:	ble $v0, '9', endif	# if (v > '9'){
		addiu $v0, $v0, 7	# v += 7;
					# }
endif	:	jr	$ra		# return v;


itoa	:	addiu $sp, $sp, -20
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		
		or $s0, $0, $a0		# n
		or $s1, $0, $a1		# b
		or $s2, $0, $a2		# *s
		or $s3, $0, $a2		# *p = s;
		
do	:	rem $t0, $s0, $s1	# do{
		div $s0, $s0, $s1
		
		or $a0, $0, $t0
		
		jal	toascii
		sb $v0, 0($s3)		# *p++ = toascii(digit);
		addiu $s3, $s3, 1
	
while	:	bgt $s0, 0, do		# }while ( n > 0);
		
		sb '\0', 0($s3)		# *p = '\0';
		or $a0, $0, $s2
		jal	strrev		# strrev(s);
		
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		
		addiu $sp, $sp, 20
		
		jr	$ra
		
		
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
		