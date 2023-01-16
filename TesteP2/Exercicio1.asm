# Mapa de Registos
# pt, n : $t0
# sum : $t3
# nit : $t4
# rv : $t5

	.data
	.eqv SIZE, 8
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
str  :	.asciiz "Media Invalida!\n"
	.align 2
list : 	.space 32
	.text
	.globl main
	

main	:	ori $t3, $0, 0				# sum = 0;
		ori $t4, $0, 0				# nit = 0;
		la $t0, list				# pt = list;
		ori $t1, $0, SIZE
		mul $t2, $t1, 4
		addu $t2, $t2, $t0			# list + SIZE
		
while	:	bge $t0, $t2, endw			# while(pt < list+ SIZE){
		li $v0, read_int
		syscall
		sw $v0, 0($t0)				# *pt = read_int();
		addiu $t0, $t0, 4			# pt++; 
		j	while				# }
		
endw	:	ori $t6 $0, 0				# n = 0;
		
while2	:	bge $t6, $t1, endw2			# while(n < SIZE){
		la $t0, list
		mul $t2, $t6, 4
		addu $t0, $t0, $t2			# list[n]
		lw $t0, 0($t0)
if	:	blt $t0, 0, endif			# if (list[n] >= 0){
		add $t3, $t3, $t0			# sum += list[n];
		addi $t4, $t4, 1			# nit++;
							# }
endif	:	addi $t6, $t6, 1			# n++;
		j	while2				# }

endw2	:
if2	:	ble $t4, 0, else2			# if(nit > 0){
		div $a0, $t3, $t4
		li $v0, print_int10
		syscall					# print_int10(sum/nit);
		ori $v0, $0, 0				# rv = 0;
		j	endif2				# }
else2	:	la $a0, str				# else [
		li $v0, print_string
		syscall					# print_string("Media Invalida!\n");
		ori $v0, $0, -1				# rv = -1;
							# }
endif2	:	jr	$ra				# return rv;					