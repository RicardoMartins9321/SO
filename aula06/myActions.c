#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(int argc, char *argv[])
{
    char text[1024];
    FILE *file;
    time_t current_time;
    struct tm *time_info;
    char time_string[20];

    do
    {
        printf("Command: ");
        scanf("%1023[^\n]%*c", text);

        if (strcmp(text, "end") != 0)
        {
            printf("\n * Command to be executed: %s\n", text);
            printf("---------------------------------\n");
            system(text);
            printf("---------------------------------\n");

            // Open the file in append mode
            file = fopen("command.log", "a");
            if (file == NULL)
            {
                printf("Error opening file\n");
                return EXIT_FAILURE;
            }

            // Get the current time
            current_time = time(NULL);
            time_info = localtime(&current_time);

            // Format the time string
            strftime(time_string, sizeof(time_string), "%Y-%m-%d %H:%M:%S", time_info);

            // Write the command and timestamp to the file
            fprintf(file, "Command: %s\nTimestamp: %s\n\n", text, time_string);

            // Close the file
            fclose(file);
        }
    } while (strcmp(text, "end") != 0);

    printf("-----------The End---------------\n");

    return EXIT_SUCCESS;
}

