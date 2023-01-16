.data 	# data segment
	# nada a colocar aqui
.text	# code segment
.globl main

main : ori $t0, $0, 0xE543
       nor $t1, $0, $t0
       jr $ra