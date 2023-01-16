.data

.text
.globl main

main:	ori $v0, $0, 5
	syscall
	or $t0, $0, $v0		# $t0 = $v0 (input type int)
     	ori $t2, $0, 8	  	# $t2 = 8
	add $t1, $t0, $t0  	# $t1 = $t0 + $t0 = x + x = 2 * x
	sub $a0, $t1, $t2  	# $t1 = $t1 + $t2 = y = 2 * x - 8
	
	ori $v0, $0, 1		
	syscall			# print_int10(int value)
	
	#ori $v0, $0, 4 		# perguntar como é que mudo de linha
	#syscall			# print_string(char *str)
	
	ori $v0, $0, 34
	syscall			# print_int16(unsigned int value)
	
	ori $v0, $0,36
	syscall			# print_intu10(unsigned int value)
	
	jr $ra		  	# fim do programa 