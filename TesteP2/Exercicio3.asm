# Mapa de Registos
# a : $f12
# t : $f14
# n : $a0
# oldg : $f2
# g : $f4
# s : $f8
# k : $t0


	.data
oldg :	.float -1.0
g    :	.float 1.0
s    :	.float 0.0
	.text
	.globl func3
	

func3	:	ori $t0, $0, 0			# k = 0;
		
while	:	bge $t0, $a0, endw		# while(k < n) {
		l.s $f2, oldg
		l.s $f4, g
		sub.s $f6, $f4, $f2
		
while2	:	ble $f6, $f14, endw2		# while((g - oldg) > t) {
		or $f2, $0, $f4			# oldg = g;
		mul $t1, $t0, 4
		addu $t1, $f12, $t1
		l.s $t1, 0($t1)
		add.s $f4, $f4, $t1
		sub.s $f4, $f4, $f14		# g = (g + a[k]) / t;
		j	while2
		
endw2	:					# }
		l.s $f8, s
		add.s $f8, $f8, $f4		# s = s + g;
		mul $t1, $t0, 4
		addu $t1, $f12, $t1
		s.s $f4, 0($t1)
		addi $t0, $t0, 1		# k++;
						
		j	while

endw	:					# }
		mtc1 $a0, $f2
		cvt.s.w $f2, $f2
		sub.s $f0, $f8, $f2
		jr	$ra			# return s / (float) n;