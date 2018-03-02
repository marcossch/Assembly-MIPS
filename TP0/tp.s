	.file	1 "tp.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"%s\n\000"
	.align	2
$LC1:
	.ascii	"An error ocurred while checking for palindromes!\000"
	.align	2
$LC2:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,80,$ra		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	sw	$zero,24($fp)
	sw	$zero,28($fp)
	addu	$v0,$fp,28
	lw	$a0,80($fp)
	lw	$a1,84($fp)
	move	$a2,$v0
	addu	$a3,$fp,24
	la	$t9,process_params
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	beq	$v0,$zero,$L29
	lw	$v1,32($fp)
	li	$v0,4			# 0x4
	bne	$v1,$v0,$L30
	li	$v0,4			# 0x4
	sw	$v0,56($fp)
	b	$L28
$L30:
	sw	$zero,56($fp)
	b	$L28
$L29:
	lw	$a0,28($fp)
	la	$t9,open_input
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L32
	li	$v0,5			# 0x5
	sw	$v0,56($fp)
	b	$L28
$L32:
	lw	$a0,24($fp)
	la	$t9,open_output
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L33
	lw	$a0,36($fp)
	la	$t9,fclose
	jal	$ra,$t9
	li	$v0,6			# 0x6
	sw	$v0,56($fp)
	b	$L28
$L33:
	lw	$a0,36($fp)
	li	$a1,256			# 0x100
	la	$t9,read_input
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L34
	lw	$a0,40($fp)
	lw	$a1,36($fp)
	la	$t9,close_files
	jal	$ra,$t9
	li	$v0,7			# 0x7
	sw	$v0,56($fp)
	b	$L28
