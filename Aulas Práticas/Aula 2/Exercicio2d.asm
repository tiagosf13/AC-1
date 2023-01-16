.data 	# data segment
	# nada a colocar aqui
.text	# code segment
.globl main

main : li $t0, 7			# instrução virtual (decomposta 
       or $t1, $0, $t0
 					
 					# em duas instruções nativas) 
       srl $t3, $t1, 4			#
       xor $t1, $t1, $t3 		#
       
       srl $t3, $t1, 2			#
       xor $t1, $t1, $t3 		#
       
       srl $t3, $t1, 1			#
       xor $t1, $t1, $t3		#
       
       or $t2, $0, $t1			#
       jr $ra				# fim do programa
