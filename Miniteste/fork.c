#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid;

    pid = fork();

    if (pid == 0) {
        // Código do processo filho
        execlp("/bin/ls", "ls", NULL);
    } else if (pid > 0) {
        // Código do processo pai
        wait(NULL);
        printf("Processo filho concluído.\n");
    } else {
        perror("Erro ao criar processo filho");
        return 1;
    }

    return 0;
}