$L34:
	lw	$a0,44($fp)
	la	$t9,get_palindromes
	jal	$ra,$t9
	sw	$v0,48($fp)
	lw	$a0,44($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$v0,48($fp)
	bne	$v0,$zero,$L35
	la	$a0,$LC0
	la	$a1,$LC1
	la	$t9,printf
	jal	$ra,$t9
	lw	$a0,36($fp)
	lw	$a1,40($fp)
	la	$t9,close_files
	jal	$ra,$t9
	li	$v0,3			# 0x3
	sw	$v0,56($fp)
	b	$L28
$L35:
	lw	$a0,48($fp)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L36
	sw	$zero,56($fp)
	b	$L28
$L36:
	lw	$a0,40($fp)
	lw	$a1,48($fp)
	la	$t9,write_result
	jal	$ra,$t9
	sw	$v0,52($fp)
	lw	$v1,52($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L38
	lw	$a0,36($fp)
	lw	$a1,40($fp)
	la	$t9,close_files
	jal	$ra,$t9
	lw	$v0,48($fp)
	beq	$v0,$zero,$L39
	lw	$a0,48($fp)
	la	$t9,free
	jal	$ra,$t9
$L39:
	li	$v0,2			# 0x2
	sw	$v0,56($fp)
	b	$L28
$L38:
	lw	$v0,48($fp)
	beq	$v0,$zero,$L40
	lw	$a0,48($fp)
	la	$t9,free
	jal	$ra,$t9
$L40:
	lw	$a0,36($fp)
	lw	$a1,40($fp)
	la	$t9,close_files
	jal	$ra,$t9
	sw	$zero,56($fp)
$L28:
	lw	$v0,56($fp)
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	main
	.size	main, .-main
	.rdata
	.align	2
$LC3:
	.ascii	"%s%s\n\000"
	.align	2
$LC4:
	.ascii	"An error ocurred while allocating memory! Error: \000"
	.align	2
$LC5:
	.ascii	"An error ocurred while reallocating memory! Error: \000"
	.text
	.align	2
	.globl	read_input
	.ent	read_input
read_input:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	sw	$zero,32($fp)
	lw	$a0,60($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L42
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC4
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,36($fp)
	b	$L41
$L42:
	.set	noreorder
	nop
	.set	reorder
$L43:
	lw	$a0,56($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L45
	b	$L44
$L45:
	addu	$a1,$fp,32
	lw	$v1,0($a1)
	move	$a0,$v1
	lw	$v0,24($fp)
	addu	$a0,$a0,$v0
	lbu	$v0,28($fp)
	sb	$v0,0($a0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	lw	$v1,32($fp)
	lw	$v0,60($fp)
	bne	$v1,$v0,$L43
	lw	$v0,60($fp)
	addu	$v0,$v0,64
	sw	$v0,60($fp)
	lw	$a0,24($fp)
	move	$a1,$v0
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L43
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,36($fp)
	b	$L41
$L44:
	addu	$a1,$fp,32
	lw	$v1,0($a1)
	move	$a0,$v1
	lw	$v0,24($fp)
	addu	$v0,$a0,$v0
	sb	$zero,0($v0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	lw	$a0,24($fp)
	lw	$a1,32($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L48
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,36($fp)
	b	$L41
$L48:
	lw	$v0,24($fp)
	sw	$v0,36($fp)
$L41:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	read_input
	.size	read_input, .-read_input
	.rdata
	.align	2
$LC6:
	.ascii	"%s\000"
	.align	2
$LC7:
	.ascii	"An error ocurred while writing the result! Error: \000"
	.text
	.align	2
	.globl	write_result
	.ent	write_result
write_result:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC6
	lw	$a2,52($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bgez	$v0,$L50
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC7
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	li	$v0,1			# 0x1
	sw	$v0,28($fp)
	b	$L49
$L50:
	sw	$zero,28($fp)
$L49:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	write_result
	.size	write_result, .-write_result
	.rdata
	.align	2
$LC8:
	.ascii	"r\000"
	.align	2
$LC9:
	.ascii	"An error ocurred while opening input file! Error: \000"
	.text
	.align	2
	.globl	open_input
	.ent	open_input
open_input:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$v0,48($fp)
	bne	$v0,$zero,$L52
	la	$v0,__sF
	sw	$v0,24($fp)
	b	$L53
$L52:
	lw	$a0,48($fp)
	la	$a1,$LC8
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L53
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC9
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
$L53:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	open_input
	.size	open_input, .-open_input
	.rdata
	.align	2
$LC10:
	.ascii	"w\000"
	.align	2
$LC11:
	.ascii	"An error ocurred while opening output file! Error: \000"
	.text
	.align	2
	.globl	open_output
	.ent	open_output
open_output:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$v0,48($fp)
	bne	$v0,$zero,$L56
	la	$v0,__sF+88
	sw	$v0,24($fp)
	b	$L57
$L56:
	lw	$a0,48($fp)
	la	$a1,$LC10
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L57
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC11
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
$L57:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	open_output
	.size	open_output, .-open_output
	.align	2
	.globl	close_files
	.ent	close_files
close_files:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	lw	$a0,40($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,fclose
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	close_files
	.size	close_files, .-close_files
	.align	2
	.globl	strrev
	.ent	strrev
strrev:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	lw	$v0,56($fp)
	beq	$v0,$zero,$L62
	lw	$v0,56($fp)
	lb	$v0,0($v0)
	bne	$v0,$zero,$L61
$L62:
	lw	$v0,56($fp)
	sw	$v0,32($fp)
	b	$L60
$L61:
	lw	$v0,56($fp)
	sw	$v0,24($fp)
	lw	$a0,56($fp)
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,56($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,-1
	sw	$v0,28($fp)
$L63:
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L66
	b	$L64
$L66:
	lw	$a1,24($fp)
	lw	$v0,24($fp)
	lw	$v1,28($fp)
	lbu	$a0,0($v0)
	lbu	$v0,0($v1)
	xor	$v0,$a0,$v0
	sb	$v0,0($a1)
	lw	$a1,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	lbu	$a0,0($v0)
	lbu	$v0,0($v1)
	xor	$v0,$a0,$v0
	sb	$v0,0($a1)
	lw	$a1,24($fp)
	lw	$v0,24($fp)
	lw	$v1,28($fp)
	lbu	$a0,0($v0)
	lbu	$v0,0($v1)
	xor	$v0,$a0,$v0
	sb	$v0,0($a1)
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v0,28($fp)
	addu	$v0,$v0,-1
	sw	$v0,28($fp)
	b	$L63
$L64:
	lw	$v0,56($fp)
	sw	$v0,32($fp)
$L60:
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	strrev
	.size	strrev, .-strrev
	.align	2
	.globl	get_palindromes
	.ent	get_palindromes
get_palindromes:
	.frame	$fp,88,$ra		# vars= 48, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 16
	sw	$ra,80($sp)
	sw	$fp,76($sp)
	sw	$gp,72($sp)
	move	$fp,$sp
	sw	$a0,88($fp)
	lw	$a0,88($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bgtz	$v0,$L68
	la	$v0,$LC2
	sw	$v0,60($fp)
	b	$L67
$L68:
	sw	$zero,28($fp)
	sw	$zero,32($fp)
	lw	$a0,24($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L69
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC4
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L67
$L69:
	lw	$v0,24($fp)
	sw	$v0,40($fp)
	lw	$a0,40($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L70
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC4
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L67
$L70:
	lw	$a0,44($fp)
	move	$a1,$zero
	lw	$a2,40($fp)
	la	$t9,memset
	jal	$ra,$t9
	sw	$zero,48($fp)
$L71:
	lw	$v0,48($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L74
	b	$L72
$L74:
	lw	$v1,88($fp)
	lw	$v0,48($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	sw	$v0,56($fp)
	lw	$v0,56($fp)
	slt	$v0,$v0,48
	bne	$v0,$zero,$L75
	lw	$v0,56($fp)
	slt	$v0,$v0,58
	beq	$v0,$zero,$L75
	b	$L73
$L75:
	lw	$v0,56($fp)
	slt	$v0,$v0,65
	bne	$v0,$zero,$L78
	lw	$v0,56($fp)
	slt	$v0,$v0,91
	bne	$v0,$zero,$L73
$L78:
	lw	$v0,56($fp)
	slt	$v0,$v0,97
	bne	$v0,$zero,$L76
	lw	$v0,56($fp)
	slt	$v0,$v0,123
	bne	$v0,$zero,$L73
$L76:
	lw	$v1,56($fp)
	li	$v0,95			# 0x5f
	beq	$v1,$v0,$L73
	lw	$v1,56($fp)
	li	$v0,45			# 0x2d
	beq	$v1,$v0,$L73
	lw	$a0,36($fp)
	move	$a1,$zero
	lw	$a2,24($fp)
	la	$t9,memset
	jal	$ra,$t9
	sw	$zero,52($fp)
$L81:
	lw	$v1,48($fp)
	lw	$v0,28($fp)
	subu	$v1,$v1,$v0
	lw	$v0,52($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L84
	b	$L82
$L84:
	lw	$v1,36($fp)
	lw	$v0,52($fp)
	addu	$a0,$v1,$v0
	lw	$v1,28($fp)
	lw	$v0,52($fp)
	addu	$v1,$v1,$v0
	lw	$v0,88($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,52($fp)
	addu	$v0,$v0,1
	sw	$v0,52($fp)
	b	$L81
$L82:
	lw	$a0,36($fp)
	la	$t9,is_palindrome
	jal	$ra,$t9
	beq	$v0,$zero,$L85
	sw	$zero,52($fp)
$L86:
	lw	$v1,48($fp)
	lw	$v0,28($fp)
	subu	$v1,$v1,$v0
	lw	$v0,52($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L89
	b	$L87
$L89:
	lw	$v1,44($fp)
	lw	$v0,32($fp)
	addu	$a0,$v1,$v0
	lw	$v1,36($fp)
	lw	$v0,52($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	lw	$v0,40($fp)
	bne	$v1,$v0,$L88
	lw	$v0,40($fp)
	sw	$v0,64($fp)
	lw	$v0,64($fp)
	bgez	$v0,$L91
	lw	$v0,64($fp)
	addu	$v0,$v0,3
	sw	$v0,64($fp)
$L91:
	lw	$v0,64($fp)
	sra	$v1,$v0,2
	lw	$v0,40($fp)
	addu	$v0,$v0,$v1
	sw	$v0,40($fp)
	lw	$a0,44($fp)
	move	$a1,$v0
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L88
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L67
$L88:
	lw	$v0,52($fp)
	addu	$v0,$v0,1
	sw	$v0,52($fp)
	b	$L86
$L87:
	lw	$v1,44($fp)
	lw	$v0,32($fp)
	addu	$v1,$v1,$v0
	li	$v0,10			# 0xa
	sb	$v0,0($v1)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	lw	$v0,40($fp)
	bne	$v1,$v0,$L85
	lw	$v0,40($fp)
	sw	$v0,68($fp)
	lw	$v0,68($fp)
	bgez	$v0,$L94
	lw	$v0,68($fp)
	addu	$v0,$v0,3
	sw	$v0,68($fp)
$L94:
	lw	$v0,68($fp)
	sra	$v1,$v0,2
	lw	$v0,40($fp)
	addu	$v0,$v0,$v1
	sw	$v0,40($fp)
	lw	$a0,44($fp)
	move	$a1,$v0
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L85
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L67
$L85:
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
$L73:
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L71
$L72:
	addu	$a1,$fp,32
	lw	$v1,0($a1)
	move	$a0,$v1
	lw	$v0,44($fp)
	addu	$v0,$a0,$v0
	sb	$zero,0($v0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	lw	$a0,36($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,44($fp)
	lw	$a1,32($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L96
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L67
$L96:
	lw	$v0,44($fp)
	sw	$v0,60($fp)
$L67:
	lw	$v0,60($fp)
	move	$sp,$fp
	lw	$ra,80($sp)
	lw	$fp,76($sp)
	addu	$sp,$sp,88
	j	$ra
	.end	get_palindromes
	.size	get_palindromes, .-get_palindromes
	.rdata
	.align	2
$LC12:
	.ascii	"\000"
	.text
	.align	2
	.globl	is_palindrome
	.ent	is_palindrome
is_palindrome:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	lw	$a0,72($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	blez	$v0,$L99
	lw	$a0,72($fp)
	la	$a1,$LC12
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L98
$L99:
	sw	$zero,48($fp)
	b	$L97
$L98:
	lw	$v1,24($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L100
	li	$v0,1			# 0x1
	sw	$v0,48($fp)
	b	$L97
$L100:
	sb	$zero,28($fp)
	li	$v0,128			# 0x80
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L102
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC4
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,48($fp)
	b	$L97
$L102:
	lw	$a0,36($fp)
	move	$a1,$zero
	lw	$a2,32($fp)
	la	$t9,memset
	jal	$ra,$t9
	sw	$zero,40($fp)
$L103:
	lw	$v0,40($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L106
	b	$L104
$L106:
	lw	$v1,40($fp)
	lw	$v0,32($fp)
	bne	$v1,$v0,$L107
	lw	$v0,32($fp)
	addu	$v0,$v0,32
	sw	$v0,32($fp)
	lw	$a0,36($fp)
	move	$a1,$v0
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L107
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC5
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,48($fp)
	b	$L97
$L107:
	lw	$v1,36($fp)
	lw	$v0,40($fp)
	addu	$a0,$v1,$v0
	lw	$v1,72($fp)
	lw	$v0,40($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$v0,$v0,2
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	b	$L103
$L104:
	lw	$v1,36($fp)
	lw	$v0,40($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$a0,32($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L109
	la	$t9,__errno
	jal	$ra,$t9
	lw	$a0,0($v0)
	la	$t9,strerror
	jal	$ra,$t9
	la	$a0,$LC3
	la	$a1,$LC4
	move	$a2,$v0
	la	$t9,printf
	jal	$ra,$t9
	lw	$a0,36($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,48($fp)
	b	$L97
$L109:
	lw	$a0,44($fp)
	lw	$a1,36($fp)
	la	$t9,strcpy
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,strrev
	jal	$ra,$t9
	lw	$a0,36($fp)
	lw	$a1,44($fp)
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L110
	li	$v0,1			# 0x1
	sb	$v0,28($fp)
$L110:
	lw	$a0,36($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,free
	jal	$ra,$t9
	lbu	$v0,28($fp)
	sw	$v0,48($fp)
$L97:
	lw	$v0,48($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	is_palindrome
	.size	is_palindrome, .-is_palindrome
	.rdata
	.align	2
$LC13:
	.ascii	"help\000"
	.align	2
$LC14:
	.ascii	"version\000"
	.align	2
$LC15:
	.ascii	"input\000"
	.align	2
$LC16:
	.ascii	"output\000"
	.data
	.align	2
	.type	long_options.0, @object
	.size	long_options.0, 80
long_options.0:
	.word	$LC13
	.word	0
	.word	0
	.word	104
	.word	$LC14
	.word	0
	.word	0
	.word	118
	.word	$LC15
	.word	1
	.word	0
	.word	105
	.word	$LC16
	.word	1
	.word	0
	.word	111
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC17:
	.ascii	"hvc:i:o:\000"
	.align	2
$LC18:
	.ascii	"option %s\000"
	.align	2
$LC19:
	.ascii	" with arg %s\000"
	.align	2
$LC20:
	.ascii	"non-option ARGV-elements: \000"
	.align	2
$LC21:
	.ascii	"%s \000"
	.text
	.align	2
	.globl	process_params
	.ent	process_params
process_params:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 24
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$a2,72($fp)
	sw	$a3,76($fp)
$L112:
	sw	$zero,36($fp)
	addu	$v0,$fp,36
	sw	$v0,16($sp)
	lw	$a0,64($fp)
	lw	$a1,68($fp)
	la	$a2,$LC17
	la	$a3,long_options.0
	la	$t9,getopt_long
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L115
	b	$L113
$L115:
	lw	$v0,32($fp)
	sw	$v0,44($fp)
	li	$v0,105			# 0x69
	lw	$v1,44($fp)
	beq	$v1,$v0,$L122
	lw	$v1,44($fp)
	slt	$v0,$v1,106
	beq	$v0,$zero,$L128
	li	$v0,63			# 0x3f
	lw	$v1,44($fp)
	beq	$v1,$v0,$L125
	lw	$v1,44($fp)
	slt	$v0,$v1,64
	beq	$v0,$zero,$L129
	lw	$v0,44($fp)
	beq	$v0,$zero,$L117
	li	$v0,58			# 0x3a
	lw	$v1,44($fp)
	beq	$v1,$v0,$L124
	b	$L126
$L129:
	li	$v0,104			# 0x68
	lw	$v1,44($fp)
	beq	$v1,$v0,$L120
	b	$L126
$L128:
	li	$v0,111			# 0x6f
	lw	$v1,44($fp)
	beq	$v1,$v0,$L123
	li	$v0,118			# 0x76
	lw	$v1,44($fp)
	beq	$v1,$v0,$L121
	b	$L126
$L117:
	lw	$v0,36($fp)
	sll	$v1,$v0,4
	la	$v0,long_options.0+8
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	beq	$v0,$zero,$L118
	b	$L112
$L118:
	lw	$v0,36($fp)
	sll	$v1,$v0,4
	la	$v0,long_options.0
	addu	$v0,$v1,$v0
	la	$a0,$LC18
	lw	$a1,0($v0)
	la	$t9,printf
	jal	$ra,$t9
	lw	$v0,optarg
	beq	$v0,$zero,$L119
	la	$a0,$LC19
	lw	$a1,optarg
	la	$t9,printf
	jal	$ra,$t9
$L119:
	la	$a0,$LC2
	la	$t9,printf
	jal	$ra,$t9
	b	$L112
$L120:
	la	$t9,print_help
	jal	$ra,$t9
	li	$v0,8			# 0x8
	sw	$v0,40($fp)
	b	$L111
$L121:
	la	$t9,print_version
	jal	$ra,$t9
	li	$v1,8			# 0x8
	sw	$v1,40($fp)
	b	$L111
$L122:
	lw	$v1,72($fp)
	lw	$v0,optarg
	sw	$v0,0($v1)
	b	$L112
$L123:
	lw	$v1,76($fp)
	lw	$v0,optarg
	sw	$v0,0($v1)
	b	$L112
$L124:
	li	$v0,4			# 0x4
	sw	$v0,40($fp)
	b	$L111
$L125:
	li	$v1,4			# 0x4
	sw	$v1,40($fp)
	b	$L111
$L126:
	li	$v0,4			# 0x4
	sw	$v0,40($fp)
	b	$L111
$L113:
	lw	$v0,optind
	lw	$v1,64($fp)
	slt	$v0,$v0,$v1
	beq	$v0,$zero,$L130
	la	$a0,$LC20
	la	$t9,printf
	jal	$ra,$t9
$L131:
	lw	$v0,optind
	lw	$v1,64($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L133
	b	$L132
$L133:
	la	$a1,optind
	lw	$v1,0($a1)
	move	$v0,$v1
	sll	$a0,$v0,2
	lw	$v0,68($fp)
	addu	$v0,$a0,$v0
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	la	$a0,$LC21
	lw	$a1,0($v0)
	la	$t9,printf
	jal	$ra,$t9
	b	$L131
$L132:
	li	$a0,10			# 0xa
	la	$a1,__sF+88
	la	$t9,__sputc
	jal	$ra,$t9
$L130:
	sw	$zero,40($fp)
$L111:
	lw	$v0,40($fp)
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	process_params
	.size	process_params, .-process_params
	.rdata
	.align	2
$LC22:
	.ascii	"Usage:\n"
	.ascii	"   \ttp0 -h\n"
	.ascii	"   \ttp0 -v\n"
	.ascii	"   \ttp0 [options]\n"
	.ascii	"Options:\n"
	.ascii	"   \t-v, --version    \tPrint version and quit.\n"
	.ascii	"   \t-h, --help       \tPrint help and quit.\n"
	.ascii	"   \t-i, --input      \tPath to input file.\n"
	.ascii	"   \t-o, --output     \tPath to output file.\n"
	.ascii	"Examples:\n"
	.ascii	"   \ttp0 -i ~/input -o ~/output\n\000"
	.text
	.align	2
	.globl	print_help
	.ent	print_help
print_help:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC22
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	print_help
	.size	print_help, .-print_help
	.rdata
	.align	2
$LC23:
	.ascii	"tp0 [Guerrero - Schapira - De Rosa] v0.8\n\000"
	.text
	.align	2
	.globl	print_version
	.ent	print_version
print_version:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC23
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	print_version
	.size	print_version, .-print_version
	.align	2
	.ent	__sputc
__sputc:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v1,52($fp)
	lw	$v0,52($fp)
	lw	$v0,8($v0)
	addu	$v0,$v0,-1
	sw	$v0,8($v1)
	bgez	$v0,$L3
	lw	$v0,52($fp)
	lw	$v1,52($fp)
	lw	$a0,8($v0)
	lw	$v0,24($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,$L2
	lb	$v1,48($fp)
	li	$v0,10			# 0xa
	bne	$v1,$v0,$L3
	b	$L2
$L3:
	lw	$a1,52($fp)
	lw	$v1,0($a1)
	lbu	$a0,48($fp)
	move	$v0,$v1
	sb	$a0,0($v0)
	andi	$v0,$a0,0x00ff
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	sw	$v0,24($fp)
	b	$L1
$L2:
	lw	$a0,48($fp)
	lw	$a1,52($fp)
	la	$t9,__swbuf
	jal	$ra,$t9
	sw	$v0,24($fp)
$L1:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	__sputc
	.size	__sputc, .-__sputc
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
