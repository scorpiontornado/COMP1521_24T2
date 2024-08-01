# This program prints out a danish flag, by
# looping through the rows and columns of the flag.
# Each element inside the flag is a single character.
# (i.e., 1 byte).
#
# (Dette program udskriver et dansk flag, ved at
# sløjfe gennem rækker og kolonner i flaget.)
#

# Constants
FLAG_ROWS = 6
FLAG_COLS = 12

# Registers:
# - row in $t0
# - col in $t1
# - row offset in $t2
# - row+col offset in $t3
main:
	row_loop__init:
		li	$t0, 0
	row_loop__cond:
		bge	$t0, FLAG_ROWS, row_loop__end
	row_loop__body:
		col_loop__init:
			li	$t1, 0
		col_loop__cond:
			bge	$t1, FLAG_COLS, col_loop__end
		col_loop__body:
			mul	$t2, $t0, FLAG_COLS	# offset = (row * NUM_COLS
			add	$t2, $t1		# 	    + col) * size(element)
			# add	$t3, $t2, flag		# &(flag[row][col])
			# lb	$v0, ($t3)		# $v0 = flag[row][col]

			lb	$a0, flag($t2)		# $v0 = *(flag + offset)
			li	$v0, 11			# printf("%c", flag[row][col])
			syscall
		col_loop__step:
			addi	$t1, 1		# col += 1
			j	col_loop__cond
		col_loop__end:

		li	$v0, 11
		li	$a0, '\n'
		syscall
	row_loop__step:
		addi	$t0, 1		# row += 1
		j	row_loop__cond
	row_loop__end:

	li	$v0, 0
	jr 	$ra

.data
# This label inside the data region refers to the bytes of the flag.
# Note that even thought the bytes are listed on separate lines,
# they are actually stored as a single contiguous chunk or 'string' in memory.
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'