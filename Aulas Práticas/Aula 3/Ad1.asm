# Mapa de Resgistos
# $t0 - gray
# $t1 - bin
# $t2 - mask	
	
	.data
str1 : 	.asciiz "Introduza um número: "
str2 :	.asciiz "\nValor em Código Gray: "
str3 :	.asciiz "\nValor em binário: "
	.text
	.globl main
   	.eqv print_string, 4
   	.eqv print_int16, 34
       	.eqv read_int, 5
       	
    
main	:	la $a0, str1			# 				loading str1
		li $v0, print_string		# print_string(str1);		calling print_string()
		syscall				# 				executing print_string(str1)
		
		li $v0, read_int		#				calling read_int()
		syscall				# gray = read_int()		executing read_int()
		or $t0, $0, $v0			#				storing input in $t0 
		
		srl $t2, $t0, 1			# mask = gray >> 1		logical shift of 1 bit to the right
		or $t1, $0, $t0			# bin = gray			copying gray to bin
		
while	:	beq $t2, 0, endwhile		# while (mask != 0)[
		
		xor $t1, $t1, $t2		# bin = bin ^ mask		bin = bin xor mask
		srl $t2, $t2, 1			# mask = mask >> 1		logical shift of 1 bit to the right
		
		j	while
		
endwhile:	la $a0, str2			# 				loading str2
		li $v0, print_string		# print_string(str2);		calling print_string()
		syscall				# 				executing print_string(str2)
		
		or $a0, $0, $t0			#				loading $t0
		li $v0, print_int16		# print_int16(gray);		calling print_int16()
		syscall				#				executing print_int16(gray)
		
		la $a0, str3			# 				loading str3
		li $v0, print_string		# print_string(str3);		calling print_string()
		syscall				# 				executing print_string(str2)
		
		or $a0, $0, $t1			#				loading $t1
		li $v0, print_int16		# print_int16(bin);		calling print_int16()
		syscall				#				executing print_int16(bin)
		
		jr	$ra