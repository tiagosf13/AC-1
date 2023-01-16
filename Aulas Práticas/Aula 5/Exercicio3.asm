# Mapa de registos
# SIZE : $t1
# lista_size : $t2
# valor : $t3
# houve_troca : $t4
# i : $t5
# lista : $t6
# lista + i : $t7
	.data
	.eqv FALSE,0
	.eqv TRUE,1
	.eqv SIZE, 10
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv read_int, 5
lista	:	.space 40
str1	:	.asciiz "Insira os valores: \n"
	.text
	.globl main
	
main	:	la $a0, str1		# 					loading str1
		li $v0, print_string	# print_string(str1)			calling print_string()
		syscall			#					executing print_string()
		
		sub $t2, $t1, 1 
		li $t1, SIZE
		ori $t5, 0		# i = 0;
		
while	:	bgeu $t5, SIZE, endw
		
		li $v0, read_int	#					calling read_int()
		syscall			# valor = read_int();			executing read_int()
		or $t3, $0, $v0		#
		
		la $t6,lista 		#					loading pointer for lista $t2 = lista
		addu $t7, $t6, $t5 	# &lista[i] = lista + i	;
		lw $t3, 0($t7)		# lista[i] = valor;
		addi $t5, $0, 1		# i++;
		j	while		# }
		
	
endw	:				
do	: 				# do {
		li $t4,FALSE 		# houve_troca = FALSE;
		li $t5,0 		# i = 0;
		
for	:	bgeu $t5, $t2, endfor 	# while(i < SIZE-1){

if	:	sll $t7,... 		# $t7 = i * 4
		addu $t7,$t7,... 	# $t7 = &lista[i]
		lw $t8,0(...) 		# $t8 = lista[i]
		lw $t9,4(...) 		# $t9 = lista[i+1]
		b?? ...,...,endif 	# if(lista[i] > lista[i+1]){
		sw $t8,4(...) 		# lista[i+1] = $t8
		sw $t9,0(...) 		# lista[i] = $t9
		li $t4,TRUE 		#
					# }
					
endif	:	(...) 			# i++;
		(...) ... 		# }
		(...) 			# } while(houve_troca == TRUE);
		(...) 			# codigo de impressao do
					# conteudo do array
		jr $ra 			# termina o programa