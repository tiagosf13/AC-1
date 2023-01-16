# Mapa de Registos
# $t0 : &array[0]
# $t1 : i
# $t2 : &array[i]
# $t3 : temporario
	
	.data
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
str1 :  .asciiz "Array"
str2 :	.asciiz "de"
str3 :	.asciiz "ponteiros"
array:	.word str1, str2, str3
	.text
	.globl main
	

main	:	la $t0, array
		ori $t1, $0, 0			# i = 0;

while	:	bge $t1, SIZE, endw		# while(i < SIZE){
		sll $t3, $t1, 2
		addu $t3, $t3, $t0	
		lw $t2, 0($t3)
		
		or $a0, $0, $t2
		li $v0, print_string
		syscall				# print_string(array[i]);
		
		li $a0, '\n'
		li $v0, print_char
		syscall				# print_char('\n');
		
		addi $t1, $t1, 1
		
		j	while

endw :		jr	$ra				# }