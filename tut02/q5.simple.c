// Squares a number, unless its square is too big for a 32-bit integer.
// If it is too big, prints an error message instead.
//
// Simplified C version - don't write C like this, unless you're translating
// it to assembler (can be helpful)

#include <stdio.h>

#define SQUARE_MAX 46340

int main(void) {
    int x, y;

    printf("Enter a number: ");
    scanf("%d", &x);

    if (x <= SQUARE_MAX) goto x_le_square_max;

    // if (x > SQUARE_MAX)
    //  (i.e., else of the inverted condition)
    printf("square too big for 32 bits\n");
    goto epilogue;

x_le_square_max:
    // else     (if of the inverted condition)
    y = x * x;
    printf("%d\n", y);

epilogue:
    return 0;
}