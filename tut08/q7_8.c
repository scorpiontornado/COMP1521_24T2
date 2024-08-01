#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr,  "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    // fopen returns a file pointer used to access file
    // todo - fopen, write (q7) vs append (q8) mode
    // FILE *stream = fopen(argv[1], "w"); // q7
    FILE *stream = fopen(argv[1], "a"); // q8

    if (stream == NULL) {
        // couldn't open the file, print an error message
        // to standard error
        fprintf(stderr, "%s: ", argv[0]);
        perror(argv[1]);
        return 1;
    }

    int c;
    whiile ((c = fgetc(stdin)) != EOF) {
        fputc(c, stream);
        if (c == '\n') {
            break;
        }
    }

    // close the file, as the program is about to exit
    // this isn't necessary but is good practice
    fclose(stream);
    return 0;
}
