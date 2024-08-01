# Find the largest element in an array, recursively.

max:
	# Args:
	#    - $a0: int array[] (note - this is different to the global, `array`)
	#    - $a1: int length
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$ra, $s0, $v0, $a0, $a1, $t0]
	# Clobbers: [$v0, $a0, $a1, $t0]
	#
	# Locals:
	#   - $s0: int first_element
	#   - $t0: int max_so_far
	#
	# Structure:
	#   play_tick
	#   -> [prologue]
	#       -> body
	#           -> max__base_case
	#           -> max__length_gt_1
	#           -> max__ret_max_so_far
	#   -> [epilogue]
max__prologue:
	begin
	push	$ra
	push	$s0

max__body:
	# lw	$s0, array	#! NOTE: this is wrong, we want to add onto the
				# address we were passed in through $a0, not the
				# global called array

	lw	$s0, ($a0)

	bne	$a1, 1, max__len_ne_1

	move 	$v0, $s0
	j	max__epilogue	# return first_element;

max__len_ne_1:
	# li	$a0, array	#! (same as above)

	addi	$a0, $a0, 4	# &array[1], i.e. array + (1 * sizeof(int))

	addi	$a1, $a1, -1	# length - 1

	jal	max		# max(&array[1], length - 1);
	move	$t0, $v0

	ble	$s0, $t0, max__first_smaller
	move	$t0, $s0

max__first_smaller:
	move	$v0, $t0	# return max_so_far

max__epilogue:
	pop	$s0
	pop	$ra
	end

	jr	$ra			# return; ($v0 will differ based on what we're returning)

	# Simple test code that calls max
main:
main__prologue:
	push	$ra

main__body:
	la	$a0, array
	li	$a1, 10
	jal	max			# result = max(array, 10)

	move	$a0, $v0
	li	$v0, 1			# syscall 1: print_int
	syscall				# printf("%d", result)

	li	$a0, '\n'
	li	$v0, 11			# syscall 11: print_char
	syscall				# printf("%c", '\n');

	li	$v0, 0

main__epilogue:
	pop	$ra
	jr	$ra			# return 0;

	.data
array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1