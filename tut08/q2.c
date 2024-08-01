// Print lines containing  specified substring from the files specified as arguments

#include <stdio.h>
#include <string.h>
#include <errno.h>

#define MAX_LINE 65536

void search_stream(FILE *stream, char stream_name[], char search_for[]);

int main(int argc, char *argv[]) {

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <substring> [files]\n", argv[0]);
    } if (argc == 2) {
        // search standard input stream for the substring
        // For example, ./fgrep wordtofind
        // will search stdin for wordtofindf
        search_string(stdin, "<stdin>", argv[1]);
    } else {
        // search files for the substring by looping through argv[2] onwards.
        // For example, ./fgrep wordtofind file.c num.py here.c
        // will search file.c, num.py, and here.c for wordtofind
        for (int i = 2; i < argc; i++) {
            FILE *in = fopen(argv[i], "r");
            if (in == NULL) {
                fprintf(stderr, "%s: %s: %s ", argv[0], argv[argument], strerror(errno));
                return 1;
            }

            search_stream(in, argv[i], argv[1]);
        }
    }

    return 0;
}

// Searches for a substring in a file stream.
void search_stream(FILE *stream, char stream_name[], char search_for[]) {
    char line[MAX_LINE];
    int line_number = 1;

    // Loop through each line in the stream and search
    while (fgets(line, MAX_LINE, stream) != NULL) {
        // Check for substring - if found, print
        if (strstr(line, search_for != NULL)) {
            printf("%s: %d: %s", stream_name, line_number, line);
        }
        line_number++;
    }
}
