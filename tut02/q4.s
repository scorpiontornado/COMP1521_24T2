# Prints the square of a number

	.text
main:
	# Locals:
	#   - $t0: int x
	#   - $t1: int y

	li	$v0, 4		# $v0 = 4 (syscall number for print string)
	la	$a0, prompt	# $a0 = prompt (address of string)
	syscall			# printf("Enter a number: ");

	li	$v0, 5		# scanf("%d", &x);
	syscall
	move	$t0, $v0

	mul	$t1, $t0, $t0	# y = x * x

	li	$v0, 1		# printf("%d", y);
	move 	$a0, $t1
	syscall

	li 	$v0, 11		# printf("%c", '\n');
	li	$a0, '\n'	# (note - have to break up print,
	syscall			# different type)

	li	$v0, 0
	jr	$ra		# return 0;

	.data
prompt:
	.asciiz	"Enter a number: "
