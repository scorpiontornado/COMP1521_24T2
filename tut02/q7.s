# Prints every 3rd number from 24 to 42

# NOTE: loop_init, body, and step are redundant but can be helpful to remind you
#   (just remember there are 5 parts, then write the labels first - reduces cognitive load)
# At the least, I'd probably have init, cond, and end.
# Step too if there's an if statement at the end of the body

main:
	# Locals:
	#   - $t0: int i, loop counter

loop_init:
	li	$t0, 24			# i = 24;

loop_cond:
	bge	$t0, 42, loop_end	# while (i < 42) {

loop_body:
	li	$v0, 1			#   printf("%d", i);
	move 	$a0, $t0
	syscall

	li 	$v0, 11			#   printf("%c", '\n');
	li	$a0, '\n'
	syscall

loop_step:
	addi	$t0, $t0, 3		#   i = i + 3;
	j	loop_cond

loop_end:				# }
	li	$v0, 0
	jr 	$ra			# return 0;
