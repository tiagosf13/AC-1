# Mapa de Registos
# $t0 : &array[0]
# $t1 : i
# $t2 : j
# $t3 : temporario
	
	.data
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
str1 :  .asciiz "Array"
str2 :	.asciiz "de"
str3 :	.asciiz "ponteiros"
str4 :	.asciiz "\nString #"
str5 :	.asciiz ": "
array:	.word str1, str2, str3
	.text
	.globl main
	

main	:	la $t0, array
		ori $t1, $0, 0			# i = 0;
		

while	:	bge $t1, SIZE, endw		# while(i < SIZE){

		la $a0, str4
		li $v0, print_string
		syscall				# print_string("\nString #");
		
		or $a0, $0, $t1
		li $v0, print_int10
		syscall				# print_int10(i);
		
		la $a0, str5
		li $v0, print_string
		syscall				# print_string(": ");
		
		li $t2, 0			# j = 0;
		
while2 :	sll $t3, $t1, 2
		addu $t3, $t3, $t0
		lw $t3, 0($t3)
		
		addu $t3, $t3, $t2
		
		lb $t3, 0($t3)
		

		beq $t3, '\0', endw2		# while(array[i][j] != '\0'){
		
		or $a0, $0, $t3
		li $v0, print_char
		syscall				# print_char(array[i][j]);
		
		 li $a0, '-'
		 syscall			# print_char('-');
		 
		 addi $t2, $t2, 1		# d++; 
		
		j	while2			# }

endw2 :		addi $t1, $t1, 1		# i++;
		j	while
		
endw	:	jr	$ra			# }