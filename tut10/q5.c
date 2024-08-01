#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>
#include <errno.h>


void *thread_run(void *data) {
	// todo
    char *string = data;
    while (true) {
        printf("%s", string);
    }
    return NULL;
}

int main(void) {
    char *thread_message = "Hello\n";

    // todo
    pthread_t thread;
    pthread_create(&thread, NULL, thread_run, thread_message);

    while (true) {
        printf("there!\n");
    }

    // todo: Stop the process exiting until the thread is done
    pthread_join(thread, NULL);
}
