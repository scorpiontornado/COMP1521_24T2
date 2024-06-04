# Squares a number, unless it is too big for a 32-bit register.
# If it is too big, prints an error message instead.

# Constant (substitution macro) - like #define
SQUARE_MAX = 46340

main:
	# Locals:
        #   - $t0: int x, The number to square.
        #   - $t1: int y, The result of the square.

	li $v0, 4			# printf("Enter a number: ");
	la $a0, prompt
	syscall

	li	$v0, 5			# scanf("%d, x);
	syscall
	move	$t0, $v0 # x = 5

	ble	$t0, SQUARE_MAX, x_le_square_max	# if (x <= SQUARE_MAX) goto x_le_square_max;

	li	$v0, 4			# printf("square too big for 32 bits\n");
	la	$a0, too_big
	syscall

	j	epilogue

x_le_square_max:
	mul 	$t1, $t0, $t0		# y = x * x
					# Shortcut: mul $t1, $t0

	li	$v0, 1			# printf("%d", y);
	move 	$a0, $t1
	syscall

	li 	$v0, 11			# printf("%c", '\n');
	li	$a0, '\n'
	syscall

epilogue:
	li	$v0, 0			# return 0;
	jr	$ra

	.data
prompt:
	.asciiz	"Enter a number: "
too_big:
	.asciiz "square too big for 32 bits\n"
