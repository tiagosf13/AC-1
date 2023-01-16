# Mapa de registos 
# num : $t0 
# p : $t1 
# *p : $t2 (Registo temporário para guardar o valor armazenado na posição de memória p) 
	.data 
	.eqv SIZE, 20
	.eqv read_string, 8
	.eqv print_int10, 1
str	:	.space 21
	.text 
	.globl main 
	
main	:	ori $t0, $0, 0		# int num = 0;
		
		li $a1, SIZE
		la $a0, str
		li $v0, read_string				
		syscall			# read_string(str, SIZE);
		
 		la $t1, str 		# p = str; 
 		
 		
while	: 				# while(*p != '\0') 
 		lb $t2, 0($t1)		# 
 		beqz $t2, endw 		# { 
 		blt $t2, '0', endif 	# if(str[i] >='0' && 
 		bgt $t2, '9', endif 	# str[i] <= '9') 
 		addi $t0, $t0, 1 	# num++; 
 		
 		
endif: 		addiu $t1, $t1, 1 	# p++; 
 		j	while 		# } 
 		
 		
endw: 		or $a0, $0, $t0
		li $v0, print_int10 	# print_int10(num); 
		syscall
 		jr $ra 			# termina o programa 
