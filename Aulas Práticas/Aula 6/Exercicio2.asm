# Mapa de Registos
# $t0 : p
# $t2 : pultimo
# $t3 : SIZE * 4 
# $t4 : *p
	
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
	

main	:	la $t0, array			# p = array;
		li $t3, SIZE
		sll $t3, $t3, 2
		add $t2, $t0, $t3		# pultimo = array + SIZE;
		
		
while	:	bge $t0, $t2, endw		# while(p < pultimo){
		lw $t4, 0($t0)
		
		or $a0, $0, $t4
		li $v0, print_string
		syscall				# print_string(*p);
		
		li $a0, '\n'
		li $v0, print_char
		syscall				# print_char('\n');
		
		addi $t0, $t0, 4
		
		j	while
	

endw	:	jr	$ra			# }