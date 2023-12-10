#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

typedef struct
{
    int age;
    double height;
    char name[64];
} Person;

void printPersonInfo(Person *p)
{
    printf("Person: %s, %d, %f\n", p->name, p->age, p->height);
}

int main(int argc, char *argv[])
{
    FILE *fp = NULL;
    int i, n;
    Person p;

    // pergunta o numero de pessoas para gravar ao utilizador
    printf("Number of people to save: \n");
    scanf("%d", &n);

    /* Validate number of arguments */
    if (argc != 2)
    {
        printf("USAGE: %s fileName\n", argv[0]);
        return EXIT_FAILURE;
    }

    /* Open the file provided as argument */
    errno = 0;
    fp = fopen(argv[1], "wb");
    if (fp == NULL)
    {
        perror("Error opening file!");
        return EXIT_FAILURE;
    }

    // escreve as pessoas inseridas em n
    for (i = 0; i < n; i++)
    {
        printf("Insira a pessoa %d\n", i + 1);
        printf("Age: \n");
        scanf("%d", &p.age);
        printf("Heigh: \n");
        scanf("%lf", &p.height);
        printf("Name: \n");
        scanf(" %63[^\n]", p.name);

        fwrite(&p, sizeof(Person), 1, fp);
    }

    fclose(fp);

    return EXIT_SUCCESS;
}