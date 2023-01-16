# Mapa de registos
# p: $t0
# *p: $t1 (Registo temporário para guardar o valor armazenado em memória)
# lista+Size: $t2
	.data
	.eqv SIZE, 10
str1	:	.asciiz "; "
str2	: 	.asciiz "\nConteudo do array:\n"
	.align 2
lista	:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15 		# a diretiva ".word" alinha num endereço
									# múltiplo de 4
	.eqv print_int10, 1
	.eqv print_string, 4
	.text
	.globl main
	
main	: 	la $a0, str2 						# 						loading str2
		li $v0, print_string					# print_string(...)				calling print_string()
		syscall							#						executing print_string(str2)
		la $t0, lista 						# p = lista					loading array
		li $t2, SIZE 						#
		sll $t2, $t2, 2 					# SIZE = SIZE * 4					index of next_adress
		addu $t2, $t0, $t2					# $t2 = lista + SIZE;
		
		
while	: 	bgeu $t0, $t2, endw 					# while(p < lista+SIZE) {
		lw $t1, 0($t0) 						# $t1 = *p;					accessing the content of the array at position p
		or $a0, $0, $t1 					#						loading the content								
		li $v0, print_int10 					# print_int10( *p );				calling print_int10()
		syscall							#						executing print_int10(*p)
		
		la $a0, str1 						# 						loading str2
		li $v0, print_string					# print_string(...);				calling print_string()
		syscall							#						executing print_string(str2)
		
		addiu $t0, $t0, 4 					# p++;
		j	while 						# }

		
endw	:	jr $ra 							# termina o programa
