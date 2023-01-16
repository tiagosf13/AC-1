# Mapa de registos: 
# $t0 - soma 
# $t1 - value 
# $t2 - i 
       .data 
str1 : .asciiz "Introduza um numero: " 
str2 : .asciiz "Valor ignorado\n"
str3 : .asciiz "A soma dos  positivos é: "
       .eqv print_string, 4 
       .eqv read_int, 5
       .eqv print_int10, 1
       
       .text 
       .globl main 
       
main :   li $t0, 0 			# soma = 0; 
         li $t2, 0 			# i = 0; 

for :  	 bge $t2, 5, endfor 		# while(i < 5) { 

	 la $a0, str1			# 				loading str1
       	 ori $v0, $0, print_string 	# 	print_string(str1);	calling print_string(str1)
       	 syscall			# 				executing print_string(str1); 
       	 
       	 ori $v0, $0, read_int		# 				calling read_int()
       	 syscall			# 	value = read_int();	executing read_int()
       	 or $t1, $0, $v0		# 				value=read_int();
       	 
       	 ble $t1,$0,else 		# if(value > 0) 
       	 add $t0, $t0, $t1 		# 	soma += value; 
       	 j endif 			#
       	 				
else : 	 la $a0, str2 			# else 				loading str2
 	 ori $v0, $0, print_string	# 	print_string(str2);	calling print_string(str2); 
 	 syscall			# 				executing print_string(str2)
 	 
endif :  addi $t2, $t2, 1		# i++; 
         j for 				# }			
         			
endfor : la $a0, str3			# 				loading str3
         ori $v0, $0, print_string	# print_string(str3);		calling print_string(str3)
         syscall			# 				executing print_string(str3); 
         		 
         or $a0, $0, $t0	 	# 				loading soma
         ori $v0, $0, print_int10	# print_int10(soma);		calling print_int10(soma)
         syscall			# 				executing print_int10(soma);
         jr $ra 			# 				finish the programm
