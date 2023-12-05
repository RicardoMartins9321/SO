#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
    int i;
    char str[1000];
    for (i = 1; i < argc; i++)
    {
        if (i > 1)
        {
            if (isalpha(argv[i][0]) != 0)
            {
                strcat(str, " ");
                strcat(str, argv[i]);
            }
        }
        else 
        {
            strcat(str, argv[i]);
        }
    }
    printf("String: %s\n", str);
    return EXIT_SUCCESS;
}