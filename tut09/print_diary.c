// print $HOME/.diary to stdout

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *basename = ".diary";

int main(int argc, char *argv[]) {
    // Write a C program, print_diary.c, which prints the
    // contents of the file $HOME/.diary to stdout
    //  The lecture example getstatus.c shows how to get the
    // value of an environment variable.

    char *home_pathname = getenv("HOME");

    if (home_pathname == NULL) {
        home_pathname = ".";
    }

    // "$HOME/.diary", i.e. home_pathname / basename
    // +1 for '/', +1 for null terminator '\0'
    int diary_pathname_len = strlen(home_pathname) + strlen(basename) + 2;
    char *diary_pathname = malloc(diary_pathname_len);

    snprintf(diary_pathname, diary_pathname_len, "%s/%s", home_pathname, basename);

    FILE *stream = fopen(diary_pathname, "r");
    if (stream == NULL) {
        perror(diary_pathname);
        exit(EXIT_FAILURE);
    }

    // Could instead do letter = fgetc(stream) before the loop & again at the end, after putchar
    int letter;
    while ((letter = fgetc(stream)) != EOF) {
        // printf("%c", letter);
        // fputc(letter, stdout);
        putchar(letter);
    }

    free(diary_pathname);
    fclose(stream);

    return 0;
}