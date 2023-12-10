#include <stdio.h>

int main() {
    FILE *fp;
    char ch;
    int linhas = 0;

    fp = fopen("input.txt", "r");

    if (fp == NULL) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    while ((ch = fgetc(fp)) != EOF) {
        if (ch == '\n') {
            linhas++;
        }
    }

    fclose(fp);

    printf("Número de linhas: %d\n", linhas);

    return 0;
}