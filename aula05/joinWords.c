#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    int i;
    char newString[100];

    if(argc<=1) {
    	printf("Algo deu errado!!");
		return EXIT_FAILURE;
	}

    for(i = 1 ; i < argc ; i++)
    {
		strcat(newString,argv[i]);
    }

    printf("New String: %s\n", newString);

    return EXIT_SUCCESS;
}
