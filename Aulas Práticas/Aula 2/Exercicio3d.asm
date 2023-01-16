      .data 
str1: .asciiz "Introduza 2 numeros\n" 
str2: .asciiz "A soma dos dois numeros é: " 
      .eqv print_string,4 
      .eqv read_int,5
      .eqv print_int10,1
      
      .text 
      .globl main 
      
      
main: la $a0,str1			# loading str1
      ori $v0,$0,print_string 		# calling print_string(str1)	
      syscall 				# executing print_string(str1); 	
      		
      ori $v0,$0,read_int 		# calling read_int()
      syscall				# reading a integer with read_int()
      or $t0,$v0,$0 			# storing the integer value (a) in $t0
      
      				
      ori $v0, $0, read_int		# calling read_int()
      syscall 				# reading a integer with read_int()
      or $t1, $0, $v0			# storing the integer value (b) in $t1
     
      la $a0, str2 			# loading str2
      ori $v0, $0, print_string		# calling print_string(str2)
      syscall				# executing print_string(str2)
      
      add $a0, $t1, $t0		 	# $a0 = $t1 (a) + $t0 (b)
      
      
      ori $v0, $0, print_int10		# calling print_int10()
      syscall				# executing print_int10()
      
      jr $ra 				# fim do programa
