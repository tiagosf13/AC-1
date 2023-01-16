# Mapa de Registos
#
#


	.data
	.eqv read_int, 5
	.text
	.globl main
	

main	:	li $v0, read_int
		syscall
		
		