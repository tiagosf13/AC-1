#typedef struc
# {			Align	 Size    Offset
#   int acc;		 04	  04	   0
#   unsigned char nm;	 01	  01	   04
#   double grade;	 08	  08	   08
#   char quest[14];	 01	  14	   16
#   int cq;		 04	  04	   32
# } t_kvd;		 08	  40

# Mapa de Registos
# nv : $a0
# pt : $a1
# i : $t0
# j : $t1
# sum : $f4


	.data
sum :	.double 0.0
	.text
	.globl func4
	
	
# nv : $a0
# *pt : $a1
func4	:	ori $t0, $0, 0		# i = 0;

while	:	bge $t0, $a0, endw	# while(i < nv){	
		ori $t1, $0, 0		# j = 0;
		
do	:	addiu $t2, $a1, 16
		addu $t2, $t2, $t1
		lb $t2, 0($t2)
		mtc1 $t2, $f2
		cvt.d.w $f2, $f2
		la $t2, sum
		l.d $f4, sum
		add.d $f4, $f4, $f2
		s.d $f4, 0($t2)		# sum += (double) pt->quest[j];
		addi $t1, $t1, 1	# j++;
		
		addiu $t2, $a1, 4
		lb $t2, 0($t2)
		
while2	:	blt $t1, $t2, do	# } while(j < pt->nm);
		
		addiu $t3, $a1, 8
		l.d $f4, sum
		l.d $f2, 0($t3)
		div.d $f2, $f4, $f2
		cvt.w.d $f2, $f2
		mfc1 $t2, $f2
		
		sw $t2, 0($t2)		# pt-> = (int) (sum / pt->grade);

		addi $t0, $t0, 1	# i++;
		addi $a1, $a1, 40	# pt++;
		j	while
		
endw	:	lw $t3, 32($t3)		# }
		mtc1 $t3, $f2
		cvt.d.w $f2, $f2
		l.d $f0, 8($t3)
		mul.d $f0, $f0, $f2
		
		jr	$ra		# return (pt->grade * (double) pt->cq);
