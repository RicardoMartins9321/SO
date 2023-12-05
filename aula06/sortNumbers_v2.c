#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define LINEMAXSIZE 100

int compareInts(const void *px1, const void *px2)
{
    int x1 = *((int *)px1);
    int x2 = *((int *)px2);
    // return -1 if x1 smaller than x2, 0 if equal and 1 if x1 bigger
    return(x1 < x2 ? -1 : x1 == x2 ? 0 : 1);
}

int main(int argc, char *argv[])
{
    int i = 0, numSize = 0;
    int *numbers;
    FILE *fp = NULL;
    char line[LINEMAXSIZE];
    fp = fopen(argv[1], "r");

    if (fp == NULL)
    {
        printf("Cant read the file %s\n", argv[1]);
    }

    while (fgets(line, sizeof(line), fp) != NULL)
    {
        numSize++;
    }
    fclose(fp);
    /* Memory allocation for all the numbers in the arguments */
    numbers = (int *)malloc(sizeof(int) * numSize);

    fp = fopen(argv[1], "r");

    if (fp == NULL)
    {
        printf("Can't read the file %s\n", argv[1]);
    }

    while (fgets(line, sizeof(line), fp) != NULL)
    {
        numbers[i] = atoi(line);
        i++;
    }
    fclose(fp);

    /* void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
         The qsort() function sorts an array with nmemb elements of size size.*/
    qsort(numbers, numSize, sizeof(int), compareInts);

    /* Printing the sorted numbers */
    printf("Sorted numbers: \n");
    for (i = 0; i < numSize; i++)
    {
        printf("%d\n", numbers[i]);
    }

    return EXIT_SUCCESS;
}