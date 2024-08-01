// Wk 9 Q4 - chmod_if_public_write.c
// remove public write from specified as command line arguments if needed

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

void chmod_if_needed(char *pathname);

int main(int argc, char *argv[]) {
    for (int arg = 1; arg < argc; arg++) {
        chmod_if_needed(argv[arg]);
    }
    return 0;
}

// chmod a file if publically-writeable

void chmod_if_needed(char *pathname) {
    struct stat s;
    int output = stat(pathname, &s);
    if (output != 0) { // 0 = success, non-zero = failure (see man 2 stat)
        perror(pathname);
        exit(1);
    }
    // struct stat s should now be filled with data (see man 7 inode)

    mode_t mode = s.st_mode;

    // Mode: 32 bit integer. Last 9 bits of the mode represent permissions.
    // Ie. 101 000 011 AT THE END is r-x --- -wx
    // S_IWOTH is a hash define for write public flag, 00002 (octal) = 0b000 000 010
    //      (see man 7 inode & stat.h)
    // Recall: & used to extract 1 bits
    //      (vs | used to set bits to 1, ~ used to flip all bits,
    //      ^ used to flip particular bits, a & (~b) used to set bits to 0)
    if (!(mode & S_IWOTH)) {
        printf("%s is not publically writable\n", pathname);
        return;
    }
    // EXAMPLE, only considering last 9 permission bits.
    // SI_IWOTH =       0b000000010     (i.e., 00002, where leading 0 means octal)
    // mode =           0b010101010     (This is currently publicly writeable)
    // S_IWOTH & mode = 0b000000010     (THIS IS NOT ZERO, i.e. "truthy")

    // However, if mode = 0b010101000   (This is not public writeable)
    // S_IWOTH & mode = 0               ("falsy")

    printf("removing public write from %s\n", pathname);

    mode_t new_mode = mode & ~S_IWOTH; // Removing the write public flag
    // EXAMPLE
    // SI_IWOTH = 0b0000000010
    // mode =     0b0010101010 (This is currently public writeable)
    // ~S_IWOTH = 0b1111111101
    // mode & ~S_IWOTH = 0b0010101000 (REMOVED PUBLIC WRITE FLAG.)

    // Change the mode (set perms) & check if successful
    if (chmod(pathname, new_mode) != 0) {
        perror(pathname);
        exit(EXIT_FAILURE);
    }
}