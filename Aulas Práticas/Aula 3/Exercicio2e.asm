# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
# $t3 - resto
# $t4 - char_to_print
# $t5 - flag
# $t6 - condition for second if
	
       .data
str1 : .asciiz "Introduza um numero: "
str2 : .asciiz "\nO valor em binário é: "
       .text
       .globl main
       .eqv print_string, 4
       .eqv read_int, 5
       .eqv print_char, 11
       
	
main	:	la $a0,str1			#				loading str1
		li $v0,print_string 		# print_string(str1);		calling print_string()
		syscall 			# 				executing print_string(str1)
		
		li $v0, read_int		#				calling read_int()
		syscall				# value=read_int();		executing read_int()			
		or $t0, $0, $v0			# 				storing the integer in $t0
		
		la $a0, str2 			# 				loading str2
		li $v0, print_string		# print_string(str2);		calling print_string()
		syscall				# 				executing print_string(str2)
		
		li $t2, 0 			# i = 0
		li $t5, 0
		
		
do	:	andi $t1, $t0, 0x80000000 	# do{				isolating the most significant bit
		srl $t1, $t1, 31		# bit = bit >> 31;		logical shift of 31 bits to the right
		
		
if1	:	beq $t5, 1, then1		# if (flag == 1 || bit != 0){
		beq $t1, 0, endif1		#
		
		
then1	:	ori $t5, $0, 1			# flag = 1
		rem $t3, $t2, 4			# resto = i % 4
		
		
if2	:	bne $t3, 0, endif2		# if (resto == 0)
		ori $a0, $0, 0x00000020		#				loading char ' '
		li $v0, print_char		# print_char(' ')		calling print_char()
		syscall				# }				executing print_char(' ')	
		
		
endif2	:	addi $t4, $t1, 0x00000030	# char_to_print = bit + 0x30
		or $a0, $0, $t4			# 				loading char $t4
		li $v0, print_char		# print_char($t4);		calling print_char()
		syscall				#				executing print_char($t4)
			
									
endif1	: 	sll $t0, $t0, 1			# value = value << 1;		logical shift of 1 bit to the left 
		addi $t2, $t2, 1		# i++;				
		j for 				# }
		
		
for	:	blt $t2, 32, do			# }while(i < 32)
		
		
endfor	: 	jr $ra 				# fim do programa