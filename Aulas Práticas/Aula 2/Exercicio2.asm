.data 	# data segment
	# nada a colocar aqui
.text	# code segment
.globl main

main : li $t0, 7		# instru��o virtual (decomposta 
 					# em duas instru��es nativas) 
       sll $t2, $t0, 4			#
       srl $t3, $t0, 4			#
       sra $t4, $t0, 4			#
       jr $ra				# fim do programa
