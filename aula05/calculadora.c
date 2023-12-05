#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main(int argc, char *argv[])
{

	if (argc!=4) {
		printf("Deve fornecer 3 argumentos(n1 op n2)\n");
		return EXIT_FAILURE;
	}
	float n1 = atof(argv[1]);
	float n2 = atof(argv[3]);
	char* op = argv[2];
	
	if (strcmp(op,"+") == 0) {
		printf("%.3f\n",n1+n2);
	}else if (strcmp(op,"-") == 0) {
		printf("%.3f\n",n1-n2);
	}else if (strcmp(op,"x") == 0) {
		printf("%.3f\n",n1*n2);
	}else if (strcmp(op,"/") == 0) {
		printf("%.3f\n",n1/n2);
	}else if(strcmp(op,"p") == 0) {
		printf("%.3f\n",pow(n1,n2));
	}else {
		printf("Ops, algo correu mal!");
	}

    return EXIT_SUCCESS;
}
