# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
# $t3 - resto
	
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
		
		li $t2,0 			# i = 0
		
		
for	:	bge $t2, 32, endfor 		# while(i < 32) {
		andi $t1, $t0, 0x80000000 	# 				isolating the most significant bit
		
		rem $t3, $t2, 4			# resto = i % 4
		bne $t3, 0, else2		# if (resto == 0)
		ori $a0, $0, 0x00000020		#				loading char ' '
		li $v0, print_char		# print_char(' ')		calling print_char()
		syscall				#				executing print_char(' ')
		
		
else2	:	beq $t1,$0,else 		# if(bit != 0)
		ori $a0, $0, 0x00000031		# 				loading char '1'
		li $v0, print_char		# print_char('1');		calling print_char()
		syscall				#				executing print_char('1')
		j endif
		
		
else	: 	ori $a0, $0, 0x00000030		# else 				loading char '0'
		li $v0, print_char		# print_char('0');		calling print_char
		syscall				#				executing print_char('0')
			
									
endif	: 	sll $t0, $t0, 1			# value = value << 1;		logical shift of 1 bit to the left 
		addi $t2, $t2, 1		# i++;				
		j for 				# }
		
		
endfor	: 	jr $ra 				# fim do programa
