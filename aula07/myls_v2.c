#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
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
    int c;
    int option_index = 0;
    const char *ext = NULL;
    int list_files = 0;
    int list_dirs = 0;

    struct option long_options[] = {
        {"file", no_argument, 0, 'f'},
        {"dir", no_argument, 0, 'd'},
        {"ext", required_argument, 0, 'e'},
        {0, 0, 0, 0}
    };

    while ((c = getopt_long(argc, argv, "fde:", long_options, &option_index)) != -1) {
        switch (c) {
            case 'f':
                list_files = 1;
                break;
            case 'd':
                list_dirs = 1;
                break;
            case 'e':
                ext = optarg;
                break;
            case '?':
                break;
            default:
                printf("Unknown option\n");
                break;
        }
    }

    if (!list_files && !list_dirs) {
        list_files = 1; // List files by default if no option is provided
    }

    for (int i = optind; i < argc; i++) {
        if (list_files) {
            listFiles(argv[i], ext);
        }
        if (list_dirs) {
            listDirs(argv[i]);
        }
    }

    return EXIT_SUCCESS;
}