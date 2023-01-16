# Mapa de Registos
#
#

	.data
str1 :	.asciiz "\nN. Mec: "
str2 :	.asciiz "\nNome: "
str3 :	.asciiz "\nNota: "
str4 :	.asciiz "\nPrimeiro Nome: "
	.eqv print_string, 4
	.eqv print_intu10, 36
	.eqv print_char, 11
	.eqv print_float, 2
	.eqv read_int, 5
	.eqv read_string, 8
	.eqv read_float, 6
	.align 2
stg	:	.word 72343
		.asciiz "Napoleao"
		.space 9				# 18 - 9
		.asciiz "Bonaparte"
		.space 5				# 15 - 10
		.float 5.1
	.text
	.globl main
	
	
main	:	la	$t0, stg			# $t0 = stg
		
		la	$a0, str1
		li	$v0, print_string
		syscall					# print_string("\nN. Mec: ")
		
		li	$v0, read_int
		syscall
		sw 	$v0, 0($t0)				# stg.id_number = read_int()
		
		la 	$a0, str4
		li 	$v0, print_string
		syscall					# print_string("\nPrimeiro Nome: ")
		
		addiu 	$a0, $t0, 4
		li 	$a1, 17
		li 	$v0, read_string
		syscall					# read_string(stg.first_name, 17)
		
		addiu 	$a0, $t0, 22
		li 	$a1, 17
		li 	$v0, read_string
		syscall					# read_string(stg.last_name, 17)
		
		li 	$v0, read_float
		syscall
		s.s $f0, 40($t0)			# read_float(stg.grade)
		
		la	$a0, str1
		li	$v0, print_string
		syscall					# print_string("\nN. Mec: ")
		
		lw	$a0, 0($t0)			# $a0 = stg.id_number
		li	$v0, print_intu10
		syscall					# print_intu10(stg.id_number)
		
		la	$a0, str2
		li	$v0, print_string
		syscall					# print_string("\nNome: ")
		
		addiu 	$a0, $t0, 22			# $a0 = &stg.last_name[0]
		li	$v0, print_string
		syscall					# print_string(stg.last_name)
		
		li $a0, ','
		li $v0, print_char
		syscall					# print_char(',')
		
		addiu $a0, $t0, 4			# $a0 = &stg.first_name[0]
		li $v0, print_string
		syscall					# print_string(stg.first_name)
		
		la $a0, str3
		syscall					# print_string("\nNota: ")
		
		l.s $f12, 40($t0)			# $f12 = &stg.grade
		li $v0, print_float
		syscall					# print_float(stg.grade)
		
		li $v0, 0				# return 0
		
		jr	$ra
	
