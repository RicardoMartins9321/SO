#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int contador = 0;

    if (argc == 3)
    {
        int minimo = atoi(argv[1]);
        int maximo = atoi(argv[2]);

        if (minimo < maximo)
        {
            int guess;

            int valor = minimo + rand()%(maximo-minimo);

            printf("Introduza a sua adivinha dentro do intervalo [%d,%d]: ", minimo, maximo);
            scanf("%d", &guess);
            contador++;

            while (guess != valor)
            {
                if (guess < valor) 
                {
                    printf("Tente mais alto\n");
                    contador++;
                    printf("Introduza outro número dentro do mesmo intervalo: ");
                    scanf("%d", &guess);
                    
                }
                else
                {
                    printf("Tente mais baixo\n");
                    contador++;
                    printf("Introduza outro número dentro do mesmo intervalo: ");
                    scanf("%d", &guess);
                }
            }
        }
        else
        {
            printf("ERRO: Introduza um intervalo de números válido.\n");

            return EXIT_FAILURE;
        }
    }
    else
    {
        printf("ERRO: Introduza um intervalo de números válido.\n");

        return EXIT_FAILURE;
    }
    

    printf("Parabéns, acertou o número.\n");
    printf("Precidou de %d tentativas\n", contador);

    return EXIT_SUCCESS;
}