# Mapa de Registos
# $t0 : *max
#
#

	.data
	.eqv print_string, 4
	.eqv print_intu10, 36
	.eqv print_char, 11
	.eqv print_float, 2
	.eqv read_int, 5
	.eqv read_string, 8
	.eqv read_float, 6
	.eqv MAX_STUDENTS, 4
max_grade:	.float -20.0
sum	:	.float 0.0
	.align 2
media :	.space 4
st_array: .space 176
str1	: .asciiz "\nMedia: "
str2	:.asciiz 	"N. Mec: "
str3	:.asciiz "Primeiro Nome: "
str4	:.asciiz "Ultimo Nome: "
str5	:.asciiz "Nota: "
	.text
	.globl main
	

main	:
		addiu	$sp, $sp, -4
		sw	$ra, 0($sp)
		
		la	$a0, st_array
		li	$a1, MAX_STUDENTS
		jal	read_data			#	read_data(st_array, MAX_STUDENTS);
		
		l.s	$f12, media
		jal	max				#
		
		or	$t0, $0, $v0			#	pmax = max(st_array, MAX_STUDENTS, &media);
		
		la	$a0, str1
		li	$v0, print_string
		syscall					#	print_string("\nMedia: ")
		
		li	$v0, print_float
		syscall					#	print_float(media)
		
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		li	$v0, 0

		jr	$ra

# $a0 : student *st -> t2
# $a1 : int ns 
#
read_data:	ori	$t1, $0, 0				#	i = 0
		or	$t2, $0, $a0
		or	$t4, $0, $a1
while	:	bge	$t1, $t4, endw
		
		la	$a0, str2
		li	$v0, print_string
		syscall						#	print_string("N. Mec: ")
		
		li	$v0, read_int
		syscall
		
		mul	$t3, $t1, 44
		addu	$t3, $t2, $t3				#	st[i]
		
		sw	$v0, 0($t3)				#	st[i].id_number = read_int()
		
		la	$a0, str3
		li	$v0, print_string
		syscall						#	print_string("Primeiro Nome: ")
		
		addiu	$a0, $t3, 4
		li	$a1, 17
		li	$v0, read_string
		syscall						#	read_string(st[i].first_name, 17)
		
		la	$a0, str4
		li	$v0, print_string
		syscall						#	print_string("Ultimo Nome: ")
		
		addiu	$a0, $t3, 22
		li	$a1, 14
		li	$v0, read_string
		syscall						#	read_string(st[i].last_name, 17)
		
		la	$a0, str5
		li	$v0, print_string
		syscall						#	print_string("Nota: ")
		
		li	$v0, read_float
		syscall
		
		s.s	$f0, 40($t3)				#	st[i].grade = read_float()
		
		addi	$t1, $t1, 1
		j	while
		
endw	:	jr	$ra


# $a0 : student *st -> $t0
# $a1 : int ns
# $f0 : float *media
# $t0 : p
# $t1 : st+ns
max	:	or $t0, $0, $a0					# p = st;
		mul $t1, $a1, 44
		add $t1, $a0, $t1				# st + ns
		
while2	:	bge $t0, $t1, endw2				# while(p < st + ns){
		
		l.s $f7, 40($t0)
		la $t3, sum
		l.s $f7, 0($t3)
		add.s $f10, $f9, $f7				# sum += p->grade;
		s.s $f10, 0($t3)
		
		l.s $f8, max_grade 
if	:	c.le.s $f7, $f8					# if (p->grade > max_grade){
		bc1t endif
		mov.s $f8, $f7					# max_grade = f->grade;
		or $v0, $0, $t0					# pmax = p;
							 								 			# }
endif	:	addi $t0, $t0, 44				# p++;
		j	while2
								# }
																				# }
endw2	:	cvt.w.s $f6, $f6				# (float)ns
		l.s $f10, 0($t3)
		la $t0, media
		div.s $f6, $f10, $f6				# *media = sum / (float)ns;
		s.s $f6, 0($t0)
		or $v0, $0, $v0					# return pmax;
		jr	$ra					#




print_student:	jr	$ra

