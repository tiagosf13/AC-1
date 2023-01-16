# Mapa de Registos
# $t0 - res
# $t1 - i
# $t2 - mdor
# $t3 - mdo
	
	.data
str1 :	.asciiz "Introduza dois números: "
str2 : 	.asciiz "Resultado: "
	.text
	.globl main
       	.eqv print_string, 4
       	.eqv read_int, 5
       	.eqv print_int10, 1
       	
   
main	:	ori $t0, $0, 0				# res = 0
		ori $t1, $0, 0				# i = 0
		
		la $a0, str1				#					loading str1
		li $v0, print_string			# print_string(str1);			calling print_string()
		syscall					#					executing print_string(str1) 
		
		li $v0, read_int			#					calling read_int()
		syscall					# read_int()				executing read_int()
		
		andi $v0, $v0, 0x0000FFFF		#					read_int() & 0x0F
		or $t2, $0, $v0				# mdor = read_int() & 0x0F;
		
		li $v0, read_int			#					calling read_int()
		syscall					# read_int()				executing read_int()
		
		andi $v0, $v0, 0x0000FFFF			#					read_int() & 0x0F
		or $t3, $0, $v0				# mdo = read_int() & 0x0F;
		
		
while	:	beq $t2, 0, endwhile			# 	
		bge $t1, 16, endwhile			# while((mdor != 0) && (i++ < 4)){					
		addi $t1, $t1, 1 			#					i incrementation
		
if	:	andi $t5, $t2, 0x00000001		#
		beq $t5, 0, endif			# if((mdor & 0x00000001) != 0)
		add $t0, $t0, $t3			# res = res + mdo;
		

endif	:	sll $t3, $t3, 1				# mdo = mdo << 1;			logical shift of 1 bit to the left 
		srl $t2, $t2, 1				# mdor = mdor >> 1;			logical shift of 1 bit to the right
		j	while				#}

endwhile:	la $a0, str2				# 					loading str2
		li $v0, print_string			# print_string(str2);			calling print_string()
		syscall					# 					executing print_string(str2)
		
		or $a0, $0, $t0				#					loading $t0 
		li $v0, print_int10			# print_int10(res);			calling print_int10()
		syscall					#					executing print_int10(res)
		
		

		 
