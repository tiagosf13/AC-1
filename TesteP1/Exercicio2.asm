# Mapa de registos
# i : $t0
# v : $t1
# &(val[0]) : $t2 
# registo temporário : $t3
# SIZE : $t4
# SIZE/2 : $t5
# resgisto temporário : $t6

		.data
val	: 	.word 8, 4, 15, -1987, 327, -9, 27, 16
		.align 2
str1	:	.asciiz "Result is: "
		.text
		.globl main
		.eqv SIZE, 8
		.eqv print_string, 4
		.eqv print_char, 11
		.eqv print_int10, 1
	

main	:					#
		li $t0, 1			# i = 0;
		li $t4, SIZE			#					$t4 = SIZE
		div $t5, $t4, 2			#					$t5 = SIZE/2
		
do	:					# do{
		la $t2, val			#
						#
		sll $t1, $t0, 2			# 					$t3 = i * 4
		addu $t4, $t2, $t1		# 					$t3 = &val[i]
		lw $t1, 0($t4)			# 	v = val[i];
						#
		add $t3, $t0, $t5		#					$t6 = i+SIZE/2
		sll $t3, $t3, 2			#					$t6 = &val[i+SIZE/2]
		addu $t3, $t2, $t3		#
		lw $t6, 0($t3)			#					$t5 = val[i+SIZE/2]
		sw $t4, 0($t6)			# 	val[i] = val[i+SIZE/2];
						#
		sw $t6, 0($t1)			#	val[i+SIZE/2] = v;
	

while	:					# 
		addi $t0, $t0, 1		#
		blt $t0, $t5, do		# } while(++i < (SIZE/2));
		
		
endo	:					#
		la $a0, str1			#
		li $v0, print_string		#
		syscall				# print_string("Result is: ");
						#
		li $t0, 0			# i = 0;
		
		
do2	:					#
		sll $t6, $t0, 2			#					$t0 = $t0 * 4
		addu $t6, $t2, $t6		#
		lw $t6, 0($t6)			#
		or $a0, $0, $t6			#
		li $v0, print_int10		#
		syscall				# 
		addi $t0, $t0, 1		# print_int10(val[i++]);
						#
		li $a0, ','			#
		li $v0, print_char		#
		syscall				# print_char(',');
	
	
while2	:					#
		blt $t0, SIZE, do2		# } while(i < SIZE);
		jr	$ra