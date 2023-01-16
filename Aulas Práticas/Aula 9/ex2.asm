	.data
str1: 	.asciiz "Qual a temperatura em Farrenheit: "
str2: 	.asciiz "\nTemperatura em Celsius: "
	.text
	.globl main
main:				# int main(void) {
	addiu	$sp, $sp, -4	# 	poem espaco na stack
	sw	$ra, 0($sp)	#	guarda o $ra
	
	la	$a0, str1	#	$a0 = str1
	li	$v0, 4		#
	syscall			#	print_string(str1);
				#
	li	$v0, 7		#	
	syscall			#	$f0 = read_double();
	mov.d	$f12, $f0	#	$f12 = $f0
	jal 	f2c		#	f2c(read_double());

	la	$a0, str2	#	$a0 = str2;
	li	$v0, 4		#	
	syscall			#	print_string(str2);
				#
	mov.d	$f12, $f0	#	$f12 = return(f2c);
	li	$v0, 3		#	
	syscall			#	print_double(return);
	lw	$ra, 0($sp)	#	repoem o valor de $ra
	addiu	$sp, $sp, 4	#	repoem o tamnhao da stack
	li	$v0, 0		#	return 0;
	jr	$ra		# } fim do programa

.data
x0:	.double	5.0
x1:	.double	9.0
x2:	.double	32.0
	.text
	.globl f2c

f2c:					# double f2c(double ft) {
	la	$t0, x0			#	$t0 = $x0
	l.d	$f2, 0($t0)		#	$f2 = 5
	
	la	$t0, x1			#	$t0 = $x1
	l.d	$f4, 0($t0)		#	$f4 = 9
	
	la	$t0, x2			#	$t0 = $x2
	l.d	$f6, 0($t0)		#	$f4 = 32
	
	sub.d	$f12, $f12, $f6		#	ft - 32.0
	div.d	$f2, $f2, $f4		#	$f2 = 5.0/9.0
	mul.d	$f0, $f2, $f12		#	return 5.0/9.0 * (ft - 32.0);
	jr	$ra			# } fim do programa
