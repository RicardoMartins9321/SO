#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

void listDir(char dirname[])
{
    DIR *dp; 
    struct dirent *dent;

    dp = opendir(dirname); 
    if(dp == NULL)
    {
        perror("Error opening directory");
        return;
    }

    dent = readdir(dp);
    while(dent!=NULL) 
    {
        if(dent->d_name[0] != '.') /* do not list hidden dirs/files */
        {
            struct stat st;
            char path[256];
            sprintf(path, "%s/%s", dirname, dent->d_name);
            if (stat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
                printf("d %s/%s\n", dirname, dent->d_name);
                // Recursively list the subdirectory
                listDir(path);
            } else {
                printf("  %s/%s\n", dirname, dent->d_name);
            }
        }

        dent = readdir(dp);
    }

    closedir(dp);
}

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        fprintf(stderr,"Usage: %s base_directory\n",argv[0]);
        return EXIT_FAILURE;
    }

    listDir(argv[1]);
    
    return EXIT_SUCCESS;
}


