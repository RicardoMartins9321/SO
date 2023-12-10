#include <stdio.h>
#include <string.h>

void concatenarStrings(char *str1, char *str2) {
    strcat(str1, str2);
}

int main() {
    char str1[50] = "Hello";
    char str2[] = " World!";
    
    concatenarStrings(str1, str2);
    printf("Resultado: %s\n", str1);

    return 0;
}