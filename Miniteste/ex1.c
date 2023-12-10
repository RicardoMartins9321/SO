#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Ex1
int main(int argc, char **argv) {
    // b)
    char frase[] = "Portugal venceu Espanha";
    printf("Size of the command sizeof: %ld\n", sizeof(frase));
    printf("Size of the command strlen: %ld\n", strlen(frase));

    // c)
    FILE *fp;
    char ch;
    int linhas = 0;

    fp = fopen("input.txt", "r");

    if (fp == NULL) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    char linha[5]; int count=0;
    while (fgets(linha, sizeof(linha), fp) != NULL) {
        printf("\n%s", linha);
        count++;
    }
    printf("\nNúmero de linhas: %d\n", count);

    // d)
    printf("Size of the command strlen(frase+2): %ld\n", strlen(frase+2));
    printf("Size of the command strlen(frase) + 2: %ld\n", strlen(frase)+2);

    // e)
    int m[3]; int *a=m; int *b=m+1; int *c=m+2;
    // trocar os conteudos da primeira e ultima posição
    printf("a: %d\n", *a);  // 257
    printf("b: %d\n", *b);  // 2
    printf("c: %d\n", *c);  // 0

    *b=*c; *c=*a; *a=*b;
    printf("a: %d\n", *a);  // 0
    printf("b: %d\n", *b);  // 0
    printf("c: %d\n", *c);  // 257

    // f)
    // opção 4, semáforos, filas de mensagens e memória partilhada

    // g)
    // opção 4, int MemAttach (int id, void **pt);

    // h) executa 2 duplicações de processos. 4 processos totais
    printf("%s", fork());
    printf("%s", fork());
}