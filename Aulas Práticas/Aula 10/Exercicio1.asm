# Mapa de Registos


	.data
k1:	.float 1.0
array:	.double 2.1,3.2,2.7, 4.3, 2.7
	.text
	.globl main
	
	
main	:	addiu $sp, $sp, -4
		sw $ra, 0($sp)
		
		la $a0, array
		li $a1, 5
		jal	var
		
		mov.d $f12, $f0
		li $v0, 3
		syscall
		
		lw $ra, 0($sp)
		addiu $sp, $sp, 4
		jr	$ra


# sub intermedia
# x : $f20
# y : $a0
# i : $t0
# result : $f0
xtoy	:	addiu $sp, $sp, -12	# prologo
		s.s $f20, 0($sp)	# 			x
		sw $s0, 4($sp)		#			y
		sw $ra, 8($sp)
		
		mov.s $f20, $f12	#			para chamarmos o abs antes do for
		move $s0, $a0
		
		jal abss
		move $t1, $v0		# aux = abs(y)
		
		li $t0, 0 		# i = 0;
		la $t2, k1
		l.s $f0, 0($t2)		# result = 1.0

xfor	:	bge $t0, $t1, xendfor	# while(i > abs(y)){
if1	:	ble $s0, 0, else1	# if(y > 0)
		mul.s $f0, $f0, $f12	# result *= x;
		j	 endif1
		
else1	:	div.s $f0, $f0, $f12	# else
					# result /= x;
endif1	:	addi $t0, $t0, 1
		j	xfor	
		
xendfor	:	l.s $f20, 0($sp)
		lw $s0, 4($sp)
		lw $ra, 8($sp)
		addiu $sp, $sp, 12
		jr	$ra
		
# sub terminal
# val : $a0 (argument)
# val : $v0 (return)
abss	:				# int abs(int val){
if	:	bge $a0, 0, endif	# if(val < 0)
		mul $a0, $a0, -1	# 	val = -val;
					#
endif	:	or $v0, $0, $a0		# return val;
		jr	$ra		# }
		
		

# array : $a0 - > $s0
# nval : $a1 - > $s1
# i : $s2
# media : $f20
# soma : $f22
var	:	addiu $sp, $sp, -24
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		s.s $f20, 16($sp)
		s.s $f22, 20($sp)
		move $s0, $a0
		move $s1, $a1
		
		jal	average
		cvt.s.d $f20, $f0	# media = (float)average(array, nval);
		
		li $s2, 0		# i = 0;
		sub.s $f22, $f22, $f22	# soma = 0.0;

vfor	:	bge $s2, $s1, vendif	#  while(i < nval){
		sll $t0, $s2, 3
		addiu $t0, $s0, 	1	# 						$t0 = $&array[i]
		l.d $f0, 0($t0)		#						$f0 = &array[i]
		cvt.s.d $f0, $f0	#						$f0 = (float)array[i]
		sub.s $f12, $f0, $f20	#						$f12 = array[i]-media
		li $a0, 2
		jal	xtoy		#						xtoy(..,2)
		add.s $f22, $f22, $f0	#						soma += xtoy(...)
		addi $s2, $s2, 1	# i++;
		j	vfor		# }
		
vendif	:	cvt.d.s $f22, $f22	# 						#f22 = (double)soma
		mtc1 $s1, $f0
		cvt.d.w $f0, $f0	#						$f0 = (double) nval
		div.d $f0, $f22, $f0	# return (double)soma / (double)nval
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		l.s $f20, 16($sp)
		l.s $f22, 20($sp)
		
		jr	$ra
		
#array: $a0
#n: $a1
#return: $f0
#i: $t0
#sum: $f0

average: 
	move $t0,$a1
	mtc1 $0, $f0
	cvt.d.w $f0,$f0
afor:	ble $t0,0,aendf
	addi $t1,$t0,-1
	sll $t1,$t1, 3
	addu $t1,$a0,$t1
	l.d $f2,0($t1)
	add.d $f0,$f0,$f2
	addi $t0,$t0,-1
	j afor

aendf:	
	mtc1 $a1,$f2
	cvt.d.w $f2,$f2
	div.d $f0,$f0,$f2
	jr $ra