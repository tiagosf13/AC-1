	.data 	# data segment
		# nada a colocar aqui
	
str1 : .asciiz "Uma string qualquer"
str2 : .asciiz "AC1 - P"

	.text	# code segment
	.globl main

main : jr $ra				# fim do programa
