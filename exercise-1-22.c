/*
 * My algorithm to fold lines as specified by the given fold width.
 * Create a character array (buffer) of the required fold width + 1 (for the null char)
 * Set rem = 0
 * While EOF is not yet reached.
 *      Read upto a newline or fold width - rem characters, whichever is smaller into the buffer
 *      If the number of characters read are less than fold width
 *          Print buffer
 *      Else
 *          Find the index of the last space, hyphen or tab from the buffer.
 *          If no such position was found
 *              Set index to fold width - 1
 *
 *          Print buffer until this index (not inclusive)
 *          Print a newline
 *
 *          Set rem to the number of remaining characters.
 *          Print remaining characters of the buffer.
 *  ^^^
 *  For some reason, the above algorithm does not work correctly.
 */
#include<stdio.h>
#define FOLD_WIDTH 80

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    while(bufferIndex < (bufferSize-1))
    {
        ch = getchar();
        if(ch == EOF) break;
        buffer[bufferIndex] = ch;
        bufferIndex++;
        if(ch == '\n') break;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}

int main()
{
    char buffer[FOLD_WIDTH + 1] = {'\0'};
    int length, i, j, rem_char = 0;
    while((length = getline(buffer, (FOLD_WIDTH + 1 - rem_char))))
    {
        /** if(length < FOLD_WIDTH)
          * {
          *     printf("%s", buffer);
          * }
          * else
          * { */
        // Find the position of the last space, tab or hyphen.
        i = -1;
        for(i = (length-1); i >=0; i--)
        {
            if(buffer[i] == ' ' || buffer[i] == '\t' || buffer[i] == '-')
                break;
        }
        if(i == -1)
            i = FOLD_WIDTH - 1;
        // printf("(%d)<%d>[%s]\n", length, i, buffer);
        for(j = 0; j < i; j++)
            putchar(buffer[j]);
        putchar('\n');
        for(j = i+1; j < FOLD_WIDTH; j++)
            putchar(buffer[j]);
        rem_char = FOLD_WIDTH - 1 - i;
        /** } */
    }
}
