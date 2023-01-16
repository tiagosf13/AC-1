# Mapa de Registos
# 
# 
#


	.data
	.eqv SIZE, 15
	.eqv print_string, 4
	.eqv print_int10, 1
str :	.asciiz "Invalid argc!"
	.text
	.globl func2

# *fl : $a0 -> $s0
# k : $a1 -> $s1
# *av[] : $a2 -> $s2
# i : $s3
func2	:	addiu $sp, $sp, -20			# prologo
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		
		or $s0, $0, $a0
		or $s1, $0, $a1
		or $s2, $0, $a2
		
if1	:	blt $s1, 2, else
if2	:	bgt $s1, SIZE, else			# if((k >= 2) && (k <= SIZE)){
		
		ori $s3, $0, 2				# i = 2;

do	:	mul $t0, $s3, 4				# do {
		addu $t1, $s2, $t0
		lw $a0, 0($t1)
		jal	toi
		addu $t1, $s0, $t0
		sw $v0, 0($t1)				# fl[i] = toi(av[i]);
		addi $s3, $s3, 1			# i++;

while	:	blt $s3, $s1, do			# } while(i < k);
		
enddo	:	or $a0, $0, $s0
		or $a1, $0, $s1
		jal	avz
		or $a0, $0, $v0				# res = avz(fl, k);
		
		or $t0, $0, $a0
		
		li $v0, print_int10
		syscall					# print_int10(res);
		
		j	endif
		
else	:	la $a0, str				#}else
		li $v0, print_string
		syscall					# print_string("Invalid argc");
		
endif	:	or $v0, $0, $t0

		lw $ra, 0($sp)				# epilogo
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		addiu $sp, $sp, 20
		
		jr	$ra				# return res;
