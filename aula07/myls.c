#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>

void listFiles(char dirname[], const char *ext) {
    DIR *dp;
    struct dirent *dent;

    dp = opendir(dirname);
    if (dp == NULL) {
        perror("Error opening directory");
        return;
    }

    dent = readdir(dp);
    while (dent != NULL) {
        if (dent->d_name[0] != '.') {
            struct stat st;
            char path[256];
            sprintf(path, "%s/%s", dirname, dent->d_name);
            if (stat(path, &st) == 0) {
                if (S_ISREG(st.st_mode)) {
                    if (ext == NULL || strstr(dent->d_name, ext) != NULL) {
                        printf("%s/%s\n", dirname, dent->d_name);
                    }
                }
            }
        }
        dent = readdir(dp);
    }

    closedir(dp);
}

void listDirs(char dirname[]) {
    DIR *dp;
    struct dirent *dent;

    dp = opendir(dirname);
    if (dp == NULL) {
        perror("Error opening directory");
        return;
    }

    dent = readdir(dp);
    while (dent != NULL) {
        if (dent->d_name[0] != '.') {
            struct stat st;
            char path[256];
            sprintf(path, "%s/%s", dirname, dent->d_name);
            if (stat(path, &st) == 0) {
                if (S_ISDIR(st.st_mode)) {
                    printf("%s/%s\n", dirname, dent->d_name);
                }
            }
        }
        dent = readdir(dp);
    }

    closedir(dp);
}

int main(int argc, char *argv[]) {
    int list_files = 0;
    int list_dirs = 0;
    const char *ext = NULL;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-f") == 0) {
            list_files = 1;
        } else if (strcmp(argv[i], "-d") == 0) {
            list_dirs = 1;
        } else if (strcmp(argv[i], "-e") == 0 && i + 1 < argc) {
            ext = argv[i + 1];
            i++;
        }
    }

    if (!list_files && !list_dirs) {
        list_files = 1; // List files by default if no option is provided
    }

    for (int i = 1; i < argc; i++) {
        if (argv[i][0] != '-') {
            if (list_files) {
                listFiles(argv[i], ext);
            }
            if (list_dirs) {
                listDirs(argv[i]);
            }
        }
    }

    return EXIT_SUCCESS;
}