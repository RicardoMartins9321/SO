#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

int main(int argc, char *argv[]){
    int i;
    char *x;
    x = getenv("SORTORDER");
    if(x == NULL){
        for(i = 1; i < argc; i++){
            if(isalpha(argv[i][0])){
                printf("%s ", argv[i]);
            } 
        }
        printf("\n");
    } else if(strcmp(x, "asc") == 0){
        for(i = 1; i < argc; i++){
            if(isalpha(argv[i][0])){
               for (int i = 1; i<argc; i++){
                    for (int j = i + 1; j<argc; j++){  //i = 1 j = 2 j = 3 
                        if (strcasecmp(argv[i], argv[j]) > 0){
                            x = argv[j];
                            argv[j] = argv[i];
                            argv[i] = x;
                        }
                    }       
                }    
            } 
        }
        for (int i = 0; i < argc; i++){
         if(isalpha(argv[i][0])){
             printf("%s ", argv[i]);
         }
    }
        printf("\n");
    } else if(strcmp(x, "desc") == 0){
        for(i = argc - 1; i > 0; i--){
            if(isalpha(argv[i][0])){
               for (int i = 1; i<argc; i++){
                    for (int j = i + 1; j<argc; j++){
                        if (strcasecmp(argv[i], argv[j]) < 0){
                            x = argv[j];
                            argv[j] = argv[i];
                            argv[i] = x;
                        }
                    }       
                }    
            } 
        }     
        for (int i = 0; i < argc; i++){
            if(isalpha(argv[i][0])){
             printf("%s ", argv[i]);
            }
        }
    printf ("\n");
    } else {
        printf("Invalid SORTORDER! \n");
        return EXIT_FAILURE;
    }

    printf ("\n");
    return 0;

}