# Mapa de Registos
# $t0 : argc
# $t1 : argv
# $t2 :  i
# $t3 : temporario
	
	.data
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
str1 :  .asciiz "Nr. de parametros: "
str2 :	.asciiz "\nP"
str3 :	.asciiz ": "
	.text
	.globl main
	

main	:	or $t0, $0, $a0
		or $t1, $0, $a1
		
		la $a0, str1
		li $v0, print_string
		syscall					# print_string("Nr. de parametros: "); 
		
		or $a0, $0, $t0
		li $v0, print_int10
		syscall					# print_int10(argc);
		
		li $t2, 0
		
while	:	bge $t2, $t0, endw
		
		la $a0, str2
		li $v0, print_string
		syscall					# print_string("\nP");
		
		or $a0, $0, $t2
		li $v0, print_int10
		syscall					# print_int(i); 
		
		la $a0, str3
		li $v0, print_string
		syscall					# print_string(": ");
		
		sll $t3, $t2, 2
		addu $t3, $t3, $t1
		lw $a0, 0($t3)
		
		syscall					# print_string(argv[i]);
				
		addi $t2, $t2, 1			# i++;
		j	while

endw	:	li $v0, 0
		jr	$ra
