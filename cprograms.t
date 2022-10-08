#include <ctype.h>
#include <stdio.h>
#define OUT_NUMBER 0
#define IN_NUMBER 1

int atoi(char s[])
{
    int i, sign = 1, mode = OUT_NUMBER;
    for (i = 0; s[i] != '\0'; i++) {
        if (mode == OUT_NUMBER) {
            if (s[i] == ' ' || s[i] == '+') continue;
            if (s[i] == '-')
                sign = -sign;
            else {
                printf("%s\n", "Bad input");
                return -1;
            }
        }
        if (isdigit(s[i])) {
            mode = IN_NUMBER;
        }
    }
}

int main()
{
    char s[] = "-53212";
    printf("%d", atoi(s));
}
#include<stdio.h>

#define POWER_OFF  0
#define POWER_ON   1 << 1
#define VOLUME_INC 1 << 2
#define VOLUME_DEC 1 << 3
#define LIGHTS_ON  1 << 4
#define LIGHTS_OF  1 << 5
#define FAN_ON     1 << 6
#define FAN_OFF    1 << 7

unsigned char flag = 0;
int main()
{
    flag |= FAN_ON;
    flag |= LIGHTS_ON;
    flag |= VOLUME_DEC;
    printf("%d\n", flag);
}
#include<stdio.h>

void fcopy(FILE *in, FILE *out)
{
    int ch;
    while((ch = getc(in)) != EOF)
        putc(ch, out);
}
int main(int argc, char *argv[])
{
    FILE *fp = NULL;
    // No file names were passed
    if(argc == 1)
        fcopy(stdin, stdout);
    
    for(int i = 1; i < argc; i++)
    {
        if((fp = fopen(argv[i], "r")) == NULL)
        {
            fprintf(stderr, "%s%s\n", "Error: Could not open file:", argv[i]);
        }
        else
        {
            fcopy(fp, stdout);
            fclose(fp);
        }
    }
}#include<stdio.h>

int main(int argc, char *argv[])
{
    for(int i = 1; i < argc; i++)
    {
        printf("%s\n", argv[i]);
    }
}
/* Let us define two functions to do the conversions: day_of_year converts the
 * month and day into the day of the year, and month_day converts the day of the
 * year into the month and day. Since this latter function computes two values,
 * the month and day arguments will be pointers: */

static char daymap[2][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}};

int day_of_year(int year, int month, int day)
{
    // Check if year is valid
    if(year < 0)
        return -1;

    // Check if month is valid
    if(!(month >= 1 && month <= 12))
    {
        return -2;
    }

    // Check if day is valid
    if(!(day >= 1 && day <= 31))
    {
        return -3;
    }
    /*
     * Returns the day of year which corresponds to the day of the given month.
     */
    int leap = ((year % 4 == 0) && year % 100 != 0) || (year % 400 == 0);
    for (int i = 1; i < month; i++) day += daymap[leap][i];
    return day;
}

int month_day(int year, int yearday, int *pmonth, int *pday)
{
    if(pmonth)
        *pmonth = 0;
    if(pday)
        *pday = 0;

    int i, leap;
    leap = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);

    // Check if yearday is valid
    if(!(yearday >= 0 && yearday <= 366) && leap)
    {
        // A leap year
        return -1;
    }
    else if(!(yearday >= 0 && yearday <= 365))
    {
        // Not a leap year
        return -2;
    }

    if(year < 0)
    {
        return -3;
    }

    for (i = 1; yearday > daymap[leap][i]; i++) yearday -= daymap[leap][i];

    if(pmonth)
        *pmonth = i;
    if(pday)
        *pday = yearday;
    return 1;
}
#include <stdio.h>
int main()
{
    int m, d;
    month_day(2022, 400, &m, &d);
    printf("%d\n", day_of_year(2022, 8, 32));
    printf("%d %d\n", m, d );
}
#include <stdio.h>

int main()
{
    int ch;
    while ((ch = getchar()) != EOF) {
        if (ch == '\\') {
            putchar('\\');
            putchar('\\');
        }
        if (ch == '\n') {
            putchar('\\');
            putchar('n');
        }
        if (ch == '\t') {
            putchar('t');
        }
        if (ch == '\b') {
            putchar('\\');
            putchar('b');
        }
        if (ch == ' ') {
            putchar('.');
        }
        else
            putchar(ch);
    }
    return 0;
}
#include <stdio.h>
// To print the input, one word per line,
// Whenever the program encounters a blank, tab or newline, print a newline
// character.
int main()
{
    int ch;
    int lastCharWasSpace = 0;
    while ((ch = getchar()) != EOF) {
        if (ch == ' ' || ch == '\t') {
            lastCharWasSpace = 1;
        }
        else {
            if (lastCharWasSpace) putchar('\n');
            putchar(ch);
            lastCharWasSpace = 0;
        }
    }
}
#define MAX_WORD_SIZE 1000
#define IN_WORD 1
#define OUT_WORD 0
#define HIST_LENGTH 10

#include <stdio.h>
// Program to print the histogram of the length of the words in
// the input.
//
void printHorizontalBar(int length, int ch)
{
    for (int i = 1; i <= length; i++) {
        putchar(ch);
    }
}

int main()
{
    int wordLengths[MAX_WORD_SIZE] = {0};
    int state = OUT_WORD;
    int ch, wordLength = 0;

    while ((ch = getchar()) != EOF) {
        if (ch == '\t' || ch == ' ' || ch == '\n') {
            if (state == IN_WORD) {
                // The previous character was part of a word, the current
                // character is a blank, tab or newline, so we come out of the
                // word. So reset the wordLength variable to 0.
                if (wordLength < MAX_WORD_SIZE) wordLengths[wordLength]++;
                wordLength = 0;
            }
            state = OUT_WORD;
        }
        else {
            state = IN_WORD;
            wordLength++;
        }
    }
    // Finding the minimum and maximum wordlengths to find
    // the scale for the histogram.
    int minWordLength = 0, maxWordLength = 0;
    float scale;
    for (int i = 0; i < MAX_WORD_SIZE; i++) {
        if (wordLengths[i] > maxWordLength) maxWordLength = wordLengths[i];
        if (wordLengths[i] < minWordLength) minWordLength = wordLengths[i];
    }
    // Each mark on the histogram represents the below amount of words.
    scale = ((float)(maxWordLength - minWordLength)) / HIST_LENGTH;
    // printf("(%d,%d,%f)\n", minWordLength, maxWordLength, scale);
    int divisions;
    for (int i = 0; i < MAX_WORD_SIZE; i++) {
        if (wordLengths[i] != 0) {
            divisions = wordLengths[i] / scale;
            // If the word length is less than the chosen scale, atleast print
            // one mark in the histogram.
            // For example number of words with length two is 3 and the scale is
            // 4 then division results in 0.
            printf("%d:", i);
            printHorizontalBar((divisions == 0) ? 1 : divisions, '*');
            printf("(%d)\n", wordLengths[i]);
        }
    }
    /*
    for(int i = 0; i < MAX_WORD_SIZE; i++){
        if(wordLengths[i] != 0){
            printf("%-5d%5d\n", i, wordLengths[i]);
        }
    }
    */
}
// Max range of characters for ascii
#define MAX_CHAR_RANGE 256
#include <stdio.h>
int main()
{
    int frequencies[MAX_CHAR_RANGE] = {0};
    int outOfRanges = 0;
    int ch;

    while ((ch = getchar()) != EOF) {
        if (ch < MAX_CHAR_RANGE)
            frequencies[ch]++;
        else
            outOfRanges++;
    }

    for (int i = 0; i < MAX_CHAR_RANGE; i++) {
        if (frequencies[i] > 0) {
            switch (i) {
                case ' ':
                    printf("%-8s", "BLNK");
                    break;
                case '\n':
                    printf("%-8s", "\\n");
                    break;
                case '\t':
                    printf("%-8s", "\\t");
                    break;
                default:
                    printf("%-8c", i);
            }
            printf("%d\n", frequencies[i]);
        }
    }
    if (outOfRanges > 0)
        printf("Number of out of range characters: %d\n", outOfRanges);
}
// TOOD: Add code to print the histogram
#include <stdio.h>

float celsiusToFarenheit(float c) { return (9.0 / 5.0) * c + 32.0; }
int main()
{
    for (int i = 0; i <= 100; i += 1) {
        printf("%-7d%-7.2f\n", i, celsiusToFarenheit(i));
    }
}
#define MAX_LINE_LENGTH 501

// TODO: If the file is an empty file, the program prints some other chars
// Rectify this issue.
// Sample:
// Longest line:   0 characters
// ♦☺ <---- These chars are printed instead of nothing.
// The fix was to initialize the longest line array to 0, otherwise the printf
// function used to keep printing until a null char was found.
#include <assert.h>
#include <stddef.h>
#include <stdio.h>
int kr_getline(char buffer[], int bufferSize);
void kr_strncpy(char src[], char dest[], int destSize);

int main()
{
    char buffer[MAX_LINE_LENGTH] = {0}, buffer2[MAX_LINE_LENGTH] = {0};
    char longestLine[MAX_LINE_LENGTH] = {0};
    int bufferLength, maxLength = 0, lineLength = 0;

    while ((bufferLength = kr_getline(buffer, MAX_LINE_LENGTH))) {
        // The last character of the buffer (excepting the null character), is
        // not a newline, which means that the buffer is partial.
        if ((bufferLength == (MAX_LINE_LENGTH - 1)) &&
            (buffer[MAX_LINE_LENGTH - 2] != '\n')) {
            if (lineLength == 0) {
                // This is the first section of the line.
                kr_strncpy(buffer, buffer2, MAX_LINE_LENGTH);
            }
            lineLength += bufferLength;
        }
        // The buffer is partially filed and has a newline or it is completely
        // filled with a newline at the end.
        else {
            if (lineLength > 0) {
                // This means that before this line, there are some incomplete
                // lines. So do  not overwrite the buffer.
                lineLength += bufferLength;
                if (lineLength > maxLength) {
                    maxLength = lineLength;
                    kr_strncpy(buffer2, longestLine, MAX_LINE_LENGTH);
                }
                lineLength = 0;
            }
            else {
                // There are no other incomplete lines before this line.
                if (bufferLength > maxLength) {
                    maxLength = bufferLength;
                    kr_strncpy(buffer, longestLine, MAX_LINE_LENGTH);
                }
            }
        }
    }
    printf("Longest line:%4d characters\n", maxLength);
    printf("%s\n", longestLine);
}

void kr_strncpy(char src[], char dest[], int destSize)
{
    // Copies characters from source array to destination array.
    // Also null terminates the destination array.

    int i = 0;
    while (1) {
        assert(i <= (destSize - 1));
        dest[i] = src[i];
        if (src[i] == '\0') return;

        i++;
        if (i == (destSize - 1)) {
            // No more room to copy another character, destSize-2 location is
            // already filled, set character at index destSize-1 to null
            // character.
            dest[i] = '\0';
            return;
        }
    }
}

int kr_getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0, lineLength = 0;
    while (1) {
        ch = getchar();

        if (ch == EOF) {
            // The code to check for End of file is placed here, so that the
            // program does not add the EOF to the buffer, and also does not
            // inrease the line length.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }
        assert(bufferIndex <= (bufferSize - 1));

        buffer[bufferIndex] = ch;
        lineLength++;
        bufferIndex++;

        if (ch == '\n') {
            // The below code guarantees that there is one vacant position at
            // the end of the buffer, So it is not necessary to check
            // overflow condition here.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }

        if (bufferIndex == (bufferSize - 1)) {
            // Here, bufferIndex is the index for the next character to be read.
            // So if there is only one more location which is vacant in the
            // buffer, set that to null character and return the string.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }
    }
}
#define BUFFER_SIZE 82
#define IN_LINE 1
#define OUT_LINE 0
// Buffer size is defined as 82 so that 80 characters and a new line can be
// stored along with one null character at the end.

#include <assert.h>
#include <stddef.h>
#include <stdio.h>

int kr_getline(char buffer[], int bufferSize);
void kr_strncpy(char src[], char dest[], int destSize);

int main()
{
    int length;
    char buffer[BUFFER_SIZE] = {0};
    int state = OUT_LINE;
    while ((length = kr_getline(buffer, BUFFER_SIZE))) {
        if (length == (BUFFER_SIZE - 1)) {
            if (buffer[length - 1] != '\n') state = IN_LINE;
            printf("%s", buffer);
        }
        else if (state == IN_LINE) {
            state = OUT_LINE;
            printf("%s", buffer);
        }
        // printf("(%d)[%s]", length, buffer);
    }
}

void kr_strncpy(char src[], char dest[], int destSize)
{
    // Copies characters from source array to destination array.
    // Also null terminates the destination array.

    int i = 0;
    while (1) {
        assert(i <= (destSize - 1));
        dest[i] = src[i];
        if (src[i] == '\0') return;

        i++;
        if (i == (destSize - 1)) {
            // No more room to copy another character, destSize-2 location is
            // already filled, set character at index destSize-1 to null
            // character.
            dest[i] = '\0';
            return;
        }
    }
}

int kr_getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0, lineLength = 0;
    // lineLength also counts the newline character(if any)
    while (1) {
        ch = getchar();

        if (ch == EOF) {
            // The code to check for End of file is placed here, so that the
            // program does not add the EOF to the buffer, and also does not
            // inrease the line length.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }
        assert(bufferIndex <= (bufferSize - 1));

        buffer[bufferIndex] = ch;
        lineLength++;
        bufferIndex++;

        if (ch == '\n') {
            // The below code guarantees that there is one vacant position at
            // the end of the buffer, So it is not necessary to check
            // overflow condition here.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }

        if (bufferIndex == (bufferSize - 1)) {
            // Here, bufferIndex is the index for the next character to be read.
            // So if there is only one more location which is vacant in the
            // buffer, set that to null character and return the string.
            assert(bufferIndex <= (bufferSize - 1));
            buffer[bufferIndex] = '\0';
            return lineLength;
        }
    }
}
// COMMAND: exercise-1-18.exe < ttext\strip_spaces_end.txt | exercise-1-10.exe
// This mostly works.... but it does not work when a non empty line has more
// spaces than what the buffer can hold. The previous buffer will not know
// whether to print or not print those spaces. For example: (dots are spaces
// here) Hello..............................
//               | (say buffer splits here)
// Hello..........
// ....................
// Now the line containing hello does not know whether to print those spaces or
// not.

// It can also be like this
// Hello..........
// .............3......
// So when processing the Hello line, it is not known whether this line is
// trailing or not.
//
// The question has asked only to remove trailing blanks, while this solution
// strips both preceeding and trailing blanks.

// One solution is to use dynamic memory allocation to store the entire text in
// memory.
#define BUFFER_SIZE 65
#define LINE_BEG 0
#define LINE_MID 1
#define LINE_END 2

#include <assert.h>
#include <stdio.h>
int getline(char buffer[], int bufferSize);
void _strncpy(char from[], char to[], int size);

int main()
{
    char buffer[BUFFER_SIZE] = {'\0'};
    int state = LINE_BEG, length, nonBlankIndex;

    while ((length = getline(buffer, BUFFER_SIZE))) {
        // Ignore blank or empty lines
        if ((length == 1 && buffer[0] == '\n') || length == 0) continue;
        nonBlankIndex = length;

        // Find the position of the last non-blank character of the line.
        for (int j = length - 2; j >= 0; j--) {
            if (!(buffer[j] == ' ' || buffer[j] == '\t')) {
                nonBlankIndex = j;
                break;
            }
        }

        for (int i = 0; i < length; i++) {
            if (state == LINE_BEG && buffer[i] != ' ' && buffer[i] != '\t') {
                state = LINE_MID;
            }
            if (buffer[length - 1] == '\n' && i >= nonBlankIndex) {
                putchar('\n');
                break;
            }
            if (state == LINE_MID) putchar(buffer[i]);
        }

        // The last non null character of the current buffer is a newline
        // so the line is complete.
        if (buffer[length - 1] == '\n') {
            // printf("#%c#\n", buffer[length-1]);
            state = LINE_BEG;
        }
        if (buffer[length - 1] != '\n') {
            // printf("*%c*\n", buffer[length-1]);
            state = LINE_MID;
        }
    }
}

void _strncpy(char from[], char to[], int size)
{
    // Copies n characters from from array to to array.
    // Assumed that the destination array is big enough and size is valid.
    for (int i = 0; i < (size - 1); i++) {
        if (from[i] == '\0') break;
        to[i] = from[i];
    }
    to[size - 1] = '\0';
}

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    // Characters are stored in the buffer, leaving
    // one space vacant for the null character.
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;

        buffer[bufferIndex] = ch;

        if (ch == '\n') {
            bufferIndex++;
            break;
        }

        bufferIndex++;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}
// Write a function reverse(s) that reverses the character string s. Use it to
// write a program that reverses its input a line at a time.
// This version of the program has a fixed max line length constraint, as I have
// used no dynamic memory allocation, it is not possible to reverse and print
// if the line is split into multiple buffers.
#include <stdio.h>
// Arbitary max line length
#define MAX_LINE_LENGTH 32768

int getline(char buffer[], int bufferSize);

int main()
{
    int length;
    char buffer[MAX_LINE_LENGTH] = {'\0'};
    while ((length = getline(buffer, MAX_LINE_LENGTH))) {
        // getline() returns the size of the string
        // For example: Hello
        // Size: 7
        // H e l l 0 \n \0
        // 1 2 3 4 5  6  7
        // So the program has to print backwards from index 5
        // hence length - 2
        for (int i = length - 2; i >= 0; i--) {
            putchar(buffer[i]);
        }
        putchar('\n');
    }
}

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    // Characters are stored in the buffer, leaving
    // one space vacant for the null character.
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;

        buffer[bufferIndex] = ch;
        // bufferIndex is the index for the next character to be read.
        bufferIndex++;

        if (ch == '\n') {
            break;
        }
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}
#include <stdio.h>
int main()
{
    /*printf("%s\n","\a");*/
    /*printf("%s\n","\b");*/
    /*printf("%s\n","\c");*/
    /*printf("%s\n","\d");*/
    /*printf("%s\n","\e");*/
    // When the characters which are not listed are used, the character is
    // printed (in my system). For example \d prints d. \a makes a sound.
    printf("%s\n", "\k");
    printf("\k");
}
/*
 * Program to replace tabs with multiple spaces.
 *
 * TODO: Apparently this code is incorrect as it replaces any tab with tabstop
 * number of spaces, but according to the question, tabstop was present in
 * typewriters and a tab adds that many spaces to the text so that the text is
 * aligned to a tabstop. For example: Hello \tworld |    |    | Let the tabstops
 * be 4 characters wide. So it should get printed as Hello   world |    |    |
 *  (So two spaces are added in this example)
 *  The program I have written is expanding tabs to spaces, like many editors.
 */
#include <assert.h>
#include <stdio.h>
#define TABSTOP 4
#define BUFFER_SIZE 4096
void detab(char str[]);
void detab2(char str[], char op[]);
int getline(char buffer[], int bufferSize);

int main()
{
    char buffer[BUFFER_SIZE] = {'\0'};
    // To be on the safer side, add few more extra spaces for null and other
    // chars.
    char outputBuffer[(BUFFER_SIZE * 4) + 1] = {'\0'};
    while (getline(buffer, BUFFER_SIZE)) {
        // detab(buffer);
        detab2(buffer, outputBuffer);
        printf("%s", outputBuffer);
    }
}

void printChars(char ch, int count)
{
    for (int i = 0; i < count; i++) putchar(ch);
}

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    // Characters are stored in the buffer, leaving
    // one space vacant for the null character.
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;

        buffer[bufferIndex] = ch;
        // bufferIndex is the index for the next character to be read.
        bufferIndex++;

        if (ch == '\n') {
            break;
        }
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}

void detab(char str[])
{
    int i = 0;
    while (str[i] != '\0') {
        /*printf("<i=%d> <%c>\n", i, str[i]);*/
        if (str[i] == '\t')
            printChars(' ', TABSTOP);
        else
            putchar(str[i]);
        i++;
    }
}

void detab2(char str[], char op[])
{
    /** Converts spaces from a single line (buffer) to tabs and spaces.
     * str - The input character array.
     * op - The output character array (has to be atleast TABSTOP times big
     * enough to store the characters incase the string is completely tabs) It
     * is assumed that str is null terminated and op array is big enough.*/
    int i;
    while (*str != '\0') {
        if (*str == '\t') {
            for (i = 0; i < TABSTOP; i++) *op++ = ' ';
        }
        else
            *op++ = *str;
        str++;
    }
    *op = '\0';
}
/*
 * My algorithm to fold lines as specified by the given fold width.
 * Create a character array (buffer) of the required fold width + 1 (for the
 * null char) Set rem = 0 While EOF is not yet reached. Read upto a newline or
 * fold width - rem characters, whichever is smaller into the buffer If the
 * number of characters read are less than fold width Print buffer Else Find the
 * index of the last space, hyphen or tab from the buffer. If no such position
 * was found Set index to fold width - 1
 *
 *          Print buffer until this index (not inclusive)
 *          Print a newline
 *
 *          Set rem to the number of remaining characters.
 *          Print remaining characters of the buffer.
 *  ^^^
 *  For some reason, the above algorithm does not work correctly.
 *
 *  New and improvised algorithm
 *  =============================
 *  Set used_space = 0
 *  While EOF is not yet reached
 *      Read (FOLD_WIDTH - used_space) characters from the input or till a
 * newline, whichever is smaller into buffer.
 * If the last character of the buffer(string) is a newline
 *      Print the buffer
 *      Set used_space = 0
 *  Else Find the index of the last space, tab or hyphen (break character) from
 * then end. If no space was found Print the buffer completely Print a newline
 *      Set used_space = 0
 *  Else Print the buffer till the last break character (excluding the break
 * character). Print a newline Print characters after the last break character
 * till the end of the buffer. Set used_space = Number of characters after the
 * last break character.
 */
#include <assert.h>
#include <stdio.h>
#define FOLD_WIDTH 80

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        buffer[bufferIndex] = ch;

        bufferIndex++;
        if (ch == '\n') break;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}

int main()
{
    char buffer[FOLD_WIDTH + 1] = {'\0'};
    int usedSpace = 0, j, length;
    while ((length = getline(buffer, (FOLD_WIDTH + 1 - usedSpace)))) {
        if (buffer[length - 1] == '\n') {
            printf("%s", buffer);
            usedSpace = 0;
        }
        else {
            int i;
            for (i = length - 1; i >= 0; i--) {
                if (buffer[i] == ' ' || buffer[i] == '\t' || buffer[i] == '-') {
                    break;
                }
            }
            // No whitespace or tab or hyphen was found, Break exactly at fold
            // width.
            if (i == -1) {
                printf("%s", buffer);
                printf("%s", "\n");
                usedSpace = 0;
            }
            else {
                for (j = 0; j < i; j++) putchar(buffer[j]);
                putchar('\n');
                for (j = i + 1; j < length; j++) putchar(buffer[j]);
                usedSpace = length - i - 1;
            }
        }
    }
}
#include <stdio.h>
/*
 * My implementation of Decomment uses a state machine.
 */


enum State {
    SEARCH,
    SEMI_COMMENT,
    CHAR,
    STR,
    SINGLE_LINE,
    MULTI_LINE,
    MULTI_LINE_SEMI,
    STR_ESC,
    CHAR_ESC,
};

enum State state = SEARCH;

void processChar(int ch)
{
    switch (state) {
        case SEARCH:
            switch (ch) {
                case '/':
                    state = SEMI_COMMENT;
                    break;
                case '"':
                    putchar('"');
                    state = STR;
                    break;
                case '\'':
                    putchar('\'');
                    state = CHAR;
                    break;
                default:
                    putchar(ch);
                    break;
            }
            break;

        case SEMI_COMMENT:
            switch (ch) {
                case '/':
                    state = SINGLE_LINE;
                    break;
                case '*':
                    state = MULTI_LINE;
                    break;
                default:
                    putchar('/');
                    putchar(ch);
                    state = SEARCH;
                    break;
            }
            break;

        case SINGLE_LINE:
            switch (ch) {
                case '\n':
                    putchar('\n');
                    state = SEARCH;
                    break;
                default:
                    state = SINGLE_LINE;
                    break;
            }
            break;

        case MULTI_LINE:
            switch (ch) {
                case '*':
                    state = MULTI_LINE_SEMI;
                    break;
            }
            break;

        case MULTI_LINE_SEMI:
            switch (ch) {
                case '/':
                    state = SEARCH;
                    break;
                default:
                    state = MULTI_LINE;
                    break;
            }
            break;

        case STR:
            switch (ch) {
                case '\\':
                    state = STR_ESC;
                    break;
                case '"':
                    putchar('"');
                    state = SEARCH;
                    break;
                default:
                    putchar(ch);
                    break;
            }
            break;

        case STR_ESC:
            putchar('\\');
            putchar(ch);
            state = STR;
            break;

        case CHAR:
            switch (ch) {
                case '\\':
                    state = CHAR_ESC;
                    break;
                case '\'':
                    putchar('\'');
                    state = SEARCH;
                    break;
                default:
                    putchar(ch);
                    break;
            }
            break;

        case CHAR_ESC:
            putchar('\\');
            putchar(ch);
            state = CHAR;
            break;
    }
}

int main()
{
    int ch;
    while ((ch = getchar()) != EOF) {
        processChar(ch);
    }
}
#include <stdio.h>
// Max level of nesting is 5000
#define MAX_STACK_SIZE 5000
enum State {
    PROGRAM,
    STRING,
    STR_ESC,
    CHAR,
    CHAR_ESC,
    SINGLE_COMMENT,
    SINGLE_COMMENT_PARTIAL
    // NOTE: I am not handling comments and their related check in this program
    // As it requires me to combine the previous program, detect comment and do
    // other things.
    // So this program is not in full generality.
    // Also this program does not check the length of char.
    //    COMMENT
    // )
    // Implemented feature for ignoring parenthesis in single line comments.
    // NOTE: The program reports no error even if the above line (with a ) ) is
    // uncommented.
};
char stack[MAX_STACK_SIZE];
int stackPtr = -1;
enum State state = PROGRAM;

int main()
{
    int ch;
    int l = 1;
    while ((ch = getchar()) != EOF) {
        if (ch == '\n') l++;
        switch (state) {
            case PROGRAM:
                if (ch == '"') {
                    state = STRING;
                    break;
                }
                else if (ch == '\'') {
                    state = CHAR;
                    break;
                }
                else if (ch == '/') {
                    state = SINGLE_COMMENT_PARTIAL;
                }
                else if (ch == '{' || ch == '(' || ch == '[') {
                    if (stackPtr >= (MAX_STACK_SIZE - 1)) {
                        printf("%s\n",
                               "Maximum nesting level supported by the program "
                               "exceeded");
                        return -1;
                    }
                    stack[++stackPtr] = (char)ch;
                }
                else if (ch == '}' || ch == ')' || ch == ']') {
                    if (stackPtr < 0) {
                        printf("Line %d: Syntax error - Unmatched '%c'\n", l,
                               ch);
                    }
                    else {
                        if ((stack[stackPtr] == '[' && ch == ']') ||
                            (stack[stackPtr] == '{' && ch == '}') ||
                            (stack[stackPtr] == '(' && ch == ')')) {
                            // The braces match.
                            stackPtr -= 1;
                        }
                        else {
                            printf(
                                "Line %d: Syntax error - Opening parenthesis "
                                "'%c' does not match closing parenthesis "
                                "'%c'\n",
                                l, stack[stackPtr], ch);
                        }
                    }
                }
                break;
            case STRING:
                if (ch == '\\') {
                    state = STR_ESC;
                }
                else if (ch == '"') {
                    state = PROGRAM;
                }
                else if (ch == '\n') {
                    printf("Line %d: Unterminated string\n", l);
                    state = PROGRAM;
                }
                break;
            case STR_ESC:
                state = STRING;
                break;

            case CHAR:
                if (ch == '\\') {
                    state = CHAR_ESC;
                }
                else if (ch == '\'') {
                    state = PROGRAM;
                }
                else if (ch == '\n') {
                    printf("Line %d: Unterminated character\n", l);
                    state = PROGRAM;
                }
                break;
            case CHAR_ESC:
                state = CHAR;
                break;

            case SINGLE_COMMENT:
                if (ch == '\n') {
                    state = PROGRAM;
                }
                break;
            case SINGLE_COMMENT_PARTIAL:
                if (ch == '/') {
                    state = SINGLE_COMMENT;
                }
                else {
                    state = PROGRAM;
                }
                break;
            default:
                printf("<<<<<<%s>>>>>>\n", "SERIOUS ERROR - NO SUCH STATE");
                return -1;
        }
    }
    if (stackPtr > 0) {
        printf("Syntax error - %s \n", "Unmatched parenthesis");
    }
    else {
        printf("No errors:%d\n", stackPtr);
    }
}
// Test Case #1
/** (){}
 * ()()()
 * ()()()[][][]
 * ()()(){[][][]}
 * ()[][][] */
#include <stdio.h>
#define RANGE_MIN 0
#define RANGE_MAX 300
#define STEP 20

// Program to print the corresponding Celsius to Fahreheit table.
int main()
{
    float temperatureInF = 0;
    int temperatureInC = RANGE_MIN;
    printf("%8s%11s\n", "CELSIUS", "FAHRENHEIT");
    while (temperatureInC <= RANGE_MAX) {
        temperatureInF = ((9.0 / 5.0) * temperatureInC) + 32;
        printf("%-8d%11.2f\n", temperatureInC, temperatureInF);
        temperatureInC += STEP;
    }
    return 0;
}
#include <stdio.h>
#define RANGE_START 300
#define RANGE_END 0
#define STEP -20

// Program to print the corresponding Celsius to Fahreheit table.
int main()
{
    float temperatureInF = 0;

    printf("%8s%11s\n", "CELSIUS", "FAHRENHEIT");
    for (int temperatureInC = RANGE_START; temperatureInC >= RANGE_END;
         temperatureInC += STEP) {
        temperatureInF = ((9.0 / 5.0) * temperatureInC) + 32;
        printf("%-8d%11.2f\n", temperatureInC, temperatureInF);
    }
    return 0;
}
#include <stdio.h>
int main()
{
    // Verifying that getchar() != EOF is either 1 or 0
    int ch, ch2;
    ch = getchar() != EOF;
    ch2 = getchar() != EOF;
    printf("%d\n", ch);
    printf("%d\n", ch2);
    printf("Value of EOF is: %s\n", EOF);

    /*^Z*/
    /*^D*/
    /*0*/
    /*1*/
    /*Value of EOF is: -1*/

    return 0;
}
#include <stdio.h>

int main()
{
    int ch;
    int nb = 0, nt = 0, nl = 0;
    while ((ch = getchar()) != EOF) {
        if (ch == ' ') ++nb;
        if (ch == '\n') ++nl;
        if (ch == '\t') ++nt;
    }
    printf("Spaces:%-6dTabs:%-6dNewlines:%-6d\n", nb, nt, nl);
    return 0;
}
#include <stdio.h>

int main()
{
    int ch;
    int isLastCharSpace = 0;

    while ((ch = getchar()) != EOF) {
        if (ch == ' ')
            isLastCharSpace = 1;
        else {
            if (isLastCharSpace) putchar(' ');
            putchar(ch);
            isLastCharSpace = 0;
        }
    }
    return 0;
}
#include <float.h>
#include <limits.h>
#include <stdio.h>

int main()
{
    printf("%s\n", "Basic datatypes");
    printf("%s\n", "===============");
    printf("char  : %d to %d\n", CHAR_MIN, CHAR_MAX);
    printf("short : %d to %d\n", SHRT_MIN, SHRT_MAX);
    printf("int   : %d to %d\n", INT_MIN, INT_MAX);
    printf("long  : %ld to %ld\n", LONG_MIN, LONG_MAX);
    printf("long long int : %lld to %lld\n", LLONG_MIN, LLONG_MAX);

    printf("float : %f to %f\n", FLT_MIN, FLT_MAX);
    printf("double: %f to %f\n", DBL_MIN, DBL_MAX);

    printf("\n");

    printf("%s\n", "Unsigned datatypes");
    printf("%s\n", "===============");

    printf("unsigned char  : %d to %d\n", 0, UCHAR_MAX);
    printf("unsigned short : %d to %d\n", 0, USHRT_MAX);
    printf("unsigned int   : %d to %d\n", 0, UINT_MAX);
    printf("unsigned long  : %d to %lu\n", 0, ULONG_MAX);

    printf("\n");
    /**
     * // Long double does not work in my machine as I use a port of gcc (mingw)
     * on windows. printf("%s\n","long datatypes");
     *     printf("%s\n","===============");
     *
     *     printf("long double: %LF to %LF\n", LDBL_MIN, LDBL_MAX);
     *
     *     printf("\n"); */
}
/** Exercise 2-10. Rewrite the function lower, which converts upper case letters
 * to lower case, with a conditional expression instead of if-else.
 */

#include <stdio.h>
/*
 * NOTE: This program does not work on all charsets
 * Only works on ascii
 */
int toLower(int ch) { return ((ch >= 'A') && (ch <= 'Z')) ? (ch + 32) : ch; }
int main()
{
    int ch;
    while ((ch = getchar()) != EOF) {
        putchar(toLower(ch));
    }
}
/*
 * Rewrite the below code without using && and ||
 * for (i=0; i < lim-1 && (c=getchar()) != '\n' && c != EOF; ++i)
 *      s[i] = c;
 */

#include <stdio.h>
#define BUFFER_SIZE 64
int main()
{
    char buffer[BUFFER_SIZE];
    int bufferIndex = 0, ch;
    while (bufferIndex < (BUFFER_SIZE - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        buffer[bufferIndex] = ch;
        bufferIndex++;
        if (ch == '\n') break;
    }
    buffer[bufferIndex] = '\0';
    printf("%s", buffer);
}
/** Write a function htoi(s), which converts a string of hexadecimal digits
 * (including an optional 0x or 0X) into its equivalent integer value. The
 * allowable digits are 0 through 9, a through f, and A through F. */

#include <ctype.h>
#include <limits.h>
#include <stdio.h>
// Such large hex values are not supported as the max hex value supported
// depends on the range of unsigned long long int. Typically it is
// 18446744073709551615 or 0xffffffffffffffff in hex. But to support multiple
// leading 0s, I have set MAX_HEX_SIZE to a much larger value.
#define MAX_HEX_SIZE 256
int getFaceValue(char s)
{
    int val = -1;
    switch (s) {
        case '0':
            val = 0;
            break;
        case '1':
            val = 1;
            break;
        case '2':
            val = 2;
            break;
        case '3':
            val = 3;
            break;
        case '4':
            val = 4;
            break;
        case '5':
            val = 5;
            break;
        case '6':
            val = 6;
            break;
        case '7':
            val = 7;
            break;
        case '8':
            val = 8;
            break;
        case '9':
            val = 9;
            break;
        case 'a':
        case 'A':
            val = 10;
            break;
        case 'b':
        case 'B':
            val = 11;
            break;
        case 'c':
        case 'C':
            val = 12;
            break;
        case 'd':
        case 'D':
            val = 13;
            break;
        case 'e':
        case 'E':
            val = 14;
            break;
        case 'f':
        case 'F':
            val = 15;
            break;
        default:
            val = -1;
    }
    return val;
}

/*
// This code does not correctly work in non ascii based character sets.
// So the most portable way is to use a lookup.
if(isalpha(*s) && isupper(*s))
{
    temp = *s - 55;
    printf("(%d)", temp);
}
else if(isalpha(*s) && islower(*s))
{
    temp = *s - 87;
}
*/

int getline(char buffer[], int bufferSize)
{
    int ch, bufferIndex = 0;
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        buffer[bufferIndex] = ch;
        bufferIndex++;
        if (ch == '\n') break;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}

unsigned long long int htoi(char s[])
{
    // Assumed that the string is null terminated.
    // NOTE: To fix, on inputting 10, the value is 1 instead of 16
    // FIXED - The error was that I had not put a case for the '0' character.
    unsigned long long int val = 0;
    int i = 0, nextCharMightBeX = 0;
    while (*s != '\0') {
        if (i == 0 && *s == '0') {
            nextCharMightBeX = 1;
        }
        if (i == 1 && (*s == 'x' || *s == 'X') && nextCharMightBeX) {
            s++;
            i++;
            continue;
        }

        if (getFaceValue(*s) == -1) {
            // Invalid input, return the previous best known value.
            return val;
        }
        val = (val * 16) + getFaceValue(*s);
        s++;
        i++;
    }
    return val;
}
// Max supported value
// 0xffffffffffffffff
int main()
{
    printf("Max supported decimal value: %I64u\n", ULLONG_MAX);
    printf("Max supported hex value: 0x%I64x\n", ULLONG_MAX);
    char buffer[MAX_HEX_SIZE];
    int length;
    while ((length = getline(buffer, MAX_HEX_SIZE))) {
        if (length == 1) break;
        // I found that %llu format does not work in my compiler, (MinGW gcc on
        // windows) So instead I have to use %I64u. This format specifier is not
        // cross platform.
        printf("%I64u\n", htoi(buffer));
    }
}
/** Exercise 2-4. Write an alternative version of squeeze(s1,s2) that deletes
 * each character in s1 that matches any character in the string s2. */
/*
 * Simple algorithm
 * ===============
 * Time complexity : n^2 (m*n if the length of the strings are different)
 * j = 0
 * For every character c of s1
 *      If c is not present in s2
 *          s1[j] = c
 *          Increment j by 1
 * Set the value of s1[j] to null character.
 *
 * Improved algorithm
 * ==================
 * Time complexity : 2n (m + n if the length of the strings are different)
 * Currently works only for ASCII.
 * I am not using a map/hashmap here.
 * Create an array of size 256.(Larger if you want to support other charsets).
 * Call it charactermap and initialize it to 0.
 *
 * For every char c2 of s2
 *      Check if c2 is within range of the charactermap array.
 *      charactermap[c2] = 1
 *
 * j = 0
 * For every char c1 of s1
 *      If charactermap[c1] == 0 then
 *          s1[j] = c1
 *          Increment j by 1
 * Set the value of s1[j] to null character.
 *
 */
#include <stdio.h>
#include <string.h>
#define CHAR_MAP_SIZE 256
void squeeze(char s1[], char s2[])
{
    // exercise-2-4.c|43 col 21| warning: array subscript has type 'char'
    // [-Wchar-subscripts] On some systems, char can also be signed, i.e. some
    // characters can have negative integer values. So when it is used as array
    // index, the program can access some other memory location and cause
    // undefined behaviour.
    // SO THIS IMPLEMENTATION WORKS ONLY FOR ASCII and UNSIGNED CHAR SYSTEM.
    // The general solution will be to implement a char-int map instead of an
    // array.
    int charactermap[CHAR_MAP_SIZE] = {0};
    size_t i, j;
    for (i = 0; i < strlen(s2); i++) {
        charactermap[s2[i]] = 1;
    }
    for (i = j = 0; s1[i] != '\0'; i++) {
        if (!charactermap[s1[i]]) {
            s1[j++] = s1[i];
        }
    }
    s1[j] = '\0';
}
int main()
{
    char s1[] = "the quick brown fox jumps over the lazy dogs";
    char s2[] = "aeiou";
    /** char s2[] = "abcdefghijklmnopqrstuvwxyz"; */
    squeeze(s1, s2);
    printf("%s\n", s1);
}
/** Write the function any(s1,s2), which returns the first location in a string
 * s1 where any character from the string s2 occurs, or -1 if s1 contains no
 * characters from s2. (The standard library function strpbrk does the same job
 * but returns a pointer to the location.) */
/*
 * I have reused code from exercise-2-4
 */

/* Improved algorithm
 * ==================
 * Time complexity : 2n (m + n if the length of the strings are different)
 * Currently works only for ASCII.
 * I am not using a map/hashmap here.
 * Create an array of size 256.(Larger if you want to support other charsets).
 * Call it charactermap and initialize it to 0.
 *
 * For every char c2 of s2
 *      Check if c2 is within range of the charactermap array.
 *      charactermap[c2] = 1
 *
 * j = 0
 * For every char c1 of s1
 *      If charactermap[c1] == 1 then
 *          return j
 *      Increment j by 1
 * return -1
 *
 */
#include <stdio.h>
#include <string.h>
#define CHAR_MAP_SIZE 256
int any(char s1[], char s2[])
{
    // exercise-2-4.c|43 col 21| warning: array subscript has type 'char'
    // [-Wchar-subscripts] On some systems, char can also be signed, i.e. some
    // characters can have negative integer values. So when it is used as array
    // index, the program can access some other memory location and cause
    // undefined behaviour.
    // SO THIS IMPLEMENTATION WORKS ONLY FOR ASCII and UNSIGNED CHAR SYSTEM.
    // The general solution will be to implement a char-int map instead of an
    // array.
    int charactermap[CHAR_MAP_SIZE] = {0};
    size_t i, j;
    for (i = 0; i < strlen(s2); i++) {
        charactermap[s2[i]] = 1;
    }
    for (i = j = 0; s1[i] != '\0'; i++) {
        if (charactermap[s1[i]]) {
            return j;
        }
        j++;
    }
    return -1;
}
int main()
{
    char s1[] = "the quick brown fox jumps over the lazy dogs";
    char s2[] = "ABCD120a";
    /** char s2[] = "abcdefghijklmnopqrstuvwxyz"; */
    int pos = any(s1, s2);
    printf("%d\n", pos);
}
/** Exercise 2-6. Write a function setbits(x,p,n,y) that returns x with the n
 * bits that begin at position p set to the rightmost n bits of y, leaving the
 * other bits unchanged. */
/*
 * I had difficulty in understanding the problem as it was not clear which
 * side should position be considered from.
 *
 * Got clarification from
 * https://stackoverflow.com/questions/1415854/kr-c-exercise-help
 *
 * Position starts from 0 at the right.
 *
 * For example:
 * 9 8 7 6 5 4 3 2 1 0
 * x x x x x x x x x x
 *
 * If p = 6 and n = 4
 *
 * 9 8 7 6 5 4 3 2 1 0
 * x x x x x x x x x x
 *       ^ ^ ^ ^
 * The marked positions have to be replaced with the rightmost n bits of y.
 *
 * 9 8 7 6 5 4 3 2 1 0
 * y y y y y y a b c d
 *
 * Result
 * ======
 *
 * 9 8 7 6 5 4 3 2 1 0
 * x x x a b c d x x x
 *
 * High level algorithm
 * ===========
 * 1 - Set the n bits in x from position p to 0
 * 9 8 7 6 5 4 3 2 1 0
 * x x x 0 0 0 0 x x x
 *
 * 2 - Extract rightmost n bits from y
 * 9 8 7 6 5 4 3 2 1 0
 * 0 0 0 0 0 0 a b c d
 *
 * 3 - Left shift the extracted bits from y so that they align with the bit
 * fields of x. (In this example, left shift by 3 ( p - n + 1) 9 8 7 6 5 4 3 2 1
 * 0 0 0 0 a b c d 0 0 0
 *
 * 4 - Perform logical OR between x and y
 * 9 8 7 6 5 4 3 2 1 0
 * x x x a b c d x x x
 *
 * Details
 * ========
 * Note: The program uses n+1 instead of n, as the position starts from 0.
 *
 * To set the n bits in x from position p to 0.
 * --------------------------------------------
 *
 * Right shift x by p+1, x >> 7, to get the left most bits
 * x x x
 * Left shift this result by p+1, x << 7 to get
 * x x x 0 0 0 0 0 0 0       -------------- (1)
 *
 * Get the right most bits of x which have to remain unchanged.
 * Perform (1 << (p-n+1)) - 1
 * (1 << (6 - 4 + 1)) - 1
 * Gives the mask
 * 0 0 0 0 0 0 0 1 1 1
 * Apply this mask to x to get
 * 0 0 0 0 0 0 0 x x x        -----------------(2)
 *
 * Combine (1) & (2) using logical OR
 * x x x 0 0 0 0 x x x
 *
 * Extracting right most n bits from y
 * -----------------------------------
 * Create the mask to extract the rightmost n bits from y
 * (1 << n) - 1
 * 0 0 0 0 0 0 1 1 1 1
 * Apply this mask using logical AND to y
 * 0 0 0 0 0 0 a b c d  --------------------- (3)
 *
 * Alignment of the extracted bits
 * -----------------------------------
 * To (3), apply left shift of (p - n + 1)
 * In this example, (6 - 4 + 1 = 3)
 * 0 0 0 a b c d 0 0 0 ------------------------ (4)
 *
 * Merging the numbers and getting the result
 * ------------------------------------------
 * Perform logical OR between  (4) and (2)
 * x x x a b c d x x x
 */

// Python solution for experimenting
/** f = lambda x, p, n: ((x>>(p+1))<<(p+1)) | (((1 << (p-n+1)) - 1) & x)
 * g = lambda x, p, n : print(bin(x),'\n',bin(f(x, p ,n)), sep = '') */

#include <stdio.h>
unsigned int setbits(unsigned int x, unsigned int p, unsigned int n,
                     unsigned int y)
{
    unsigned int x_m =
        ((x >> (p + 1)) << (p + 1)) | (((1 << (p - n + 1)) - 1) & x);
    unsigned int y_m = (((1 << n) - 1) & y) << (p - n + 1);
    return x_m | y_m;
}
int main()
{
    // TODO: Add checks for negative shifts
    // For example if position is 5 and n = 6, it can result in undefined
    // behaviour. Assumed that p > n
    printf("%d\n", setbits(2551, 8, 5, 3998));
}
/** Exercise 2-7. Write a function invert(x,p,n) that returns x with the n bits
 * that begin at position p inverted (i.e., 1 changed into 0 and vice versa),
 * leaving the others unchanged. */
/*
 * SOLUTION:
 * ===========
 * In this example, let p = 4 and n = 3
 * 9 8 7 6 5 4 3 2 1 0
 * x x x x x x x x x x
 *
 * So the result has to be
 * 9 8 7 6 5 4 3 2 1 0
 * x x x a b c x x x x
 *
 * Create a mask
 * (1 << n) - 1
 * Here n = 3.
 * 0 0 0 0 0 0 0 1 1 1
 * Left shift by p
 * 0 0 0 1 1 1 0 0 0 0 ---------- (2)
 * Combine x and (2) using logical XOR.
 *
 */
/*
Python 3 implementation for experimenting
===================================
f = lambda x, p, n: print(bin(x), '\n', bin(x ^ (((1 << n) - 1) << p)), sep='')
f(2**24 - 1,5,6)
f(2**24,5,6)
*/
#include <stdio.h>
typedef unsigned int uint;
uint invert(uint x, uint p, uint n) { return x ^ (((1 << n) - 1) << p); }
int main() { printf("%d\n", invert(40, 3, 3)); }
/** Exercise 2-8. Write a function rightrot(x,n) that returns the value of the
 * integer x rotated to the right by n positions */
/*
 * Example
 * ========
 * Let a = x x x x y y y
 * n = 3
 * y y y x x x x
 * n = 3
 * x x x y y y x
 * n = 1
 * x x x x y y y
 * n = 3
 * y y y x x x x
 *
 *
 * Algorithm
 * ============
 * Let x be the integer to be right rotated.
 * Let n be the number of positions to rotate.
 * temp = x >> n
 * Let len = 0
 *
 * [Find the number of significant bits in x]
 * [NOTE: Negative numbers cause an issue here]
 * while temp != 0
 *      temp = temp >> 1
 *      len = len + 1
 *
 * [mask to extract the contents which were right shifted]
 * mask = (1 << n) - 1
 * y = mask & x
 * result = (y << len) | (x >> n)
 *
 */
#include <stdio.h>
/*
 * NOTE: This was my understanding of right rotate shift.
 * But according to various sources, you have to also shift the zeros according
 * to the datatype.
 * For example:
 * 0 0 0 x x x y y
 * Right rotate shift by 2 results in
 * y y 0 0 0 x x x
 * Instead of
 *       y y x x x
 */
unsigned int rightrot(unsigned int x, unsigned int n)
{
    unsigned int temp = x >> n, len = 0, y;
    while (temp != 0) {
        temp >>= 1;
        len++;
    }
    y = ((1 << n) - 1) & x;
    return (y << len) | (x >> n);
}
unsigned int rightrot2(unsigned int x, unsigned int n)
{
    // Range of n must be between 1 and 31.
    // As 32 bit shifts are undefined(for 4 byte int implementations).
    if (n < 1) n = 1;
    if (n > 31) n = 31;
    unsigned int y = ((1 << n) - 1) & x;
    return (y << (sizeof(unsigned int) * 8 - n)) | (x >> n);
}
int main()
{
    printf("%u\n", rightrot2(32, 5));
    printf("%u\n", rightrot2(2489, 10));
    printf("%u\n", rightrot2(12, 2));
    printf("%u\n", rightrot2(14, 2));
    printf("%u\n", rightrot2(16, 2));
    printf("%u\n", rightrot2(18, 2));
    printf("%u\n", rightrot2(0, 5));
}
/** Exercise 2-9. In a two's complement number system, x &= (x-1) deletes the
 * rightmost 1-bit in x. Explain why. Use this observation to write a faster
 * version of bitcount.
 *
 * Should learn about two's complement number system.
 */
#include <stdio.h>
/* binsearch: find x in v[0] <= v[1] <= ... <= v[n-1] */
/*
int binsearch(int x, int v[], int n)
{
    int low, high, mid;
    low = 0;
    high = n - 1;

    while (low <= high)
    {
        printf("(%d, %d, %d)\n", low, mid, high);
        mid = (low+high)/2;
        if (x == v[mid])
            return mid;
        if (x < v[mid])
            high = mid + 1;
        if (x > v[mid])
            low = mid + 1;

    }
    return -1;
}
*/
#include <assert.h>
int binsearch(int x, int v[], int n)
{
    int low = 0, high = n - 1, mid;
    while (low <= high) {
        mid = (low + high) / 2;
        if (v[mid] == x) return mid;
        if (v[mid] < x) low = mid + 1;
        if (v[mid] > x) high = mid - 1;
    }
    return -1;
}

int main()
{
    int arr[] = {3, 7, 11, 16, 21, 23, 321, 441, 719, 1288, 1387, 41223};
    printf("%d\n", binsearch(1288, arr, 12));
}
/** Exercise 3-2. Write a function escape(s,t) that converts characters like
 * newline and tab into visible escape sequences like \n and \t as it copies the
 * string t to s. Use a switch. Write a function for the other direction as
 * well, converting escape sequences into the real characters. */
#include <assert.h>
#include <stdio.h>
void escape(char s[], char t[], int destSize)
{
    int i = 0, j = 0;
    while (s[i] != '\0') {
        if (j >= (destSize - 2)) {
            // Example:
            // For buffer size of 4096
            // Array:   |     |     |  \0  |
            // Index:    4093  4094  4095
            // if the index is 4094 (in this example), the program can store
            // at most one char, but if the char has to be expanded, it can
            // cause a buffer overflow.
            break;
        }
        switch (s[i]) {
            case '\n':
                assert(j < (destSize - 1));
                t[j++] = '\\';
                assert(j < (destSize - 1));
                t[j] = 'n';
                break;
            case '\t':
                assert(j < (destSize - 1));
                t[j++] = '\\';
                assert(j < (destSize - 1));
                t[j] = 't';
                break;
            default:
                assert(j < (destSize - 1));
                t[j] = s[i];
                break;
        }
        j++;
        i++;
    }
    assert(j <= (destSize - 1));
    t[j] = '\0';
}
int main()
{
    char *str = "this is a sample string\n a newline here\n one more\t a tab";
    char buff[256];
    escape(str, buff, 256);
    printf("%s", buff);
}
/** Exercise 3-3. Write a function expand(s1,s2) that expands shorthand
 * notations like a-z in the string s1 into the equivalent complete list
 * abc...xyz in s2. Allow for letters of either case and digits, and be prepared
 * to handle cases like a-b-c and a-z0-9 and -a-z. Arrange that a leading or
 * trailing - is taken literally. */
/*
 * Procedure
 * ===========
 * Let s1 be a null terminated char array of size n
 * Let mode = COPY_MODE
 * Let lastChar = ""
 * Let j = 0
 * s1 - s1[0] s1[1] ...... s1[n-1], where s1[n-1] = '\0'
 * For i = 0 to n-2
 *     IF mode = COPY_MODE
 *         IF s1[i] == '-'
 *              mode = EXPAND_MODE
 *         ELSE
 *              s2[j++] = s1[i]
 *              lastChar = s1[i]
 *     ELSE IF mode = EXPAND_MODE
 *         IF s1[i] > lastChar
 *              For every character between lastChar and s[i]
 *                  s2[j++] = char
 *              lastChar = s1[i]
 *              mode = COPY_MODE
 *         IF s1[i] == lastChar
 *              mode = COPY_MODE
 *         ELSE
 *              s2[j++] = -
 *              s2[j++] = s1[i]
 *              lastChar = s1[i]
 *              mode = COPY_MODE
 *  IF mode = EXPAND_MODE
 *     # implies that there was a trailing -
 *     s[j++] = '-'
 *  s[j] = '\0'
 *
 */
#include <ctype.h>
#include <stdio.h>
enum Mode { COPY_MODE, EXPAND_MODE };
#define BUFFER_SIZE 4096

void expand(char s1[], char s2[], int destSize)
{
    // Assumes that s1 is null terminated.
    enum Mode mode = COPY_MODE;
    int i = 0, j = 0;
    char lastChar = '\0';

    while (s1[i] != '\0') {
        if (!(j < (destSize - 2))) break;
        switch (mode) {
            case COPY_MODE:
                if (s1[i] == '-') {
                    mode = EXPAND_MODE;
                }
                else {
                    s2[j++] = s1[i];
                    lastChar = s1[i];
                }
                break;
            case EXPAND_MODE:
                if (lastChar == '\0') {
                    // Leading -
                    // Example: -abc
                    // Output: -abc
                    s2[j++] = '-';
                    s2[j++] = s1[i];
                    lastChar = s1[i];
                    mode = COPY_MODE;
                }
                else if (s1[i] > lastChar) {
                    // printf("%s %c-%c\n", "Expanding", lastChar, s1[i]);
                    // printf("%c-%c\n", lastChar+1, s1[i]);
                    for (int k = lastChar + 1; k <= s1[i]; k++) {
                        // I made a mistake of taking the loop variable as i
                        // here which caused a conflict with the outer loop i.
                        s2[j++] = k;
                    }
                    lastChar = s1[i];
                    mode = COPY_MODE;
                }
                else if (s1[i] == lastChar)
                    mode = COPY_MODE;
                else {
                    s2[j++] = '-';
                    s2[j++] = s1[i];
                    lastChar = s1[i];
                    mode = COPY_MODE;
                }
                break;
        }
        i++;
    }
    if (mode == EXPAND_MODE) {
        s2[j++] = '-';
    }
    s2[j] = '\0';
}
int getline(char buffer[], int bufferSize)
{
    // This implementation of getline does not include the newline char
    // in the buffer.
    int bufferIndex = 0;
    int ch;
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF || ch == '\n') break;
        buffer[bufferIndex++] = ch;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}
int main()
{
    char buffer[BUFFER_SIZE];
    /* char *str = "-a-a-zThe mystery of b-b-b-b A-K the universe a-d is 0-9
     * what does it z-m-ean-z-a-z-a-z0-9-a-z0-9 here is one more example
     * a-z0-99'"; */
    char str[BUFFER_SIZE];
    while (getline(str, BUFFER_SIZE)) {
        expand(str, buffer, BUFFER_SIZE);
        printf("%s\n", buffer);
    }
}
/* Exercise 3-4. In a two's complement number representation, our version of
 * itoa does not handle the largest negative number, that is, the value of n
 * equal to -(2^(wordsize-1)). Explain why not. Modify it to print that value
 * correctly, regardless of the machine on which it runs. */
/*
 * The value of INT_MIN: -2147483648
 * The value of INT_MAX: 2147483647
 *
 * Answer
 * =========
 * The value of INT_MIN is -(2^(word_size - 1), while the value of INT_MAX is
 * 2^(word_size - 1)
 *
 * NOTE: Here '^' indicates power, not XOR, 2^5 implies 2 to the power 5
 *
 * In two's complement number representation, the most significant bit is the
 * sign bit. So the number of available bits are one less than the total number
 * of bits. | SIGN-BIT |    |    |    |    |    |    | ...... |   |    | 2^31
 * 2^30 2^29 2^28 2^27 2^26 2^25  ......  2^1  2^0
 *
 * So the largest positive number which can be stored is all ones from the 0th
 * bit upto the 30th bit. In this case, the maximum value of such a number is 1
 * + 2^1 + 2^2 + ..... 2^30 Using the formula for sum of geometric progression,
 * S = a(r^n - 1)
 *     ----------
 *        r - 1
 * S = 1(2^31 - 1)
 *     ------------
 *          1
 * n = number of terms and is equal to 31 because 1 is also a term in the sum.
 *
 * So maximum value is 2^31 - 1 = 2147483647
 *
 * In case of the least value of a signed int in two's complement
 * The sign bit is set to 1
 * So the minimum value is -2^31 = -2147483648
 *
 * In case of unsigned int, The max value is 2^0 + 2^1 + 2^2 ..... 2^31 or 2^32
 * - 1 And the minimum value is 0.
 *
 * In this program, when the largest negative number is entered, we make it
 * positive if(n < 0) n = -n; But 2147483648 is larger than INT_MAX (4 bytes)
 * which is 2147483647. So the program gives a wrong output.
 *
 * The solution is to check if the number is INT_MIN, then convert INT_MIN + 1
 * to ascii, then decrease the last digit by 1. For example: Input: -2147483648
 *  Add 1, it becomes -2147483647 and 2147483647 fits in int (INT_MAX).
 *  Convert it, The char array is 8 4 6 3 8 . . . 1 2 -
 *  Increase the first char by by 1 (to make it 8)
 */
#include <limits.h>
#include <stdio.h>
#include <string.h>
void itoa(int n, char s[])
{
    // Store the sign of the number.
    int carry = 0;
    int sign = (n < 0) ? -1 : 1;
    // Makes n positive if it is negative so that it works correctly with the
    // modulus operator (%)
    if (n == INT_MIN) {
        n = n + 1;
        carry = 1;
    }
    if (n < 0) n = -n;
    int i = 0;
    do {
        // printf("(%d)",n%10);
        s[i++] = (n % 10) + '0';
        n = n / 10;
    } while (n != 0);
    if (s[0] != '\0' && carry) s[0] += carry;
    if (sign == -1) s[i++] = '-';
    s[i] = '\0';
    strrev(s);
}
int main()
{
    char buffer[64];
    // printf("The value of INT_MIN: %d\n", INT_MIN);
    // printf("The value of INT_MAX: %d\n", INT_MAX);
    itoa(INT_MIN, buffer);
    printf("%s\n", buffer);
}
/* Exercise 3-5. Write the function itob(n,s,b) that converts the integer n into
 * a base b character representation in the string s. In particular,
 * itob(n,s,16) formats s as a hexadecimal integer in s. */

// Number-Character mapping. Base-36 is the maximum supported base.
// mapping has to be initialized in main();

#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
// char mapping[36] = {'\0'};
// Used the program from exercise-3-3 to generate the chars.
char const mapping[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
// NOTE: This also includes the null character.

int itob(int n, char s[], int b, int destSize)
{
    /*
     * n - Number to be converted
     * s - Buffer to store number in converted base
     * b - Base
     * destSize - Size of s[]
     * NOTE: Does not support negative numbers.
     */
    int j = 0;
    if (n < 0) {
        printf(
            "%s\n",
            "Not Implemented (negative numbers) - Number has to be positive");
        // exit(-1);
        return 1;
    }
    if (b > 36) {
        printf("%s\n", "Unsupported - Base has to be less than or equal to 36");
        // exit(-1);
        return 1;
    }
    if (b <= 1) {
        printf("%s\n", "Invalid base - Base has to be greater than 1");
        // exit(-1);
        return 2;
    }
    // I have use a do-while loop instead of while loop to handle the case when
    // n is 0. So that the loop runs atleast once and digit becomes 0 (0 %
    // anything = 0)
    do {
        // -1, because C strings are null terminated.
        if (j >= (destSize - 1)) {
            printf(
                "%s\n",
                "Buffer overflow, converted number cannot be stored in buffer");
            // exit(-1);
            return 3;
        }
        s[j++] = mapping[n % b];
        n = n / b;
    } while (n != 0);
    s[j] = '\0';
    strrev(s);
    return 0;
}

int main()
{
    char buffer[64];
    // Initialize conversion map.
    // int j = 0;

    // The following way of initializing mapping does not work on non ascii
    // systems. This only works on ascii based systems. To make this program
    // portable, it is necessary to hardcode the characters for(int i = '0'; i
    // <= '9'; i++) mapping[j++] = i; for(int i = 'a'; i <= 'z'; i++)
    // mapping[j++] = i; assert(j==36);

    int n = 0;
    printf("%s\n", "Input non numeric to exit");
    // MAYBE A BUG
    // When sending interrupt using Ctrl+C, some extra lines are printed
    // Does not happen with Ctrl+D
    while (1) {
        // Type any character and enter to exit
        if (scanf("%d", &n) == 0) break;
        for (int i = 2; i <= 36; i++) {
            if (itob(n, buffer, i, 64) == 0) printf("%d - %s\n", i, buffer);
        }
    }
    return 0;
}
/* Exercise 3-6. Write a version of itoa that accepts three arguments instead of
 * two. The third argument is a minimum field width; the converted number must
 * be padded with blanks on the left if necessary to make it wide enough. */
#include <limits.h>
#include <stdio.h>
#include <string.h>
void itoa(int n, char s[], int w)
{
    // Store the sign of the number.
    int carry = 0;
    int sign = (n < 0) ? -1 : 1;
    // Makes n positive if it is negative so that it works correctly with the
    // modulus operator (%)
    if (n == INT_MIN) {
        n = n + 1;
        carry = 1;
    }
    if (n < 0) n = -n;
    int i = 0;
    do {
        // printf("(%d)",n%10);
        s[i++] = (n % 10) + '0';
        n = n / 10;
    } while (n != 0);
    if (s[0] != '\0' && carry) s[0] += carry;
    if (sign == -1) s[i++] = '-';

    // i is the length of the number.
    // Option 1
    /*
    for(int j = (i < w)?(w-i):0; j > 0; j--)
    {
        s[i++] = ' ';
    }
    */
    // Option 2
    while (i < w)
        // This works here because i is essentialy the length of the number.
        s[i++] = ' ';
    s[i] = '\0';
    strrev(s);
}
int main()
{
    char buffer[64];
    // printf("The value of INT_MIN: %d\n", INT_MIN);
    // printf("The value of INT_MAX: %d\n", INT_MAX);
    // itoa(INT_MIN, buffer, 8);
    itoa(3112, buffer, 0);
    printf("%s\n", buffer);
    itoa(3112, buffer, 1);
    printf("%s\n", buffer);
    itoa(3112, buffer, 2);
    printf("%s\n", buffer);
    itoa(3112, buffer, 3);
    printf("%s\n", buffer);
    itoa(3112, buffer, 4);
    printf("%s\n", buffer);
    itoa(3112, buffer, 5);
    printf("%s\n", buffer);
    itoa(3112, buffer, 6);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 0);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 1);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 2);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 3);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 4);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 5);
    printf("%s\n", buffer);
    itoa(-3112, buffer, 6);
    printf("%s\n", buffer);
}
/* Exercise 4-1. Write the function strindex(s,t) which returns the position of
 * the rightmost occurrence of t in s, or -1 if there is none. */
#include <stdio.h>
#include <string.h>

#include "utest.h"
int lstrindex(char s[], char t[])
{
    int i, k;
    // Iterate over every character of the string which has to be searched.
    for (i = 0; s[i] != '\0'; i++) {
        // Iterate over every character of the search string.
        for (k = 0; t[k] != '\0'; k++) {
            // This part here can cause an out of bounds access.
            // if the last character is compared, i+k will exceed the length of
            // the original array.

            // if(s[i + k] != t[k])
            //  break;

            if (s[i + k] == '\0') {
                // If the k th char of the source string is the null character,
                // we have reached the end of the string. This will probably get
                // handled in the below condition, but just to be explicit and
                // safe....
                break;
            }
            if (s[i + k] != t[k]) break;
        }

        if (t[k] == '\0') {
            // The above loop finished completely, we have the substring at i
            return i;
        }
    }
    return -1;
}

int rstrindex(char s[], char t[])
{
    // NOTE: This is not an efficient algorithm
    // TOOD: Implement Boyer-Moore algorithm for string searching.
    // Find the length of the string
    // char *temp = s;
    // int length;
    // while(*temp++) ++length;

    int length = strlen(s);
    int k;
    // Iterate over every character from backside
    for (int i = (length - 1); i >= 0; i--) {
        for (k = 0; t[k] != '\0'; k++) {
            if (s[i + k] == '\0' || s[i + k] != t[k]) break;
        }
        if (t[k] == '\0') return i;
    }
    return -1;
}

UTEST(RightStrindex, Validity)
{
    ASSERT_EQ(rstrindex("The quick brown fox jumps over the lazy dogs", "over"),
              26);
    ASSERT_TRUE(rstrindex("This is the way", "is") == 5);
    ASSERT_EQ(rstrindex("Once upon a time, long ago in", "in"), 27);
    ASSERT_EQ(rstrindex("Once upon a time, long ago up", "upona"), -1);
    ASSERT_TRUE(rstrindex("is it the way", "is") == 0);
    // ASSERT_EQ(lstrindex("", ""), 0);
    ASSERT_EQ(rstrindex("Once upon a time in a galaxy", "n"), 18);
    ASSERT_EQ(rstrindex("Once upon a time in a galaxy", "O"), 0);
    ASSERT_EQ(rstrindex("Once upon a time in in in in in in in in a a a galaxy",
                        "in"),
              38);
    ASSERT_EQ(
        rstrindex("Once upon a time in in in in in in in in a a a galaxy", "a"),
        50);
    ASSERT_EQ(rstrindex("Once upon a time in in in in in in in in a a a galaxy",
                        "Oncee"),
              -1);
    ASSERT_EQ(rstrindex("Once upon a time in in in in in in in in a a a galaxy",
                        "n "),
              39);
}

UTEST_MAIN();
/* Exercise 4-12. Adapt the ideas of printd to write a recursive version of
 * itoa; that is, convert an integer into a string by calling a recursive
 * routine. */
#include <stdio.h>

#include "utest.h"


void itoa_(char buff[], int num, int length)
{
    if (num / 10) {
        itoa_(buff, num / 10, length - 1);
    }
    buff[length - 1] = num % 10 + '0';
    printf("%d %d\n", num % 10, length-1);
}

int getLength(int n)
{
    int l = 0;
    do {
        l++;
    } while ((n = n / 10) != 0);
    return l;
}

void itoa2(char buff[], int num)
{
    int l = getLength(num);
    itoa_(buff, num, l);
    buff[l] = '\0';
}

UTEST(test_itoa_recursive, basic)
{
    char buffer[512] = {'\0'};

    itoa2(buffer, 54321);
    EXPECT_STREQ(buffer, "54321");

    itoa2(buffer, 12345);
    EXPECT_STREQ(buffer, "12345");

    itoa2(buffer, 1234);
    EXPECT_STREQ(buffer, "1234");

    itoa2(buffer, 123);
    EXPECT_STREQ(buffer, "123");

    itoa2(buffer, 12);
    EXPECT_STREQ(buffer, "12");

    itoa2(buffer, 1);
    EXPECT_STREQ(buffer, "1");

    itoa2(buffer, 0);
    EXPECT_STREQ(buffer, "0");

    itoa2(buffer, 10);
    EXPECT_STREQ(buffer, "10");

    itoa2(buffer, 100);
    EXPECT_STREQ(buffer, "100");

    itoa2(buffer, 1001);
    EXPECT_STREQ(buffer, "1001");

    itoa2(buffer, 10010);
    EXPECT_STREQ(buffer, "10010");

    itoa2(buffer, 10101);
    EXPECT_STREQ(buffer, "10101");

    itoa2(buffer, 31024006);
    EXPECT_STREQ(buffer, "31024006");

    itoa2(buffer, 3);
    EXPECT_STREQ(buffer, "3");

    itoa2(buffer, 1181);
    EXPECT_STREQ(buffer, "1181");

    itoa2(buffer, 10110210);
    EXPECT_STREQ(buffer, "10110210");

    itoa2(buffer, 60);
    EXPECT_STREQ(buffer, "60");

    itoa2(buffer, 2211);
    EXPECT_STREQ(buffer, "2211");

    itoa2(buffer, 321212);
    EXPECT_STREQ(buffer, "321212");

    itoa2(buffer, 6);
    EXPECT_STREQ(buffer, "6");

    itoa2(buffer, 55112);
    EXPECT_STREQ(buffer, "55112");

    itoa2(buffer, 99);
    EXPECT_STREQ(buffer, "99");

    itoa2(buffer, 0);
    EXPECT_STREQ(buffer, "0");

    itoa2(buffer, 1000);
    EXPECT_STREQ(buffer, "1000");

    // itoa2(buffer, );
    // EXPECT_STREQ(buffer, "");
}
UTEST_MAIN();
/* Exercise 4-13. Write a recursive version of the function reverse(s), which
 * reverses the string s in place. */
#include <stdio.h>
#include <string.h>

#include "utest.h"

void swap(char s[], int i, int j)
{
    char tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;
}
void reverse(char s[], int i, int l)
{
    if (s[i] == '\0')
        return;
    else
        reverse(s, i + 1, l);
    if (i > ((l / 2) - 1)) return;
    // printf("%c %d %d\n", s[i], i, l - 1 - i);
    swap(s, i, l - 1 - i);
}
UTEST_MAIN();

UTEST(test_reverse, basic)
{
    char s[8000];
    // NO BUFFER OVERFLOW CHECKS HERE
    // ONLY TEST
    strcpy(s, "This is the way");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ("yaw eht si sihT", s);

    strcpy(s, "this");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ("siht", s);

    strcpy(s, "The quick brown fox jumps over the lazy dogs");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ("sgod yzal eht revo spmuj xof nworb kciuq ehT", s);

    strcpy(s,
           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas "
           "consectetur, tellus a luctus luctus, nibh ipsum ornare massa, ac "
           "semper turpis metus vitae sem. Curabitur condimentum consectetur "
           "dapibus. Aliquam cursus ac risus ut semper.");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        ".repmes tu susir ca susruc mauqilA .subipad rutetcesnoc mutnemidnoc "
        "rutibaruC .mes eativ sutem siprut repmes ca ,assam eranro muspi hbin "
        ",sutcul sutcul a sullet ,rutetcesnoc saneceaM .tile gnicsipida "
        "rutetcesnoc ,tema tis rolod muspi meroL",
        s);

    strcpy(
        s,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam "
        "rhoncus tellus lacus, nec auctor magna imperdiet at. Phasellus eget "
        "tristique tortor. Cras porta diam id metus faucibus, vel consequat "
        "metus interdum. Maecenas pulvinar leo ac vulputate facilisis. Nam "
        "egestas enim vitae justo sodales, vel aliquam diam fermentum.");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        ".mutnemref maid mauqila lev ,selados otsuj eativ mine satsege maN "
        ".sisilicaf etatupluv ca oel ranivlup saneceaM .mudretni sutem "
        "tauqesnoc lev ,subicuaf sutem di maid atrop sarC .rotrot euqitsirt "
        "tege sullesahP .ta teidrepmi angam rotcua cen ,sucal sullet sucnohr "
        "mauqilA .tile gnicsipida rutetcesnoc ,tema tis rolod muspi meroL",
        s);

    strcpy(s,
           "Quisque at tincidunt lectus, et sollicitudin ante. Nullam posuere "
           "eros vel ligula tempor suscipit. Fusce posuere scelerisque urna. "
           "Suspendisse id nisl pulvinar, rhoncus libero et, consequat eros.");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        ".sore tauqesnoc ,te orebil sucnohr ,ranivlup lsin di essidnepsuS "
        ".anru euqsirelecs ereusop ecsuF .tipicsus ropmet alugil lev sore "
        "ereusop malluN .etna niduticillos te ,sutcel tnudicnit ta euqsiuQ",
        s);

    strcpy(s,
           " Sed luctus faucibus efficitur. Pellentesque porttitor, velit id "
           "posuere tincidunt, lacus sapien egestas justo, in maximus ex "
           "lectus et elit. Donec vel odio pellentesque, pulvinar orci "
           "efficitur, consequat massa.");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        ".assam tauqesnoc ,ruticiffe icro ranivlup ,euqsetnellep oido lev "
        "cenoD .tile te sutcel xe sumixam ni ,otsuj satsege neipas sucal "
        ",tnudicnit ereusop di tilev ,rotittrop euqsetnelleP .ruticiffe "
        "subicuaf sutcul deS ",
        s);

    strcpy(s,
           " Sed dignissim erat sit amet ante porttitor mollis. In quis "
           "maximus nisi. Donec fringilla magna sit amet mauris congue, id "
           "rhoncus nunc faucibus. Ut suscipit erat nec lorem dictum rutrum");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        "murtur mutcid merol cen tare tipicsus tU .subicuaf cnun sucnohr di "
        ",eugnoc siruam tema tis angam allignirf cenoD .isin sumixam siuq nI "
        ".sillom rotittrop etna tema tis tare missingid deS ",
        s);

    strcpy(
        s,
        ". Vivamus finibus nisl quis pellentesque tempor. Proin ac velit "
        "ipsum. Praesent convallis ullamcorper erat, quis ullamcorper tellus "
        "accumsan eu. Suspendisse imperdiet id felis imperdiet scelerisque.");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(
        ".euqsirelecs teidrepmi silef di teidrepmi essidnepsuS .ue nasmucca "
        "sullet reprocmallu siuq ,tare reprocmallu sillavnoc tnesearP .muspi "
        "tilev ca niorP .ropmet euqsetnellep siuq lsin subinif sumaviV .",
        s);
    strcpy(s, "a");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(s, "a");

    strcpy(s, "ab");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(s, "ba");

    strcpy(s, "abc");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(s, "cba");

    strcpy(s, "");
    reverse(s, 0, (int)strlen(s));
    ASSERT_STREQ(s, "");
}
/* Exercise 4-14. Define a macro swap(t,x,y) that interchanges two arguments of type t.
 * (Block structure will help.) */
// The block structure is needed because without it, the variable is declared twice.
// And this causes an error during compilation
#include<stdio.h>
#define printd(expr) printf(#expr " %g\n", expr)
#define printi(expr) printf(#expr " %d\n", expr)
#define swap(t, x, y) \
    { \
    t tmp = x; \
    x = y; \
    y = tmp; \
    } 

int main()
{
    double a = 3, b = 5;
    printd(a);
    printd(b);
    swap(double, a, b)
    printd(a);
    printd(b);
    int c = 6, d = 17;
    printi(c);
    printi(d);
    swap(int, c, d)
    printi(c);
    printi(d);
}
#include <ctype.h>
#include <float.h>
#include <stdio.h>

#include "utest.h"
enum Part {
    INT_PART,
    FRACTIONAL_PART,
    EXPONENTIAL_PART,
};
// The conclusion as per the tests is that this program cannot convert the value
// of DBL_MAX in full precision. The program works when the precision of that
// very large number is reduced. For the tests
const double precision = 1e-8;

double _atof(char s[])
{
    // s - Null terminated string.
    // Function returns the double representation of the number.
    //
    // NOTE: This implementation is not 100% correct
    // For example, it does not error when the number is invalid such as sign
    // inbetween number, alphabets within the number, etc.
    //
    int i = 0, sign = 1, exp_sign = 1;
    double converted = 0;
    double power = 1.0;
    int exp_part = 0;

    enum Part part = INT_PART;
    while (s[i] != '\0') {
        // Skip spaces
        if (isspace(s[i])) {
            i++;
            continue;
        }

        // Get the sign (if any)
        if (s[i] == '-') {
            if (part == INT_PART) sign = -sign;
            if (part == EXPONENTIAL_PART) exp_sign = -exp_sign;
        }

        // Get the decimal point (if any)
        if (s[i] == '.') {
            part = FRACTIONAL_PART;
        }

        if (s[i] == 'e' || s[i] == 'E') {
            part = EXPONENTIAL_PART;
        }

        // Process the digits.
        if (isdigit(s[i])) {
            if (part == INT_PART || part == FRACTIONAL_PART)
                converted = converted * 10.0 + (s[i] - '0');
            if (part == FRACTIONAL_PART) {
                power /= 10;
            }
            if (part == EXPONENTIAL_PART) {
                exp_part = exp_part * 10 + (s[i] - '0');
            }
        }
        i++;
    }

    while (exp_part > 0) {
        power = (exp_sign == -1) ? (power / 10.0) : power * 10.0;
        exp_part--;
    }
    /* printf("Exp part:%d\n", exp_part);
     * printf("Power part:%f\n", power);
     * printf("Converted part:%f\n", converted);
     * printf("%s\n","================"); */
    // printf("%f\n", power);
    // printf("%s\n","================");

    return sign * converted * power;
}

UTEST(atof_test, converts_valid_int_part)
{
    ASSERT_NEAR(_atof("52"), 52, precision);
    ASSERT_NEAR(_atof("1234"), 1234, precision);
    ASSERT_NEAR(_atof("321"), 321, precision);
    ASSERT_NEAR(_atof("-121"), -121, precision);
    ASSERT_NEAR(_atof("-52"), -52, precision);
    ASSERT_NEAR(_atof("-65432"), -65432, precision);
    ASSERT_NEAR(_atof("0"), 0, precision);
}

UTEST(atof_test, converts_fractional_part)
{
    ASSERT_NEAR(_atof(".1"), .1, precision);
    ASSERT_NEAR(_atof(".123"), .123, precision);
    ASSERT_NEAR(_atof(".32"), .32, precision);
    ASSERT_NEAR(_atof(".288813"), .288813, precision);

    ASSERT_NEAR(_atof("-.1"), -.1, precision);
    ASSERT_NEAR(_atof("-.123"), -.123, precision);
    ASSERT_NEAR(_atof("-.32"), -.32, precision);
    ASSERT_NEAR(_atof("-.288813"), -.288813, precision);

    ASSERT_NEAR(_atof("0.1"), .1, precision);
    ASSERT_NEAR(_atof("0.123"), .123, precision);
    ASSERT_NEAR(_atof("0.32"), .32, precision);
    ASSERT_NEAR(_atof("0.288813"), .288813, precision);

    ASSERT_NEAR(_atof("-0.1"), -0.1, precision);
    ASSERT_NEAR(_atof("-0.123"), -0.123, precision);
    ASSERT_NEAR(_atof("-0.32"), -0.32, precision);
    ASSERT_NEAR(_atof("-0.288813"), -0.288813, precision);

    ASSERT_NEAR(_atof("0.0"), 0, precision);
    ASSERT_NEAR(_atof(".0"), 0, precision);
}

UTEST(atof_test, converts_string_to_double)
{
    ASSERT_NEAR(_atof("11811.1"), 11811.1, precision);
    ASSERT_NEAR(_atof("99999.123"), 99999.123, precision);
    ASSERT_NEAR(_atof("71231.32"), 71231.32, precision);

    ASSERT_NEAR(_atof("-11811.1"), -11811.1, precision);
    ASSERT_NEAR(_atof("-99999.123"), -99999.123, precision);
    ASSERT_NEAR(_atof("-71231.32"), -71231.32, precision);

    ASSERT_NEAR(_atof("0.0000000001"), 0.0000000001, precision);
    ASSERT_NEAR(_atof("-0.0000000001"), -0.0000000001, precision);
    ASSERT_NEAR(_atof("-0.0000002"), -0.0000002, precision);
    ASSERT_NEAR(_atof("0.000002"), 0.000002, precision);
}

UTEST(atof_test, converts_string_with_exponential_part)
{
    ASSERT_NEAR(_atof("11811.1e3"), 11811.1e3, precision);
    ASSERT_NEAR(_atof("99999.123e4"), 99999.123e4, precision);
    ASSERT_NEAR(_atof("71231.32e6"), 71231.32e6, precision);
    ASSERT_NEAR(_atof("71231.32e-6"), 71231.32e-6, precision);
    // Large negative exponent
    ASSERT_NEAR(_atof("11811.1e-201"), 11811.1e-201, 1e-5);
    ASSERT_NEAR(_atof("312.1234e-153"), 312.1234e-153, 1e-5);
    ASSERT_NEAR(_atof("0.1e-297"), 0.1e-297, 1e-5);

    ASSERT_NEAR(_atof("-11811.1e-201"), -11811.1e-201, 1e-5);
    ASSERT_NEAR(_atof("-312.1234e-153"), -312.1234e-153, 1e-5);
    ASSERT_NEAR(_atof("-0.1e-297"), -0.1e-297, 1e-5);

    // Large positive exponent
    // I have used these high value epsilon because the actual value represented
    // by the double is like 118111000000.....5...000000, so this 5 here causes
    // the test to fail, so I have a larger epsilon value to ignore that.
    ASSERT_NEAR(_atof("11811.1e+201"), 11811.1e201, 1e190);
    ASSERT_NEAR(_atof("312.1234e+153"), 312.1234e+153, 1e143);
    ASSERT_NEAR(_atof("0.1e+297"), 0.1e+297, 1e285);

    ASSERT_NEAR(_atof("-11811.1e+201"), -11811.1e201, 1e190);
    ASSERT_NEAR(_atof("-312.1234e+153"), -312.1234e+153, 1e143);
    ASSERT_NEAR(_atof("-0.1e+297"), -0.1e+297, 1e285);
}

UTEST(atof_test, edge_cases)
{
    // Edge cases of 0
    ASSERT_NEAR(_atof("0"), 0, 1e-8);
    ASSERT_NEAR(_atof("0.0"), 0, 1e-8);
    ASSERT_NEAR(_atof(".0"), 0, 1e-8);
    ASSERT_NEAR(_atof("-0"), 0, 1e-8);
    ASSERT_NEAR(_atof("-0.0"), 0, 1e-8);
    ASSERT_NEAR(_atof("-.0"), 0, 1e-8);

    // Maximum value from float.h
    // The below test case fails and gives a value of 1.#INF00
    // ASSERT_NEAR(_atof("179769313486231570000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.000000"),
    // DBL_MAX, 1e295);
    ASSERT_NEAR(
        _atof("1797693134862315700000000000000000000000000000000000000000000000"
              "0000000000000000000000000000000000000000000000000000000000000000"
              "0000000000000000000000000000000000000000000000000000000000000000"
              "0000000000000000000000000000000000000000000000000000000000000000"
              "00000000000000000000000000000000000000000000000000000"),
        DBL_MAX, 1e295);
    // ASSERT_NEAR(_atof("1.7976931348623157E+308"), DBL_MAX, 1e295);
    ASSERT_NEAR(_atof("1.7976931348623E+308"), DBL_MAX, 1e295);
    ASSERT_NEAR(_atof("-1.7976931348623E+308"), -DBL_MAX, 1e295);
}

UTEST_MAIN();
/*
 * Implementation of a Reverse Polish Notation Calculator.
 * This file has all the exercises from exercise 4-3 to exercise 4-10
 * The book separates the functions into many files, but because I have kept a
 * single file per exercise, I'm doing everything here.
 */

/*
 * Algorithm
 * ==========
 * WHILE the next token is not EOF
 *      IF token type is NUMBER
 *          PUSH into STACK
 *      IF token type is OPERATOR
 *          POP operands and perform operation based on operator.
 *          PUSH result into STACK
 *      IF token type is NEWLINE
 *          POP and return the result.
 */
/*
 * CHANGES wrt to the book
 * 1) I have made the a function, which returns the result instead of directly
 * finding the result from stdin. 2) This allows me to test the code. 3) No
 * getch and ungetch as the program takes a char array as argument.
 */
/*
 * NOTE:
 * For assignment statements, I have used infix notation instead of RPN because
 * it is much easier to implement For example a b 1 + = --> Should be
 * interpreted as a = b + 1 Which is more complex as the program will not know
 * whether the value of a should be set or used.
 * One workaround is to use a token stack, where instead of just storing the
 * values, The program will store the tokens and then decide whether to set or
 * use the value.
 */
#include <assert.h>
#include <ctype.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef enum OPType {
    OP_SIN,
    OP_COS,
    OP_TAN,
    OP_COT,
    OP_EXP,
    OP_POW,
    OP_LOG,
    OP_LOG10,
    OP_LOGN,
    OP_ABS,
    OP_CEIL,
    OP_FLOOR,
    OP_SQRT,
    OP_FACTORIAL,
    OP_MOD,
    OP_BIT_NOT
} OPType;
typedef enum TokenType {
    NUMBER,
    IDENTIFIER,
    // Operators
    PLUS,
    MINUS,
    FORWARD_SLASH,
    STAR,
    MODULUS,
    EXCLAMATION,
    ASSIGNMENT,
    BIT_LSHIFT,  // <<
    BIT_RSHIFT,  // >>
    BIT_AND,     // &
    BIT_OR,      // |
    BIT_NOT,     /// ~
    BIT_XOR,     // ^

    DEBUG_CHAR,  // Temporary Send @ to toggle debug mode

    END_OF_FILE,
    NEWLINE,
    UNKNOWN
} TokenType;

typedef struct Token {
    TokenType type;  // Type of the token
    char* src;       // Pointer to the string which contains the token
    int index;       // Position of token
    int length;      // Length of the token.
} Token;

// GLOBAL Variables here
// ===================================
#define MAX_OPERANDS 1024
#define BUFFER_SIZE 512
#define RADIAN 1
#define DEGREE 2
#define VERSION "1.0.0"
double op_stack[MAX_OPERANDS] = {0}; /* Stack to store the operands */
int sp = -1;                         /* Stack index */
int cp = 0; /* Character index which is the index of the current character to be
               considered*/
char src_string[BUFFER_SIZE] = {'\0'};
char buffer[512] = {'\0'};
/* Temporary buffer to store numbers, to convert them */
// Some config options
int TOKEN_DEBUG_ENABLED = 1; /* Whether to print token details or not */
int err_occured = 0;
int stack_shown = 1;
int show_errors = 1;
int display_prompt = 1;
int clear_screen = 1;
int angle_measure = RADIAN;
int running = 1;
// Only uppercase variables are supported as some math constants are in
// lowercase Add a variable lookup table for 26 variables

double variable_lookup[26] = {0};
int variables_set[26] = {0};
char alphabets[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
// ===================================
// Functions for safely handling the source string
// by including length checks
// These functions consider a null char at the end of src_string, i.e. at index
// BUFFER_SIZE -1 So they check if the index is less than BUFFER_SIZE - 1
//
// Functions
// ===============
// Functions for the operand stack
double valueAt(int n);
int pop(double* var);
int peek(double* var);
int push(double var);
void displayStack();

// Functions for handling the expression string.
char peekChar();
char peekNextChar();
char charAt(int n);
char getChar();
void setChar(char c);

// Function for handling unary, binary and functions
void unaryop(OPType type);
void binaryfunc(OPType type);
void binop(char op);

// Functions related to tokens
Token processIdentifier();
Token processNumber();
void consumeNumber();
Token getNextToken();
void displayToken(Token t);

// Helper functions
long int factorial(int n);
void reset();
int getline_(char buffer_[], int bufferSize);
void clearScreen();
void printHelpMessage();
void displayMemory();

// Main functions
void calculate();
int main();

// Functions to handle configuration of display
void enableDisplay()
{
    stack_shown = 1;
    show_errors = 1;
    display_prompt = 1;
}
void disableDisplay()
{
    stack_shown = 0;
    show_errors = 0;
    display_prompt = 0;
}

void printHelpMessage()
{
    printf("%s %s\n",
           "Welcome to Shankar's RPN (Reverse polish notation) Calculator",
           VERSION);
    printf("%s%s\n", "Version: ", VERSION);
    printf("Max supported length of a single line of input: %d\n", BUFFER_SIZE);
    printf("Max number of operands supported: %d\n", MAX_OPERANDS);
    printf("\n");

    printf("Enter the expression through standard input\n");
    printf("Type \"help\" and press enter to get this help message\n");
    printf("%s\n", "Type @ and press enter to toggle debug mode");
    printf("%s\n", "============================");
    printf("Operators\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "+", "Add two numbers and push result on stack");
    printf("%-16s%s\n", "-",
           "Subtract two numbers and push result on the stack");
    printf("%-16s%s\n", "*",
           "Multiply two numbers and push result on the stack");
    printf("%-16s%s\n", "/", "Divide two numbers and push result on the stack");
    printf("%-16s%s\n", "%",
           "Find the modulus of two numbers and push result on stack");
    printf("%-16s%s\n", "&", "Bitwise AND");
    printf("%-16s%s\n", "|", "Bitwise OR");
    printf("%-16s%s\n", "~", "Bitwise NOT");
    printf("%-16s%s\n", "^", "Bitwise XOR");
    printf("%-16s%s\n", ">>", "Right shift");
    printf("%-16s%s\n", "<<", "Left shift");
    // printf("%-16s%s\n", "", "");
    printf("\n");
    printf("Mathematical functions\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "sin", "Finds the sine of the number");
    printf("%-16s%s\n", "cos",
           "Finds the cosine the of top number of the stack");
    printf("%-16s%s\n", "tan", "Finds the tan of a number");
    printf("%-16s%s\n", "cot", "Finds the cot of a number");
    printf("%-16s%s\n", "exp", "Finds the exp of a number");
    printf("%-16s%s\n", "pow",
           "Finds the value of a raised to b, Example: a b pow");
    printf("%-16s%s\n", "log", "Finds the log of a number, Example: a log");
    printf("%-16s%s\n", "log10",
           "Finds the log to base 10 of a number, Example a log10");
    printf("%-16s%s\n", "logn",
           "Finds the log to base n of a number, Example a b logn is "
           "equivalent to log to base b, a");
    printf("%-16s%s\n", "abs", "Finds the aboslute value of a number");
    printf("%-16s%s\n", "ceil", "Finds the ceil value of a a number");
    printf("%-16s%s\n", "floor", "Finds the floor value of a a number");
    printf("%-16s%s\n", "sqrt", "Finds the square root of a a number");
    printf("%-16s%s\n", "mod",
           "Finds the remainder, Example a b mod is equivalent to a % b");
    printf("\n");
    printf("Mathematical constants\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "e",
           "Pushes the value of e, Euler's number 2.718... on the stack");
    printf("%-16s%s\n", "pi", "Pushes the value of Pi 3.1415.... on the stack");
    printf("\n");
    printf("Commands\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "deg",
           "Sets the program to use degrees for angle measure");
    printf("%-16s%s\n", "rad",
           "Sets the program to use radian for angle measure");
    printf("%-16s%s\n", "exit", "Exits the rpn interactive prompt");
    printf("%-16s%s\n", "quit", "Same as exit, quits the rpn calculator");
    printf("%-16s%s\n", "help", "Prints this help message");
    printf("%-16s%s\n", "dup",
           "Duplicates the element at the top of the stack");
    printf("%-16s%s\n", "peek | print",
           "Prints the value of the top of the stack");
    printf("%-16s%s\n", "pop", "Remove the topmost element from the stack");
    printf("%-16s%s\n", "swap", "Swaps the two topmost elements");
    printf("%-16s%s\n", "mem", "Displays the memory of the calculator");
    printf("%-16s%s\n", "sum", "Finds the sum of all elements of the stack");
    printf("%-16s%s\n", "prod",
           "Finds the product of all elements of the stack");
    printf("%-16s%s\n", "clear", "Clears the stack");
    printf("%-16s%s\n", "clrtop",
           "Clears all elements of stack except top element");
    printf("%-16s%s\n", "clearmem", "Clears the memory of the calculator");
    printf("%-16s%s\n", "show_stack", "Displays stack after every calculation");
    printf("%-16s%s\n", "no_show_stack", "Disables display of stack");
    printf("%-16s%s\n", "debug", "Enables debug mode");
    printf("%-16s%s\n", "no_debug", "Disables debug mode");
    printf("%-16s%s\n", "show_errors", "Displays error (if any)");
    printf("%-16s%s\n", "no_show_errors", "Suppress display of errors");
    printf("%-16s%s\n", "display_prompt", "Displays the >> Before input");
    printf("%-16s%s\n", "no_display_prompt", "Disables display of prompt(>>)");
    printf("%-16s%s\n", "clear_screen", "Clears the screen after every input");
    printf("%-16s%s\n", "no_clear_screen",
           "Disables clearing screen after input");
    printf("%-16s%s\n", "display",
           "Enables display of all information (except debug)\n");
    printf("%-16s%s\n", "no_display",
           "Disables display of all information (except debug)\n");

    printf("\n");
    printf(
        "Sample list of commands when this program's output is used by another "
        "program\n");
    printf(
        "no_debug no_show_errors no_show_stack no_clear_screen "
        "no_display_prompt <expression> pop\n");
    /* printf("%-16s%s\n", "", "");
     * printf("%-16s%s\n", "", ""); */
    printf("\n");
    printf("Variables\n");
    printf("%s\n", "============================");
    printf(
        "This RPN calculator supports variables, you can use variables in any "
        "expression\n");
    printf("Variable names must be single letter long and in uppercase only\n");
    printf("Syntax for setting a variable:\n");
    printf("set <variable_name> = <expression>\n");
    printf("Examples:\n");
    printf("set A = 3 2 +\n");
    printf("The above example sets A to 5\n");
    printf(
        "NOTE: If the expression part is omitted, then the topmost element of "
        "the stack is popped and the variable is set to that value\n");
    printf("Example:\n");
    printf(">> 3 2\n");
    printf(">> set A = \n");
    printf("This sets A to 2 and 2 is removed from the stack\n");
    printf(
        "If the expression part is omitted and the stack is empty, the "
        "variable will assume the value of 0\n");
    // printf("\n");
    // printf("%-16s%s\n", "", "");
    // printf("%-16s%s\n", "", "");
}
char peekChar()
{
    // Gets the character at index cp without incrementing cp.
    if ((cp >= (BUFFER_SIZE - 1)) || (cp < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at peekChar()", cp);
        return '\0';
    }
    return src_string[cp];
}

long int factorial(int n)
{
    int f = 1;
    for (int j = 1; j <= n; j++) f = f * j;
    return f;
}

void clearScreen()
{
    // I couldn't find a proper way of clearing the console
    // (especially for displaying the stack)
    // So this method is slightly portable and works in *nix and windows
    system("cls||clear");
}

void displayStack()
{
    printf("%s\n", "============================");
    for (int k = 0; k <= sp; k++) {
        printf("[%d: ", k);
        // printf("%.*g ", DBL_DECIMAL_DIG, valueAt(k));
        // I am not using DBL_DECIMAL_DIG, as it prints 1.4999999... for 1.5
        printf("%.15g ", valueAt(k));
        printf("%s", " ]\n");
    }
}
void displayMemory()
{
    // printf("%s\n", "============================");
    printf("MEMORY: [");
    for (int i = 0; i < 26; i++) {
        if (variables_set[i]) {
            printf("%c: %.15g ", alphabets[i], variable_lookup[i]);
        }
    }
    printf("]\n");
}

char peekNextChar()
{
    // Gets the next character at index cp+1, without incrementing.
    if (((cp + 1) >= (BUFFER_SIZE - 1)) || ((cp + 1) < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at peekNextChar()", cp + 1);
        return '\0';
    }
    return src_string[cp + 1];
}

double valueAt(int n)
{
    // Gets the character at the given index
    if ((n >= MAX_OPERANDS) || (n < 0)) {
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at valueAt()", n);
        return '\0';
    }
    return op_stack[n];
}

char charAt(int n)
{
    // Gets the operand at the given index from the stack
    if (((n) >= (BUFFER_SIZE - 1)) || ((n) < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at charAt()", n);
        return '\0';
    }
    return src_string[n];
}

char getChar()
{
    // Gets the character at index cp and also increments cp.
    char c = peekChar();
    cp++;
    return c;
}

void setChar(char c)
{
    if ((cp >= (BUFFER_SIZE - 1)) || (cp < 0)) {
        printf("Fatal error: Array index out of bounds %d", cp);
        err_occured = 1;
        return;
    }
    src_string[cp] = c;
}
// ===================================
int pop(double* var)
{
    /*
     * Function which pops an element from the stack and sets the passed element
     * to that value. If the stack is empty, 0 will be returned
     */
    if (sp < 0) {
        if (var) *var = 0;
        return 0;
    }
    else {
        if (var) *var = op_stack[sp--];
        return 1;
    }
}

int peek(double* var)
{
    /*
     * Function which peeks an element from the stack and sets the passed
     * element to that value. If the stack is empty, 0 will be returned
     */
    if (sp < 0) {
        if (var) *var = 0;
        return 0;
    }
    else {
        if (var) *var = op_stack[sp];
        return 1;
    }
}

int push(double var)
{
    /*
     * Function which pushes an element to the stack
     * If the stack is full, 0 will be returned and 1 in case of success
     */
    if (sp == (MAX_OPERANDS - 1)) {
        if (TOKEN_DEBUG_ENABLED)
            printf("%s\n", "[WARNING: Operator stack is full]");
        return 0;
    }
    else {
        op_stack[++sp] = var;
        return 1;
    }
}

void consumeNumber()
{
    // Increments cp until the character at that index is not a number.
    while (isdigit(peekChar())) {
        cp++;
    }
}

Token processIdentifier()
{
    int tmp = cp;
    if (peekChar() == '_') cp++;
    while (isalnum(peekChar()) || peekChar() == '_') {
        cp++;
    }
    return (Token){IDENTIFIER, src_string, tmp, cp - tmp};
}

Token processNumber()
{
    // Tries to find a number from the index cp in src_string
    // At the first non numeric character(except dot), the function returns.
    int tmp = cp;
    if (peekChar() == '-') {
        // Negative number
        cp++;
    }

    consumeNumber();

    if (peekChar() == '.') {
        // Decimal number
        cp++;
        consumeNumber();
    }
    if (peekChar() == 'e' || peekChar() == 'e') {
        // Exponential notation.
        cp++;
        consumeNumber();
        // Handle negative number of exponents
        if (peekChar() == '-') {
            cp++;
            consumeNumber();
        }
    }
    // cp - tmp is the length of the token.
    return (Token){NUMBER, src_string, tmp, cp - tmp};
}

Token getNextToken()
{
    // This function works like a lexer, it takes the input string and returns
    // tokens.
    if (cp == -1) return (Token){END_OF_FILE, src_string, cp, 0};

    while (peekChar() != '\0') {
        // Ignore whitespaces and tabs
        if (peekChar() == ' ' || peekChar() == '\t') {
            cp++;
            continue;
        }

        // Debug char
        if (peekChar() == '@') {
            TOKEN_DEBUG_ENABLED = TOKEN_DEBUG_ENABLED ? 0 : 1;
            cp++;
            continue;
        }
        // Single character tokens
        if (peekChar() == '*') return (Token){STAR, src_string, cp++, 1};
        if (peekChar() == '/')
            return (Token){FORWARD_SLASH, src_string, cp++, 1};
        if (peekChar() == '+') return (Token){PLUS, src_string, cp++, 1};
        if (peekChar() == '%') return (Token){MODULUS, src_string, cp++, 1};
        if (peekChar() == '!') return (Token){EXCLAMATION, src_string, cp++, 1};
        if (peekChar() == '=') return (Token){ASSIGNMENT, src_string, cp++, 1};

        if (peekChar() == '&') return (Token){BIT_AND, src_string, cp++, 1};
        if (peekChar() == '|') return (Token){BIT_OR, src_string, cp++, 1};
        if (peekChar() == '~') return (Token){BIT_NOT, src_string, cp++, 1};
        if (peekChar() == '^') return (Token){BIT_XOR, src_string, cp++, 1};

        if (peekChar() == '>' && peekNextChar() == '>')
            return (Token){BIT_RSHIFT, src_string, cp++, 1};
        if (peekChar() == '<' && peekNextChar() == '<')
            return (Token){BIT_LSHIFT, src_string, cp++, 1};
        if (peekChar() == '-') {
            if (isdigit(peekNextChar())) {
                // If the next character after minus is a digit
                // It is a negative number
                return processNumber();
            }
            else {
                return (Token){MINUS, src_string, cp++, 1};
            }
        }
        if (peekChar() == '\n') return (Token){NEWLINE, src_string, cp++, 1};

        // Multi character tokens like numbers or variables
        else {
            // Handle numbers
            if (isdigit(peekChar())) {
                return processNumber();
            }
            // Handle identifers
            // Identifier is defined as a sequence of alphanumeric characters
            // starting with underscore or an alphabet
            if (isalpha(peekChar()) || peekChar() == '_') {
                return processIdentifier();
            }
            return (Token){UNKNOWN, src_string, cp++, 1};
        }
    }
    cp = -1;
    return (Token){END_OF_FILE, src_string, cp, 0};
}

void reset()
{
    // Resets all variables to initial state
    // Reset stack pointer if you want to clear the state
    // I want the elements of the stack to remain
    sp = -1;
    cp = 0;
    memset(src_string, 0, sizeof(src_string));
    err_occured = 0;
}

void displayToken(Token t)
{
    putchar('<');
    switch (t.type) {
        // I know, this is ugly, but I dont want to do dynamic memory
        // allocation.
        case NUMBER:
            printf("%s", "NUMBER");
            break;
        case IDENTIFIER:
            printf("%s", "IDENTIFIER");
            break;
        case PLUS:
            printf("%s", "PLUS");
            break;
        case MINUS:
            printf("%s", "MINUS");
            break;
        case FORWARD_SLASH:
            printf("%s", "SLASH");
            break;
        case STAR:
            printf("%s", "STAR");
            break;
        case MODULUS:
            printf("%s", "MODULUS");
            break;
        case EXCLAMATION:
            printf("%s", "EXCLAMATION");
            break;
        case ASSIGNMENT:
            printf("%s", "ASSIGNMENT");
            break;
        case END_OF_FILE:
            printf("%s>\n", "EOF");
            // Returns for EOF as it is not printable
            return;
        case NEWLINE:
            printf("%s>\n", "EOL");
            // Returns for EOF as it is not printable
            return;
        case UNKNOWN:
            printf("%s", "UKNWN");
            break;
        default:
            printf("%s", "*UKNWN");
            break;
    }
    // Add a space
    putchar(' ');

    if (t.length == 1) {
        // Code for handling single character tokens only.
        printf("%c", t.src[t.index]);
    }
    else {
        for (int i = 0; i < t.length; i++) {
            assert((t.index + i) < (BUFFER_SIZE - 1));
            assert((t.index + i) >= 0);
            putchar(t.src[t.index + i]);
        }
    }

    putchar('>');
    putchar('\n');
}

void unaryop(OPType type)
{
    // Function to handle functions or operators which take a single operand
    // like sin, cos, etc.
    double rhs, result = 0;
    // Only for trigonometric functions
    if (!pop(&rhs)) {
        if (show_errors)
            printf(
                "ERROR: Not enough operands for the given function/operator\n");
        err_occured = 1;
        return;
    }
    double trig_rhs =
        (angle_measure == RADIAN) ? rhs : (3.1415926535 / 180) * rhs;
    switch (type) {
        case OP_SIN:
            result = sin(trig_rhs);
            break;
        case OP_COS:
            result = cos(trig_rhs);
            break;
        case OP_TAN:
            result = tan(trig_rhs);
            break;
        case OP_EXP:
            result = exp(trig_rhs);
            break;
        case OP_COT:
            result = cos(trig_rhs) / sin(trig_rhs);
            break;
        case OP_LOG:
            result = log(rhs);
            break;
        case OP_LOG10:
            result = log10(rhs);
            break;
        case OP_SQRT:
            if (rhs < 0) {
                if (show_errors)
                    printf("%s\n", "ERROR: Square root of negative number");
                err_occured = 1;
                push(rhs);
                return;
            }
            result = sqrt(rhs);
            break;
        case OP_ABS:
            result = fabs(rhs);
            break;
        case OP_CEIL:
            result = ceil(rhs);
            break;
        case OP_FLOOR:
            result = floor(rhs);
            break;
        case OP_FACTORIAL:
            result = (double)(factorial((int)rhs));
            break;
        case OP_BIT_NOT:
            result = ~(int)rhs;
            break;
        default:
            if (show_errors)
                printf("%s\n", "INTERNAL ERROR: Unknown unary operator");
            err_occured = 1;
            return;
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full");
        err_occured = 1;
        return;
    }
}

void binaryfunc(OPType type)
{
    double result = 0, lhs, rhs;
    int rhs_success = 0;

    if (!pop(&rhs)) {
        if (show_errors)
            printf("ERROR: Not enough operands for function taking 2 args\n");
        err_occured = 1;
        return;
    }
    // If control has come here, it means that pop(&rhs) didn't fail
    rhs_success = 1;
    if (!pop(&lhs)) {
        if (rhs_success) push(rhs);
        if (show_errors)
            printf("ERROR: Not enough operands for function taking 2 args\n");
        err_occured = 1;
        return;
    }

    if (type == OP_POW) {
        result = pow(lhs, rhs);
    }
    if (type == OP_MOD) {
        result = fmod(lhs, rhs);
    }
    if (type == OP_LOGN) {
        result = log(lhs) / log(rhs);
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full, Internal error");
        err_occured = 1;
        return;
    }
}

void binop(char op)
{
    // Function to handle operators which expect two operands such as +, - etc
    double result = 0, lhs, rhs;
    int rhs_success = 0;

    if (!pop(&rhs)) {
        if (show_errors)
            printf("ERROR: Not enough operands for operator '%c' (rhs)\n", op);
        err_occured = 1;
        return;
    }
    // If control has come here, it means that pop(&rhs) didn't fail
    rhs_success = 1;
    if (!pop(&lhs)) {
        // Suppose the input was 32 +
        // The program pops 32 and stores it in a variable
        // But it errors here as there is no lhs
        // So in this case, we have to push back that 32 (or whatever number)
        if (rhs_success) push(rhs);
        if (show_errors)
            printf("ERROR: Not enough operands for operator '%c' (lhs)\n", op);
        err_occured = 1;
        return;
    }

    switch (op) {
        case '+':
            result = lhs + rhs;
            break;
        case '-':
            result = lhs - rhs;
            break;
        case '*':
            result = lhs * rhs;
            break;
        // For these bitwise operators, the double is converted to int first
        case '&':
            result = (int)lhs & (int)rhs;
            break;
        case '|':
            result = (int)lhs | (int)rhs;
            break;
        case '^':
            result = (int)lhs ^ (int)rhs;
            break;
        case 'R':
            result = (int)lhs >> (int)rhs;
            break;
        case 'L':
            result = (int)lhs << (int)rhs;
            break;
        case '/':
            if (fabs(rhs) <= 1e-50) {
                if (show_errors) printf("%s\n", "ERROR: Division by zero");
                err_occured = 1;
                return;
            }
            else {
                result = lhs / rhs;
            }
            break;
        case '%':
            if (fabs(rhs) <= 1e-50) {
                if (show_errors) printf("%s\n", "ERROR: Modulus by zero");
                err_occured = 1;
                return;
            }
            else {
                // Using fmod instead of modulus operator because the all values
                // are represented as double.
                result = fmod(lhs, rhs);
            }
            break;

        default:
            if (show_errors) printf("ERROR: Unknown operator (%c) \n", op);
            err_occured = 1;
            break;
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full, Internal error");
        err_occured = 1;
        return;
    }
}

void calculate()
{
    // Function calculates the value of the expression
    // Make sure to call reset() after calling this function
    // To reset the index variables and state
    Token t;
    int i;
    // var for temporary usage
    double var;
    do {
        if (err_occured) {
            // If any error had occured, do not continue scanning
            return;
        }
        t = getNextToken();
        if (t.type == UNKNOWN) {
            if (show_errors)
                printf("ERROR: Uknown character (%c) at index %d in input\n",
                       t.src[t.index], t.index);
            err_occured = 1;
            return;
        }
        else {
            switch (t.type) {
                case NUMBER:
                    for (i = 0; i < t.length; i++) {
                        assert((t.index + i) < (BUFFER_SIZE - 1));
                        assert((t.index + i) >= 0);
                        buffer[i] = t.src[t.index + i];
                    }
                    buffer[i] = '\0';
                    if (!push(atof(buffer))) {
                        if (show_errors)
                            printf("ERROR: %s\n",
                                   "Stack is full, Internal error");
                        err_occured = 1;
                        return;
                    }
                    break;
                case IDENTIFIER:
                    /* I removed all returns from the if statements and
                     * converted the if statements to else if. Using the return
                     * statements, I could not evaluate 2 sqrt floor Or the like
                     * of functions
                     */
                    // Copy to temporary buffer to do manipulations
                    for (i = 0; i < t.length; i++) {
                        assert((t.index + i) < (BUFFER_SIZE - 1));
                        assert((t.index + i) >= 0);
                        buffer[i] = t.src[t.index + i];
                    }
                    buffer[i] = '\0';

                    // Handle some variables such as e and pi
                    if (strcmp(buffer, "pi") == 0) {
                        if (!push(3.14159265358)) {
                            if (show_errors)
                                printf("ERROR: %s\n", "Stack is full");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "e") == 0) {
                        if (!push(2.71828182845))

                        {
                            if (show_errors)
                                printf("ERROR: %s\n", "Stack is full");
                            err_occured = 1;
                            return;
                        }
                    }

                    // Handle some commands
                    else if (strcmp(buffer, "exit") == 0 ||
                             strcmp(buffer, "quit") == 0) {
                        running = 0;
                    }
                    else if (strcmp(buffer, "help") == 0) {
                        printHelpMessage();
                    }
                    else if (strcmp(buffer, "dup") == 0) {
                        if (!peek(&var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to duplicate element as "
                                       "stack "
                                       "is empty");
                            err_occured = 1;
                            return;
                        }
                        if (!push(var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to duplicate element as "
                                       "stack is full");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "peek") == 0 ||
                             strcmp(buffer, "print") == 0) {
                        peek(&var);
                        printf("%.15g\n", var);
                    }
                    else if (strcmp(buffer, "pop") == 0) {
                        if (!pop(&var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to pop element as "
                                       "stack is empty");
                            err_occured = 1;
                            return;
                        }
                        printf("%.15g\n", var);
                    }
                    else if (strcmp(buffer, "rad") == 0) {
                        angle_measure = RADIAN;
                    }
                    else if (strcmp(buffer, "deg") == 0) {
                        angle_measure = DEGREE;
                    }
                    else if (strcmp(buffer, "show_stack") == 0) {
                        stack_shown = 1;
                    }
                    else if (strcmp(buffer, "no_show_stack") == 0) {
                        stack_shown = 0;
                    }
                    else if (strcmp(buffer, "clear_screen") == 0) {
                        clear_screen = 1;
                    }
                    else if (strcmp(buffer, "no_clear_screen") == 0) {
                        clear_screen = 0;
                    }
                    else if (strcmp(buffer, "display_prompt") == 0) {
                        display_prompt = 1;
                    }
                    else if (strcmp(buffer, "no_display_prompt") == 0) {
                        display_prompt = 0;
                    }
                    else if (strcmp(buffer, "debug") == 0) {
                        TOKEN_DEBUG_ENABLED = 1;
                    }
                    else if (strcmp(buffer, "no_debug") == 0) {
                        TOKEN_DEBUG_ENABLED = 0;
                    }
                    else if (strcmp(buffer, "show_errors") == 0) {
                        show_errors = 1;
                    }
                    else if (strcmp(buffer, "no_show_errors") == 0) {
                        show_errors = 0;
                    }
                    else if (strcmp(buffer, "display") == 0) {
                        // Enables display of everything
                        enableDisplay();
                    }
                    else if (strcmp(buffer, "no_display") == 0) {
                        disableDisplay();
                    }

                    else if (strcmp(buffer, "swap") == 0) {
                        // Stack: a b c d e f
                        // v1 = f
                        // v2 = e
                        // After pushing back again
                        // a b c f e
                        // The elements are swapped
                        double v1, v2;
                        int v1_success = 0;
                        if (!pop(&v1)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to swap as "
                                       "there are not enough elements");
                            err_occured = 1;
                            return;
                        }
                        v1_success = 1;
                        if (!pop(&v2)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to swap as "
                                       "there are not enough elements");
                            err_occured = 1;
                            if (v1_success) {
                                // One element has already been popped out.
                                // Push it back into the stack
                                push(v1);
                            }
                            return;
                        }
                        // No need to check if the stack is full because on
                        // calling pop() twice above, there will be 2 spaces
                        push(v1);
                        push(v2);
                    }
                    else if (strcmp(buffer, "clear") == 0) {
                        sp = -1;
                    }
                    else if (strcmp(buffer, "mem") == 0) {
                        displayMemory();
                    }
                    else if (strcmp(buffer, "clearmem") == 0) {
                        for (int j = 0; j < 26; j++) {
                            variable_lookup[j] = 0;  // Might not be necessary
                            variables_set[j] = 0;
                        }
                    }

                    // Handle math functions
                    else if (strcmp(buffer, "sin") == 0) {
                        unaryop(OP_SIN);
                    }
                    else if (strcmp(buffer, "cos") == 0) {
                        unaryop(OP_COS);
                    }
                    else if (strcmp(buffer, "tan") == 0) {
                        unaryop(OP_TAN);
                    }
                    else if (strcmp(buffer, "cot") == 0) {
                        unaryop(OP_COT);
                    }
                    else if (strcmp(buffer, "exp") == 0) {
                        unaryop(OP_EXP);
                    }

                    else if (strcmp(buffer, "log") == 0) {
                        unaryop(OP_LOG);
                    }
                    else if (strcmp(buffer, "log10") == 0) {
                        unaryop(OP_LOG10);
                    }
                    else if (strcmp(buffer, "abs") == 0) {
                        unaryop(OP_ABS);
                    }
                    else if (strcmp(buffer, "ceil") == 0) {
                        unaryop(OP_CEIL);
                    }
                    else if (strcmp(buffer, "floor") == 0) {
                        unaryop(OP_FLOOR);
                    }
                    else if (strcmp(buffer, "sqrt") == 0) {
                        unaryop(OP_SQRT);
                    }
                    else if (strcmp(buffer, "logn") == 0) {
                        binaryfunc(OP_LOGN);
                    }
                    else if (strcmp(buffer, "mod") == 0) {
                        binaryfunc(OP_MOD);
                    }
                    else if (strcmp(buffer, "pow") == 0) {
                        binaryfunc(OP_POW);
                    }
                    else if (strcmp(buffer, "sum") == 0) {
                        double result = 0;
                        for (int k = 0; k <= sp; k++) {
                            result += valueAt(k);
                        }
                        if (!push(result)) {
                            if (show_errors)
                                printf(
                                    "ERROR: Can't find sum of numbers because "
                                    "stack is full\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "prod") == 0) {
                        double result = 1;
                        for (int k = 0; k <= sp; k++) {
                            result *= valueAt(k);
                        }
                        if (!push(result)) {
                            if (show_errors)
                                printf(
                                    "ERROR: Can't find product of numbers "
                                    "because "
                                    "stack is full\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "clrtop") == 0) {
                        // Clears all elements of stack except top
                        if (sp > 0) {
                            double tmp = valueAt(sp);
                            sp = -1;
                            push(tmp);
                        }
                        else {
                            printf(
                                "WARN: clrtop failed as there are no elements "
                                "in the stack\n");
                        }
                    }

                    // Handle set command
                    else if (strcmp(buffer, "set") == 0)
                    {
                        // Example:
                        // set a = <expression>
                        // set a = 3 2 +  ----> Sets a to 5
                        // Grammer:
                        // set "single letter variable name" = "expression"
                        Token t2 = getNextToken();
                        Token t3;
                        if (t2.type == IDENTIFIER && t2.length == 1 &&
                            isupper(t2.src[t2.index])) {
                            t3 = getNextToken();
                            if (t3.type == ASSIGNMENT) {
                                calculate();
                                if (!err_occured) {
                                    double vars = 0;
                                    char ch = t2.src[t2.index];
                                    assert((ch - 'A') >= 0);
                                    assert((ch - 'A') < 26);

                                    pop(&vars);
                                    printf("Set the value of %c to %.15g\n", ch,
                                           vars);
                                    variable_lookup[ch - 'A'] = vars;
                                    variables_set[ch - 'A'] = 1;
                                }
                                else {
                                    if (show_errors)
                                        printf(
                                            "ERROR: Error occured on rhs "
                                            "expression\n");
                                }
                            }
                            else {
                                if (show_errors)
                                    printf("%s\n",
                                           "ERROR~~: Invalid use of set, no =");
                                cp = t2.index;
                                err_occured = 1;
                                return;
                            }
                        }
                        else {
                            if (show_errors)
                                printf(
                                    "%s\n",
                                    "ERROR~~: Invalid use of set, no variable "
                                    "after set command, or variable is not "
                                    "single uppercase letter");
                            cp = t2.index;
                            err_occured = 1;
                            return;
                        }
                    }

                    // Handle single letter variables
                    // Only uppercase variables are supported as some math
                    // constants are in lowercase
                    else if (t.length == 1)
                    {
                        if (t.src[t.index] >= 'A' && t.src[t.index] <= 'Z') {
                            int index = (int)(t.src[t.index] - 'A');
                            assert(index >= 0 && index < 26);
                            if (!variables_set[index]) {
                                if (show_errors)
                                    printf("ERROR: Variable %c not set\n",
                                           t.src[t.index]);
                                err_occured = 1;
                                return;
                            }
                            if (!push(variable_lookup[index])) {
                                if (show_errors)
                                    printf(
                                        "ERROR: Stack is full, unable to "
                                        "dereference variable\n");
                                err_occured = 1;
                                return;
                            }
                        }
                        else {
                            if (show_errors)
                                printf(
                                    "ERROR: Only uppercase variables are "
                                    "supported\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else
                    {
                        err_occured = 1;
                        printf("%s%s\n",
                               "Error: Unknown identifier or function - ",
                               buffer);
                        printf("%s\n",
                               "Type \"help\" to view all supported commands");
                        printf("%s\n",
                               "If you meant to assign a variable, only single "
                               "character variables are supported");
                        return;
                    }
                    break;

                case PLUS:
                    binop('+');
                    break;

                case MINUS:
                    binop('-');
                    break;

                case STAR:
                    binop('*');
                    break;

                case FORWARD_SLASH:
                    binop('/');
                    break;

                case MODULUS:
                    binop('%');
                    break;

                case EXCLAMATION:
                    unaryop(OP_FACTORIAL);
                    break;

                case BIT_LSHIFT:
                    binop('L');
                    break;
                case BIT_RSHIFT:
                    binop('R');
                    break;
                case BIT_AND:
                    binop('&');
                    break;
                case BIT_OR:
                    binop('|');
                    break;
                case BIT_NOT:
                    unaryop(OP_BIT_NOT);
                    break;
                case BIT_XOR:
                    binop('^');
                    break;

                case NEWLINE:
                case END_OF_FILE:
                    break;

                default:
                    printf("%s\n", "UNHANDLED");
            }
        }
        if (TOKEN_DEBUG_ENABLED) displayToken(t);
    } while (t.type != END_OF_FILE);
}

int getline_(char buffer_[], int bufferSize)
{
    int bufferIndex = 0, ch;
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        buffer_[bufferIndex++] = (char)ch;
        if (ch == '\n') break;
    }
    buffer_[bufferIndex] = '\0';
    return bufferIndex;
}


int main()
{
    int length;
    if (clear_screen) clearScreen();
    printf("%s %s\n",
           "Welcome to Shankar's RPN (Reverse polish notation) Calculator",
           VERSION);
    printf("Max supported length of a single line of input: %d\n", BUFFER_SIZE);
    printf("Max number of operands supported: %d\n", MAX_OPERANDS);
    printf(
        "$ rpn    - runs this calculator in interactive mode, Enter the "
        "expression through standard input\n");
    printf("%s\n", "Type @ and press enter to toggle debug mode");
    printf("Type \"help\" and press enter to get help\n");
    if (display_prompt) printf("%s", ">>");
    while ((length = getline_(src_string, 512))) {
        if (clear_screen) clearScreen();
        calculate();
        if (!running) {
            if (clear_screen) clearScreen();
            if (stack_shown) displayStack();
            break;
        }
        if (stack_shown) displayStack();
        // reset();
        cp = 0;
        err_occured = 0;
        if (display_prompt) printf("%s", ">>");
    }
}
// Sample formulae
// Formula to find the roots of a quadratic equation (set A, B, and C before)
// B -1 * B 2 pow 4 A * C * - sqrt + 2 A * /
// B -1 * B 2 pow 4 A * C * + sqrt + 2 A * /
//
// Example:
// set A = 1
// set B = -2
// set C = -3
//
/* Exercise 5-1. As written, getint treats a + or - not followed by a digit as a
 * valid representation of zero. Fix it to push such a character back on the
 * input. */
#include <ctype.h>
#include <stdio.h>
#define getch() (cp > 0) ? (charbuffer[--cp]) : getchar()
#define ungetch(ch)                                                 \
    if (cp >= CHARBUFFSIZE)                                         \
        printf("Temporary buffer stack is full, cant push back\n"); \
    else                                                            \
        charbuffer[cp++] = (char)ch;

#define CHARBUFFSIZE 100
int cp = 0;
char charbuffer[CHARBUFFSIZE] = {'\0'};
// cp is the index for the next free space in the stack
// The other way to implement this is to set cp to -1 when the stack is empty.

int getint(int *pn)
{
    int ch, sign = 1, ch2;
    // Skip spaces
    while (isspace(ch = getch()))
        ;

    // Check if the current char is part of a number
    if (!(isdigit(ch) || ch == '+' || ch == '-' || ch == '.')) {
        ungetch(ch) return 0;
    }

    sign = (ch == '-') ? -1 : 1;
    if (ch == '-' || ch == '+') {
        ch2 = getch();
        if (!isdigit(ch2)) {
            // Example +a, This program uses it as valid representation of 0.
            ungetch(ch2) ungetch(ch) return 0;
        }
        ch = ch2;
    }

    for (*pn = 0; isdigit(ch); ch = getch()) {
        *pn = 10 * *pn + (ch - '0');
    }
    *pn *= sign;
    if (ch != EOF) {
        ungetch(ch)
    }
    return ch;
}
int main()
{
    int var = 0;
    // int var2 = 0;
    int i = getint(&var);
    // int j = getint(&var2);
    printf("%c\n", getch());
    printf("%d\n", var);
    // printf("%d\n", var2);
}
/* Exercise 5-10. Write the program expr, which evaluates a reverse Polish
 * expression from the command line, where each operator or operand is a
 * separate argument. For example, expr 2 3 4 + * evaluates 2 * (3+4). */

// Copied from exercise-4-3-10.c
/*
 * Implementation of a Reverse Polish Notation Calculator.
 * This file has all the exercises from exercise 4-3 to exercise 4-10
 * The book separates the functions into many files, but because I have kept a
 * single file per exercise, I'm doing everything here.
 */

/*
 * Algorithm
 * ==========
 * WHILE the next token is not EOF
 *      IF token type is NUMBER
 *          PUSH into STACK
 *      IF token type is OPERATOR
 *          POP operands and perform operation based on operator.
 *          PUSH result into STACK
 *      IF token type is NEWLINE
 *          POP and return the result.
 */
/*
 * CHANGES wrt to the book
 * 1) I have made the a function, which returns the result instead of directly
 * finding the result from stdin. 2) This allows me to test the code. 3) No
 * getch and ungetch as the program takes a char array as argument.
 */
/*
 * NOTE:
 * For assignment statements, I have used infix notation instead of RPN because
 * it is much easier to implement For example a b 1 + = --> Should be
 * interpreted as a = b + 1 Which is more complex as the program will not know
 * whether the value of a should be set or used.
 * One workaround is to use a token stack, where instead of just storing the
 * values, The program will store the tokens and then decide whether to set or
 * use the value.
 */
#include <assert.h>
#include <ctype.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef enum OPType {
    OP_SIN,
    OP_COS,
    OP_TAN,
    OP_COT,
    OP_EXP,
    OP_POW,
    OP_LOG,
    OP_LOG10,
    OP_LOGN,
    OP_ABS,
    OP_CEIL,
    OP_FLOOR,
    OP_SQRT,
    OP_FACTORIAL,
    OP_MOD,
    OP_BIT_NOT
} OPType;
typedef enum TokenType {
    NUMBER,
    IDENTIFIER,
    // Operators
    PLUS,
    MINUS,
    FORWARD_SLASH,
    STAR,
    MODULUS,
    EXCLAMATION,
    ASSIGNMENT,
    BIT_LSHIFT,  // <<
    BIT_RSHIFT,  // >>
    BIT_AND,     // &
    BIT_OR,      // |
    BIT_NOT,     /// ~
    BIT_XOR,     // ^

    DEBUG_CHAR,  // Temporary Send @ to toggle debug mode

    END_OF_FILE,
    NEWLINE,
    UNKNOWN
} TokenType;

typedef struct Token {
    TokenType type;  // Type of the token
    char* src;       // Pointer to the string which contains the token
    int index;       // Position of token
    int length;      // Length of the token.
} Token;

// GLOBAL Variables here
// ===================================
#define MAX_OPERANDS 1024
#define BUFFER_SIZE 512
#define RADIAN 1
#define DEGREE 2
#define VERSION "1.0.0"
double op_stack[MAX_OPERANDS] = {0}; /* Stack to store the operands */
int sp = -1;                         /* Stack index */
int cp = 0; /* Character index which is the index of the current character to be
               considered*/
char src_string[BUFFER_SIZE] = {'\0'};
char buffer[512] = {'\0'};
/* Temporary buffer to store numbers, to convert them */
// Some config options
int TOKEN_DEBUG_ENABLED = 1; /* Whether to print token details or not */
int err_occured = 0;
int stack_shown = 1;
int show_errors = 1;
int display_prompt = 1;
int clear_screen = 1;
int angle_measure = RADIAN;
int running = 1;
// Only uppercase variables are supported as some math constants are in
// lowercase Add a variable lookup table for 26 variables

double variable_lookup[26] = {0};
int variables_set[26] = {0};
char alphabets[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
// ===================================
// Functions for safely handling the source string
// by including length checks
// These functions consider a null char at the end of src_string, i.e. at index
// BUFFER_SIZE -1 So they check if the index is less than BUFFER_SIZE - 1
//
// Functions
// ===============
// Functions for the operand stack
double valueAt(int n);
int pop(double* var);
int peek(double* var);
int push(double var);
void displayStack();

// Functions for handling the expression string.
char peekChar();
char peekNextChar();
char charAt(int n);
char getChar();
void setChar(char c);

// Function for handling unary, binary and functions
void unaryop(OPType type);
void binaryfunc(OPType type);
void binop(char op);

// Functions related to tokens
Token processIdentifier();
Token processNumber();
void consumeNumber();
Token getNextToken();
void displayToken(Token t);

// Helper functions
long int factorial(int n);
void reset();
int getline_(char buffer_[], int bufferSize);
void clearScreen();
void printHelpMessage();
void displayMemory();

// Main functions
void calculate();
int main();

// Functions to handle configuration of display
void enableDisplay()
{
    stack_shown = 1;
    show_errors = 1;
    display_prompt = 1;
}
void disableDisplay()
{
    stack_shown = 0;
    show_errors = 0;
    display_prompt = 0;
}

void printHelpMessage()
{
    printf("%s %s\n",
           "Welcome to Shankar's RPN (Reverse polish notation) Calculator",
           VERSION);
    printf("%s%s\n", "Version: ", VERSION);
    printf("Max supported length of a single line of input: %d\n", BUFFER_SIZE);
    printf("Max number of operands supported: %d\n", MAX_OPERANDS);
    printf("\n");

    printf("Enter the expression through standard input\n");
    printf("Type \"help\" and press enter to get this help message\n");
    printf("%s\n", "Type @ and press enter to toggle debug mode");
    printf("%s\n", "============================");
    printf("Operators\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "+", "Add two numbers and push result on stack");
    printf("%-16s%s\n", "-",
           "Subtract two numbers and push result on the stack");
    printf("%-16s%s\n", "*",
           "Multiply two numbers and push result on the stack");
    printf("%-16s%s\n", "/", "Divide two numbers and push result on the stack");
    printf("%-16s%s\n", "%",
           "Find the modulus of two numbers and push result on stack");
    printf("%-16s%s\n", "&", "Bitwise AND");
    printf("%-16s%s\n", "|", "Bitwise OR");
    printf("%-16s%s\n", "~", "Bitwise NOT");
    printf("%-16s%s\n", "^", "Bitwise XOR");
    printf("%-16s%s\n", ">>", "Right shift");
    printf("%-16s%s\n", "<<", "Left shift");
    // printf("%-16s%s\n", "", "");
    printf("\n");
    printf("Mathematical functions\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "sin", "Finds the sine of the number");
    printf("%-16s%s\n", "cos",
           "Finds the cosine the of top number of the stack");
    printf("%-16s%s\n", "tan", "Finds the tan of a number");
    printf("%-16s%s\n", "cot", "Finds the cot of a number");
    printf("%-16s%s\n", "exp", "Finds the exp of a number");
    printf("%-16s%s\n", "pow",
           "Finds the value of a raised to b, Example: a b pow");
    printf("%-16s%s\n", "log", "Finds the log of a number, Example: a log");
    printf("%-16s%s\n", "log10",
           "Finds the log to base 10 of a number, Example a log10");
    printf("%-16s%s\n", "logn",
           "Finds the log to base n of a number, Example a b logn is "
           "equivalent to log to base b, a");
    printf("%-16s%s\n", "abs", "Finds the aboslute value of a number");
    printf("%-16s%s\n", "ceil", "Finds the ceil value of a a number");
    printf("%-16s%s\n", "floor", "Finds the floor value of a a number");
    printf("%-16s%s\n", "sqrt", "Finds the square root of a a number");
    printf("%-16s%s\n", "mod",
           "Finds the remainder, Example a b mod is equivalent to a % b");
    printf("\n");
    printf("Mathematical constants\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "e",
           "Pushes the value of e, Euler's number 2.718... on the stack");
    printf("%-16s%s\n", "pi", "Pushes the value of Pi 3.1415.... on the stack");
    printf("\n");
    printf("Commands\n");
    printf("%s\n", "============================");
    printf("%-16s%s\n", "deg",
           "Sets the program to use degrees for angle measure");
    printf("%-16s%s\n", "rad",
           "Sets the program to use radian for angle measure");
    printf("%-16s%s\n", "exit", "Exits the rpn interactive prompt");
    printf("%-16s%s\n", "quit", "Same as exit, quits the rpn calculator");
    printf("%-16s%s\n", "help", "Prints this help message");
    printf("%-16s%s\n", "dup",
           "Duplicates the element at the top of the stack");
    printf("%-16s%s\n", "peek | print",
           "Prints the value of the top of the stack");
    printf("%-16s%s\n", "pop", "Remove the topmost element from the stack");
    printf("%-16s%s\n", "swap", "Swaps the two topmost elements");
    printf("%-16s%s\n", "mem", "Displays the memory of the calculator");
    printf("%-16s%s\n", "sum", "Finds the sum of all elements of the stack");
    printf("%-16s%s\n", "prod",
           "Finds the product of all elements of the stack");
    printf("%-16s%s\n", "clear", "Clears the stack");
    printf("%-16s%s\n", "clrtop",
           "Clears all elements of stack except top element");
    printf("%-16s%s\n", "clearmem", "Clears the memory of the calculator");
    printf("%-16s%s\n", "show_stack", "Displays stack after every calculation");
    printf("%-16s%s\n", "no_show_stack", "Disables display of stack");
    printf("%-16s%s\n", "debug", "Enables debug mode");
    printf("%-16s%s\n", "no_debug", "Disables debug mode");
    printf("%-16s%s\n", "show_errors", "Displays error (if any)");
    printf("%-16s%s\n", "no_show_errors", "Suppress display of errors");
    printf("%-16s%s\n", "display_prompt", "Displays the >> Before input");
    printf("%-16s%s\n", "no_display_prompt", "Disables display of prompt(>>)");
    printf("%-16s%s\n", "clear_screen", "Clears the screen after every input");
    printf("%-16s%s\n", "no_clear_screen",
           "Disables clearing screen after input");
    printf("%-16s%s\n", "display",
           "Enables display of all information (except debug)\n");
    printf("%-16s%s\n", "no_display",
           "Disables display of all information (except debug)\n");

    printf("\n");
    printf(
        "Sample list of commands when this program's output is used by another "
        "program\n");
    printf(
        "no_debug no_show_errors no_show_stack no_clear_screen "
        "no_display_prompt <expression> pop\n");
    /* printf("%-16s%s\n", "", "");
     * printf("%-16s%s\n", "", ""); */
    printf("\n");
    printf("Variables\n");
    printf("%s\n", "============================");
    printf(
        "This RPN calculator supports variables, you can use variables in any "
        "expression\n");
    printf("Variable names must be single letter long and in uppercase only\n");
    printf("Syntax for setting a variable:\n");
    printf("set <variable_name> = <expression>\n");
    printf("Examples:\n");
    printf("set A = 3 2 +\n");
    printf("The above example sets A to 5\n");
    printf(
        "NOTE: If the expression part is omitted, then the topmost element of "
        "the stack is popped and the variable is set to that value\n");
    printf("Example:\n");
    printf(">> 3 2\n");
    printf(">> set A = \n");
    printf("This sets A to 2 and 2 is removed from the stack\n");
    printf(
        "If the expression part is omitted and the stack is empty, the "
        "variable will assume the value of 0\n");
    // printf("\n");
    // printf("%-16s%s\n", "", "");
    // printf("%-16s%s\n", "", "");
}
char peekChar()
{
    // Gets the character at index cp without incrementing cp.
    if ((cp >= (BUFFER_SIZE - 1)) || (cp < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at peekChar()", cp);
        return '\0';
    }
    return src_string[cp];
}

long int factorial(int n)
{
    int f = 1;
    for (int j = 1; j <= n; j++) f = f * j;
    return f;
}

void clearScreen()
{
    // I couldn't find a proper way of clearing the console
    // (especially for displaying the stack)
    // So this method is slightly portable and works in *nix and windows
    system("cls||clear");
}

void displayStack()
{
    printf("%s\n", "============================");
    for (int k = 0; k <= sp; k++) {
        printf("[%d: ", k);
        // printf("%.*g ", DBL_DECIMAL_DIG, valueAt(k));
        // I am not using DBL_DECIMAL_DIG, as it prints 1.4999999... for 1.5
        printf("%.15g ", valueAt(k));
        printf("%s", " ]\n");
    }
}
void displayMemory()
{
    // printf("%s\n", "============================");
    printf("MEMORY: [");
    for (int i = 0; i < 26; i++) {
        if (variables_set[i]) {
            printf("%c: %.15g ", alphabets[i], variable_lookup[i]);
        }
    }
    printf("]\n");
}

char peekNextChar()
{
    // Gets the next character at index cp+1, without incrementing.
    if (((cp + 1) >= (BUFFER_SIZE - 1)) || ((cp + 1) < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at peekNextChar()", cp + 1);
        return '\0';
    }
    return src_string[cp + 1];
}

double valueAt(int n)
{
    // Gets the character at the given index
    if ((n >= MAX_OPERANDS) || (n < 0)) {
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at valueAt()", n);
        return '\0';
    }
    return op_stack[n];
}

char charAt(int n)
{
    // Gets the operand at the given index from the stack
    if (((n) >= (BUFFER_SIZE - 1)) || ((n) < 0)) {
        // Returns null character if the string has finished processing.
        printf("====== WARNING ====== [%s] %d\n",
               "Out of bound access at charAt()", n);
        return '\0';
    }
    return src_string[n];
}

char getChar()
{
    // Gets the character at index cp and also increments cp.
    char c = peekChar();
    cp++;
    return c;
}

void setChar(char c)
{
    if ((cp >= (BUFFER_SIZE - 1)) || (cp < 0)) {
        printf("Fatal error: Array index out of bounds %d", cp);
        err_occured = 1;
        return;
    }
    src_string[cp] = c;
}
// ===================================
int pop(double* var)
{
    /*
     * Function which pops an element from the stack and sets the passed element
     * to that value. If the stack is empty, 0 will be returned
     */
    if (sp < 0) {
        if (var) *var = 0;
        return 0;
    }
    else {
        if (var) *var = op_stack[sp--];
        return 1;
    }
}

int peek(double* var)
{
    /*
     * Function which peeks an element from the stack and sets the passed
     * element to that value. If the stack is empty, 0 will be returned
     */
    if (sp < 0) {
        if (var) *var = 0;
        return 0;
    }
    else {
        if (var) *var = op_stack[sp];
        return 1;
    }
}

int push(double var)
{
    /*
     * Function which pushes an element to the stack
     * If the stack is full, 0 will be returned and 1 in case of success
     */
    if (sp == (MAX_OPERANDS - 1)) {
        if (TOKEN_DEBUG_ENABLED)
            printf("%s\n", "[WARNING: Operator stack is full]");
        return 0;
    }
    else {
        op_stack[++sp] = var;
        return 1;
    }
}

void consumeNumber()
{
    // Increments cp until the character at that index is not a number.
    while (isdigit(peekChar())) {
        cp++;
    }
}

Token processIdentifier()
{
    int tmp = cp;
    if (peekChar() == '_') cp++;
    while (isalnum(peekChar()) || peekChar() == '_') {
        cp++;
    }
    return (Token){IDENTIFIER, src_string, tmp, cp - tmp};
}

Token processNumber()
{
    // Tries to find a number from the index cp in src_string
    // At the first non numeric character(except dot), the function returns.
    int tmp = cp;
    if (peekChar() == '-') {
        // Negative number
        cp++;
    }

    consumeNumber();

    if (peekChar() == '.') {
        // Decimal number
        cp++;
        consumeNumber();
    }
    if (peekChar() == 'e' || peekChar() == 'e') {
        // Exponential notation.
        cp++;
        consumeNumber();
        // Handle negative number of exponents
        if (peekChar() == '-') {
            cp++;
            consumeNumber();
        }
    }
    // cp - tmp is the length of the token.
    return (Token){NUMBER, src_string, tmp, cp - tmp};
}

Token getNextToken()
{
    // This function works like a lexer, it takes the input string and returns
    // tokens.
    if (cp == -1) return (Token){END_OF_FILE, src_string, cp, 0};

    while (peekChar() != '\0') {
        // Ignore whitespaces and tabs
        if (peekChar() == ' ' || peekChar() == '\t') {
            cp++;
            continue;
        }

        // Debug char
        if (peekChar() == '@') {
            TOKEN_DEBUG_ENABLED = TOKEN_DEBUG_ENABLED ? 0 : 1;
            cp++;
            continue;
        }
        // Single character tokens
        if (peekChar() == '*') return (Token){STAR, src_string, cp++, 1};
        if (peekChar() == '/')
            return (Token){FORWARD_SLASH, src_string, cp++, 1};
        if (peekChar() == '+') return (Token){PLUS, src_string, cp++, 1};
        if (peekChar() == '%') return (Token){MODULUS, src_string, cp++, 1};
        if (peekChar() == '!') return (Token){EXCLAMATION, src_string, cp++, 1};
        if (peekChar() == '=') return (Token){ASSIGNMENT, src_string, cp++, 1};

        if (peekChar() == '&') return (Token){BIT_AND, src_string, cp++, 1};
        if (peekChar() == '|') return (Token){BIT_OR, src_string, cp++, 1};
        if (peekChar() == '~') return (Token){BIT_NOT, src_string, cp++, 1};
        if (peekChar() == '^') return (Token){BIT_XOR, src_string, cp++, 1};

        if (peekChar() == '>' && peekNextChar() == '>')
            return (Token){BIT_RSHIFT, src_string, cp++, 1};
        if (peekChar() == '<' && peekNextChar() == '<')
            return (Token){BIT_LSHIFT, src_string, cp++, 1};
        if (peekChar() == '-') {
            if (isdigit(peekNextChar())) {
                // If the next character after minus is a digit
                // It is a negative number
                return processNumber();
            }
            else {
                return (Token){MINUS, src_string, cp++, 1};
            }
        }
        if (peekChar() == '\n') return (Token){NEWLINE, src_string, cp++, 1};

        // Multi character tokens like numbers or variables
        else {
            // Handle numbers
            if (isdigit(peekChar())) {
                return processNumber();
            }
            // Handle identifers
            // Identifier is defined as a sequence of alphanumeric characters
            // starting with underscore or an alphabet
            if (isalpha(peekChar()) || peekChar() == '_') {
                return processIdentifier();
            }
            return (Token){UNKNOWN, src_string, cp++, 1};
        }
    }
    cp = -1;
    return (Token){END_OF_FILE, src_string, cp, 0};
}

void reset()
{
    // Resets all variables to initial state
    // Reset stack pointer if you want to clear the state
    // I want the elements of the stack to remain
    sp = -1;
    cp = 0;
    memset(src_string, 0, sizeof(src_string));
    err_occured = 0;
}

void displayToken(Token t)
{
    putchar('<');
    switch (t.type) {
        // I know, this is ugly, but I dont want to do dynamic memory
        // allocation.
        case NUMBER:
            printf("%s", "NUMBER");
            break;
        case IDENTIFIER:
            printf("%s", "IDENTIFIER");
            break;
        case PLUS:
            printf("%s", "PLUS");
            break;
        case MINUS:
            printf("%s", "MINUS");
            break;
        case FORWARD_SLASH:
            printf("%s", "SLASH");
            break;
        case STAR:
            printf("%s", "STAR");
            break;
        case MODULUS:
            printf("%s", "MODULUS");
            break;
        case EXCLAMATION:
            printf("%s", "EXCLAMATION");
            break;
        case ASSIGNMENT:
            printf("%s", "ASSIGNMENT");
            break;
        case END_OF_FILE:
            printf("%s>\n", "EOF");
            // Returns for EOF as it is not printable
            return;
        case NEWLINE:
            printf("%s>\n", "EOL");
            // Returns for EOF as it is not printable
            return;
        case UNKNOWN:
            printf("%s", "UKNWN");
            break;
        default:
            printf("%s", "*UKNWN");
            break;
    }
    // Add a space
    putchar(' ');

    if (t.length == 1) {
        // Code for handling single character tokens only.
        printf("%c", t.src[t.index]);
    }
    else {
        for (int i = 0; i < t.length; i++) {
            assert((t.index + i) < (BUFFER_SIZE - 1));
            assert((t.index + i) >= 0);
            putchar(t.src[t.index + i]);
        }
    }

    putchar('>');
    putchar('\n');
}

void unaryop(OPType type)
{
    // Function to handle functions or operators which take a single operand
    // like sin, cos, etc.
    double rhs, result = 0;
    // Only for trigonometric functions
    if (!pop(&rhs)) {
        if (show_errors)
            printf(
                "ERROR: Not enough operands for the given function/operator\n");
        err_occured = 1;
        return;
    }
    double trig_rhs =
        (angle_measure == RADIAN) ? rhs : (3.1415926535 / 180) * rhs;
    switch (type) {
        case OP_SIN:
            result = sin(trig_rhs);
            break;
        case OP_COS:
            result = cos(trig_rhs);
            break;
        case OP_TAN:
            result = tan(trig_rhs);
            break;
        case OP_EXP:
            result = exp(trig_rhs);
            break;
        case OP_COT:
            result = cos(trig_rhs) / sin(trig_rhs);
            break;
        case OP_LOG:
            result = log(rhs);
            break;
        case OP_LOG10:
            result = log10(rhs);
            break;
        case OP_SQRT:
            if (rhs < 0) {
                if (show_errors)
                    printf("%s\n", "ERROR: Square root of negative number");
                err_occured = 1;
                push(rhs);
                return;
            }
            result = sqrt(rhs);
            break;
        case OP_ABS:
            result = fabs(rhs);
            break;
        case OP_CEIL:
            result = ceil(rhs);
            break;
        case OP_FLOOR:
            result = floor(rhs);
            break;
        case OP_FACTORIAL:
            result = (double)(factorial((int)rhs));
            break;
        case OP_BIT_NOT:
            result = ~(int)rhs;
            break;
        default:
            if (show_errors)
                printf("%s\n", "INTERNAL ERROR: Unknown unary operator");
            err_occured = 1;
            return;
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full");
        err_occured = 1;
        return;
    }
}

void binaryfunc(OPType type)
{
    double result = 0, lhs, rhs;
    int rhs_success = 0;

    if (!pop(&rhs)) {
        if (show_errors)
            printf("ERROR: Not enough operands for function taking 2 args\n");
        err_occured = 1;
        return;
    }
    // If control has come here, it means that pop(&rhs) didn't fail
    rhs_success = 1;
    if (!pop(&lhs)) {
        if (rhs_success) push(rhs);
        if (show_errors)
            printf("ERROR: Not enough operands for function taking 2 args\n");
        err_occured = 1;
        return;
    }

    if (type == OP_POW) {
        result = pow(lhs, rhs);
    }
    if (type == OP_MOD) {
        result = fmod(lhs, rhs);
    }
    if (type == OP_LOGN) {
        result = log(lhs) / log(rhs);
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full, Internal error");
        err_occured = 1;
        return;
    }
}

void binop(char op)
{
    // Function to handle operators which expect two operands such as +, - etc
    double result = 0, lhs, rhs;
    int rhs_success = 0;

    if (!pop(&rhs)) {
        if (show_errors)
            printf("ERROR: Not enough operands for operator '%c' (rhs)\n", op);
        err_occured = 1;
        return;
    }
    // If control has come here, it means that pop(&rhs) didn't fail
    rhs_success = 1;
    if (!pop(&lhs)) {
        // Suppose the input was 32 +
        // The program pops 32 and stores it in a variable
        // But it errors here as there is no lhs
        // So in this case, we have to push back that 32 (or whatever number)
        if (rhs_success) push(rhs);
        if (show_errors)
            printf("ERROR: Not enough operands for operator '%c' (lhs)\n", op);
        err_occured = 1;
        return;
    }

    switch (op) {
        case '+':
            result = lhs + rhs;
            break;
        case '-':
            result = lhs - rhs;
            break;
        case '*':
            result = lhs * rhs;
            break;
        // For these bitwise operators, the double is converted to int first
        case '&':
            result = (int)lhs & (int)rhs;
            break;
        case '|':
            result = (int)lhs | (int)rhs;
            break;
        case '^':
            result = (int)lhs ^ (int)rhs;
            break;
        case 'R':
            result = (int)lhs >> (int)rhs;
            break;
        case 'L':
            result = (int)lhs << (int)rhs;
            break;
        case '/':
            if (fabs(rhs) <= 1e-50) {
                if (show_errors) printf("%s\n", "ERROR: Division by zero");
                err_occured = 1;
                return;
            }
            else {
                result = lhs / rhs;
            }
            break;
        case '%':
            if (fabs(rhs) <= 1e-50) {
                if (show_errors) printf("%s\n", "ERROR: Modulus by zero");
                err_occured = 1;
                return;
            }
            else {
                // Using fmod instead of modulus operator because the all values
                // are represented as double.
                result = fmod(lhs, rhs);
            }
            break;

        default:
            if (show_errors) printf("ERROR: Unknown operator (%c) \n", op);
            err_occured = 1;
            break;
    }
    if (!push(result)) {
        if (show_errors) printf("ERROR: %s\n", "Stack is full, Internal error");
        err_occured = 1;
        return;
    }
}

void calculate()
{
    // Function calculates the value of the expression
    // Make sure to call reset() after calling this function
    // To reset the index variables and state
    Token t;
    int i;
    // var for temporary usage
    double var;
    do {
        if (err_occured) {
            // If any error had occured, do not continue scanning
            return;
        }
        t = getNextToken();
        if (t.type == UNKNOWN) {
            if (show_errors)
                printf("ERROR: Uknown character (%c) at index %d in input\n",
                       t.src[t.index], t.index);
            err_occured = 1;
            return;
        }
        else {
            switch (t.type) {
                case NUMBER:
                    for (i = 0; i < t.length; i++) {
                        assert((t.index + i) < (BUFFER_SIZE - 1));
                        assert((t.index + i) >= 0);
                        buffer[i] = t.src[t.index + i];
                    }
                    buffer[i] = '\0';
                    if (!push(atof(buffer))) {
                        if (show_errors)
                            printf("ERROR: %s\n",
                                   "Stack is full, Internal error");
                        err_occured = 1;
                        return;
                    }
                    break;
                case IDENTIFIER:
                    /* I removed all returns from the if statements and
                     * converted the if statements to else if. Using the return
                     * statements, I could not evaluate 2 sqrt floor Or the like
                     * of functions
                     */
                    // Copy to temporary buffer to do manipulations
                    for (i = 0; i < t.length; i++) {
                        assert((t.index + i) < (BUFFER_SIZE - 1));
                        assert((t.index + i) >= 0);
                        buffer[i] = t.src[t.index + i];
                    }
                    buffer[i] = '\0';

                    // Handle some variables such as e and pi
                    if (strcmp(buffer, "pi") == 0) {
                        if (!push(3.14159265358)) {
                            if (show_errors)
                                printf("ERROR: %s\n", "Stack is full");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "e") == 0) {
                        if (!push(2.71828182845))

                        {
                            if (show_errors)
                                printf("ERROR: %s\n", "Stack is full");
                            err_occured = 1;
                            return;
                        }
                    }

                    // Handle some commands
                    else if (strcmp(buffer, "exit") == 0 ||
                             strcmp(buffer, "quit") == 0) {
                        running = 0;
                    }
                    else if (strcmp(buffer, "help") == 0) {
                        printHelpMessage();
                    }
                    else if (strcmp(buffer, "dup") == 0) {
                        if (!peek(&var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to duplicate element as "
                                       "stack "
                                       "is empty");
                            err_occured = 1;
                            return;
                        }
                        if (!push(var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to duplicate element as "
                                       "stack is full");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "peek") == 0 ||
                             strcmp(buffer, "print") == 0) {
                        peek(&var);
                        printf("%.15g\n", var);
                    }
                    else if (strcmp(buffer, "pop") == 0) {
                        if (!pop(&var)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to pop element as "
                                       "stack is empty");
                            err_occured = 1;
                            return;
                        }
                        printf("%.15g\n", var);
                    }
                    else if (strcmp(buffer, "rad") == 0) {
                        angle_measure = RADIAN;
                    }
                    else if (strcmp(buffer, "deg") == 0) {
                        angle_measure = DEGREE;
                    }
                    else if (strcmp(buffer, "show_stack") == 0) {
                        stack_shown = 1;
                    }
                    else if (strcmp(buffer, "no_show_stack") == 0) {
                        stack_shown = 0;
                    }
                    else if (strcmp(buffer, "clear_screen") == 0) {
                        clear_screen = 1;
                    }
                    else if (strcmp(buffer, "no_clear_screen") == 0) {
                        clear_screen = 0;
                    }
                    else if (strcmp(buffer, "display_prompt") == 0) {
                        display_prompt = 1;
                    }
                    else if (strcmp(buffer, "no_display_prompt") == 0) {
                        display_prompt = 0;
                    }
                    else if (strcmp(buffer, "debug") == 0) {
                        TOKEN_DEBUG_ENABLED = 1;
                    }
                    else if (strcmp(buffer, "no_debug") == 0) {
                        TOKEN_DEBUG_ENABLED = 0;
                    }
                    else if (strcmp(buffer, "show_errors") == 0) {
                        show_errors = 1;
                    }
                    else if (strcmp(buffer, "no_show_errors") == 0) {
                        show_errors = 0;
                    }
                    else if (strcmp(buffer, "display") == 0) {
                        // Enables display of everything
                        enableDisplay();
                    }
                    else if (strcmp(buffer, "no_display") == 0) {
                        disableDisplay();
                    }

                    else if (strcmp(buffer, "swap") == 0) {
                        // Stack: a b c d e f
                        // v1 = f
                        // v2 = e
                        // After pushing back again
                        // a b c f e
                        // The elements are swapped
                        double v1, v2;
                        int v1_success = 0;
                        if (!pop(&v1)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to swap as "
                                       "there are not enough elements");
                            err_occured = 1;
                            return;
                        }
                        v1_success = 1;
                        if (!pop(&v2)) {
                            if (show_errors)
                                printf("%s\n",
                                       "ERROR: Unable to swap as "
                                       "there are not enough elements");
                            err_occured = 1;
                            if (v1_success) {
                                // One element has already been popped out.
                                // Push it back into the stack
                                push(v1);
                            }
                            return;
                        }
                        // No need to check if the stack is full because on
                        // calling pop() twice above, there will be 2 spaces
                        push(v1);
                        push(v2);
                    }
                    else if (strcmp(buffer, "clear") == 0) {
                        sp = -1;
                    }
                    else if (strcmp(buffer, "mem") == 0) {
                        displayMemory();
                    }
                    else if (strcmp(buffer, "clearmem") == 0) {
                        for (int j = 0; j < 26; j++) {
                            variable_lookup[j] = 0;  // Might not be necessary
                            variables_set[j] = 0;
                        }
                    }

                    // Handle math functions
                    else if (strcmp(buffer, "sin") == 0) {
                        unaryop(OP_SIN);
                    }
                    else if (strcmp(buffer, "cos") == 0) {
                        unaryop(OP_COS);
                    }
                    else if (strcmp(buffer, "tan") == 0) {
                        unaryop(OP_TAN);
                    }
                    else if (strcmp(buffer, "cot") == 0) {
                        unaryop(OP_COT);
                    }
                    else if (strcmp(buffer, "exp") == 0) {
                        unaryop(OP_EXP);
                    }

                    else if (strcmp(buffer, "log") == 0) {
                        unaryop(OP_LOG);
                    }
                    else if (strcmp(buffer, "log10") == 0) {
                        unaryop(OP_LOG10);
                    }
                    else if (strcmp(buffer, "abs") == 0) {
                        unaryop(OP_ABS);
                    }
                    else if (strcmp(buffer, "ceil") == 0) {
                        unaryop(OP_CEIL);
                    }
                    else if (strcmp(buffer, "floor") == 0) {
                        unaryop(OP_FLOOR);
                    }
                    else if (strcmp(buffer, "sqrt") == 0) {
                        unaryop(OP_SQRT);
                    }
                    else if (strcmp(buffer, "logn") == 0) {
                        binaryfunc(OP_LOGN);
                    }
                    else if (strcmp(buffer, "mod") == 0) {
                        binaryfunc(OP_MOD);
                    }
                    else if (strcmp(buffer, "pow") == 0) {
                        binaryfunc(OP_POW);
                    }
                    else if (strcmp(buffer, "sum") == 0) {
                        double result = 0;
                        for (int k = 0; k <= sp; k++) {
                            result += valueAt(k);
                        }
                        if (!push(result)) {
                            if (show_errors)
                                printf(
                                    "ERROR: Can't find sum of numbers because "
                                    "stack is full\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "prod") == 0) {
                        double result = 1;
                        for (int k = 0; k <= sp; k++) {
                            result *= valueAt(k);
                        }
                        if (!push(result)) {
                            if (show_errors)
                                printf(
                                    "ERROR: Can't find product of numbers "
                                    "because "
                                    "stack is full\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else if (strcmp(buffer, "clrtop") == 0) {
                        // Clears all elements of stack except top
                        if (sp > 0) {
                            double tmp = valueAt(sp);
                            sp = -1;
                            push(tmp);
                        }
                        else {
                            printf(
                                "WARN: clrtop failed as there are no elements "
                                "in the stack\n");
                        }
                    }

                    // Handle set command
                    else if (strcmp(buffer, "set") == 0) {
                        // Example:
                        // set a = <expression>
                        // set a = 3 2 +  ----> Sets a to 5
                        // Grammer:
                        // set "single letter variable name" = "expression"
                        Token t2 = getNextToken();
                        Token t3;
                        if (t2.type == IDENTIFIER && t2.length == 1 &&
                            isupper(t2.src[t2.index])) {
                            t3 = getNextToken();
                            if (t3.type == ASSIGNMENT) {
                                calculate();
                                if (!err_occured) {
                                    double vars = 0;
                                    char ch = t2.src[t2.index];
                                    assert((ch - 'A') >= 0);
                                    assert((ch - 'A') < 26);

                                    pop(&vars);
                                    printf("Set the value of %c to %.15g\n", ch,
                                           vars);
                                    variable_lookup[ch - 'A'] = vars;
                                    variables_set[ch - 'A'] = 1;
                                }
                                else {
                                    if (show_errors)
                                        printf(
                                            "ERROR: Error occured on rhs "
                                            "expression\n");
                                }
                            }
                            else {
                                if (show_errors)
                                    printf("%s\n",
                                           "ERROR~~: Invalid use of set, no =");
                                cp = t2.index;
                                err_occured = 1;
                                return;
                            }
                        }
                        else {
                            if (show_errors)
                                printf(
                                    "%s\n",
                                    "ERROR~~: Invalid use of set, no variable "
                                    "after set command, or variable is not "
                                    "single uppercase letter");
                            cp = t2.index;
                            err_occured = 1;
                            return;
                        }
                    }

                    // Handle single letter variables
                    // Only uppercase variables are supported as some math
                    // constants are in lowercase
                    else if (t.length == 1) {
                        if (t.src[t.index] >= 'A' && t.src[t.index] <= 'Z') {
                            int index = (int)(t.src[t.index] - 'A');
                            assert(index >= 0 && index < 26);
                            if (!variables_set[index]) {
                                if (show_errors)
                                    printf("ERROR: Variable %c not set\n",
                                           t.src[t.index]);
                                err_occured = 1;
                                return;
                            }
                            if (!push(variable_lookup[index])) {
                                if (show_errors)
                                    printf(
                                        "ERROR: Stack is full, unable to "
                                        "dereference variable\n");
                                err_occured = 1;
                                return;
                            }
                        }
                        else {
                            if (show_errors)
                                printf(
                                    "ERROR: Only uppercase variables are "
                                    "supported\n");
                            err_occured = 1;
                            return;
                        }
                    }
                    else {
                        err_occured = 1;
                        printf("%s%s\n",
                               "Error: Unknown identifier or function - ",
                               buffer);
                        printf("%s\n",
                               "Type \"help\" to view all supported commands");
                        printf("%s\n",
                               "If you meant to assign a variable, only single "
                               "character variables are supported");
                        return;
                    }
                    break;

                case PLUS:
                    binop('+');
                    break;

                case MINUS:
                    binop('-');
                    break;

                case STAR:
                    binop('*');
                    break;

                case FORWARD_SLASH:
                    binop('/');
                    break;

                case MODULUS:
                    binop('%');
                    break;

                case EXCLAMATION:
                    unaryop(OP_FACTORIAL);
                    break;

                case BIT_LSHIFT:
                    binop('L');
                    break;
                case BIT_RSHIFT:
                    binop('R');
                    break;
                case BIT_AND:
                    binop('&');
                    break;
                case BIT_OR:
                    binop('|');
                    break;
                case BIT_NOT:
                    unaryop(OP_BIT_NOT);
                    break;
                case BIT_XOR:
                    binop('^');
                    break;

                case NEWLINE:
                case END_OF_FILE:
                    break;

                default:
                    printf("%s\n", "UNHANDLED");
            }
        }
        if (TOKEN_DEBUG_ENABLED) displayToken(t);
    } while (t.type != END_OF_FILE);
}

int getline_(char buffer_[], int bufferSize)
{
    int bufferIndex = 0, ch;
    while (bufferIndex < (bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        buffer_[bufferIndex++] = (char)ch;
        if (ch == '\n') break;
    }
    buffer_[bufferIndex] = '\0';
    return bufferIndex;
}

int main(int argc, char* argv[])
{
    if (argc > 1) {
        // Skip program name
        // Some more options for command line usage
        argv++;
        // Command line mode
        TOKEN_DEBUG_ENABLED = 0; /* Whether to print token details or not */
        err_occured = 0;
        stack_shown = 0;
        show_errors = 0;
        clear_screen = 0;
        while (*argv) {
            strncpy(src_string, *argv, 512);
            if (clear_screen) clearScreen();
            calculate();
            if (!running) {
                break;
            }
            if (stack_shown) displayStack();
            cp = 0;
            err_occured = 0;
            argv++;
        }
        // Display the result
        strncpy(src_string, "pop", 512);
        calculate();
    }
    else {
        int length;
        if (clear_screen) clearScreen();
        printf("%s %s\n",
               "Welcome to Shankar's RPN (Reverse polish notation) Calculator",
               VERSION);
        printf("Max supported length of a single line of input: %d\n",
               BUFFER_SIZE);
        printf("Max number of operands supported: %d\n", MAX_OPERANDS);
        printf(
            "$ rpn    - runs this calculator in interactive mode, Enter the "
            "expression through standard input\n");
        printf("%s\n", "Type @ and press enter to toggle debug mode");
        printf("Type \"help\" and press enter to get help\n");
        if (display_prompt) printf("%s", ">>");
        while ((length = getline_(src_string, 512))) {
            if (clear_screen) clearScreen();
            calculate();
            if (!running) {
                if (clear_screen) clearScreen();
                if (stack_shown) displayStack();
                break;
            }
            if (stack_shown) displayStack();
            // reset();
            cp = 0;
            err_occured = 0;
            if (display_prompt) printf("%s", ">>");
        }
        // Interactive mode
    }
}
/* Exercise 5-13. Write the program tail, which prints the last n lines of its
 * input. By default, n is set to 10, let us say, but it can be changed by an
 * optional argument so that tail -n prints the last n lines. The program should
 * behave rationally no matter how unreasonable the input or the value of n.
 * Write the program so it makes the best use of available storage; lines should
 * be stored as in the sorting program of Section 5.6, not in a two-dimensional
 * array of fixed size. */

#include <stdio.h>
#include <stdlib.h>
#define BUFFER_SIZE 8
char *getline(size_t *size)
{
    int ch;
    size_t buffer_size = 0;
    size_t index = 0;
    char *buffer = malloc(sizeof(char) * BUFFER_SIZE);
    if (!buffer) {
        if (size) {
            *size = 0;
        }
        return NULL;
    }
    buffer_size = BUFFER_SIZE;
    while ((ch = getchar()) != EOF) {
        if (!(index < (buffer_size - 1))) {
            // Buffer is not wide enough, expand it
            buffer_size *= 2;
            char *tmp = realloc(buffer, buffer_size);
            if (!tmp) {
                printf("Couldn't realloc buffer\n");
                free(buffer);
                return NULL;
            }
            buffer = tmp;
        }
        buffer[index++] = (char)ch;
        if (ch == '\n') break;
    }
    buffer[index] = '\0';
    if (size) *size = index;
    return buffer;
}

typedef struct node {
    char *line;
    struct node *next;
    struct node *prev;
} node;


int main(int argc, char *argv[])
{
    if(argc !=2)
    {
        printf("Usage: ./exercise-5-13 -n\n");
        exit(12);
    }
    if(argv[1][0] != '-')
    {
        printf("Usage: ./exercise-5-13 -n\n");
        printf("Example: ./exercise-5-13 -5\n");
        exit(12);
    }
    char *end;
    int numStations = strtol(&argv[1][1], &end, 10);

    if (end == &argv[1][1]) {
        printf("%s\n", "Please enter a valid number");
        exit(2);
    }
    if (numStations < 0) {
        printf("%s\n", "Please enter a valid number");
        exit(1);
    }
    size_t buff_length = 0;
    char *buff;
    node *head = NULL, *sen = NULL;
    for (;;) {
        buff = getline(&buff_length);
        if(!buff_length)
            break;
        if (!head) {
            head = malloc(sizeof(node));
            if (!head) exit(10);
            head->next = NULL;
            head->prev = NULL;
            head->line = buff;
            sen = head;
        }
        else {
            sen->next = malloc(sizeof(node));
            if (!sen->next) exit(11);
            sen->next->next = NULL;
            sen->next->prev = sen;
            sen->next->line = buff;
            sen = sen->next;
        }
    }
    int i = 0;
    node *s2 = NULL;
    while(sen)
    {
        if(i < numStations) 
        {
            s2 = sen;
            sen = sen->prev;
        }
        else
            break;
        i++;
    }
    while(s2)
    {
        printf("%s", s2->line);
        s2 = s2->next;
    }
    node *tmp;
    // Free the allocated memory
    while(head)
    {
        tmp = head;
        head = head->next;
        free(tmp->line);
        free(tmp);
    }
}
/* Exercise 5-2. Write getfloat, the floating-point analog of
 * getint. What type does
 * getfloat return as its function value? */
#include <ctype.h>
#include <stdio.h>

// Code for handling the getch and ungetch
#define getch() (cp > 0) ? (charbuffer[--cp]) : getchar()
#define ungetch(ch)                                                     \
    {                                                                   \
        if (cp >= CHARBUFFSIZE)                                         \
            printf("Temporary buffer stack is full, cant push back\n"); \
        else                                                            \
            charbuffer[cp++] = (char)ch;                                \
    }

#define CHARBUFFSIZE 100
int cp = 0;

char charbuffer[CHARBUFFSIZE] = {'\0'};
int getfloat(double *dbl)
{
    int ch, sign, tmp;
    double power = 1;
    double result;
    // Skip whitespaces, tabs, etc
    while (isspace(ch = getch()))
        ;

    // Gets the sign (if any)
    if (ch == '+' || ch == '-') {
        sign = (ch == '-') ? -1 : 1;
        tmp = getch();
        // The next character after the sign is not a digit.
        // Example: +a , -z, etc
        // Note: This means that this program does not support  decimal numbers
        // such as -.3, +.2, etc.
        if (!isdigit(tmp)) {
            // Un-gets the the sign and the character which was read
            ungetch(tmp) ungetch(ch) return 0;
        }
        ch = tmp;
    }
    else if (isdigit(ch)) {
        // The number does not include any sign, for example 312, 123, 312.123,
        // etc. The number is assumed to be positive.
        sign = 1;
    }
    else {
        // Invalid character.
        // Note: Numbers such as .32, .12, etc become invalid.
        ungetch(ch) return 0;
    }
    *dbl = 0;
    while (isdigit(ch)) {
        *dbl = *dbl * 10.0 + (ch - '0');
        ch = getch();
    }

    if (ch == '.') {
        // There might be a fractional part here.
        tmp = getch();
        // Check if the next character after the dot is an number.
        if (!isdigit(tmp)) {
            // Un-gets the the sign and the character which was read
            // Note: Inputs such as 312. , 123. or 112.a are valid and will be
            // considered only upto the decimal dot
            ungetch(tmp) ungetch(ch)
        }
        else {
            ch = tmp;
            while (isdigit(ch)) {
                *dbl = *dbl * 10.0 + (ch - '0');
                power /= 10.0;
                ch = getch();
            }
            // Ungets the character which was not a digit.
            if (ch != EOF) ungetch(ch)
        }
    }
    else {
        // Un-gets the non digit number which was read.
        if (ch != EOF) ungetch(ch)
    }
    *dbl *= power;
    *dbl *= sign;
    return 1;
}
int main()
{
    double var;
    if (getfloat(&var)) {
        printf("%.15g\n", var);
    }
    else {
        printf("%s\n", "Invalid floating point number");
    }
}
/* Exercise 5-3. Write a pointer version of the function strcat that we showed
 * in Chapter 2: strcat(s,t) copies the string t to the end of s. */

#include <stdio.h>
void strcat_(char *s1, char *s2)
{
    // s2 is copied to the end of s1

    // Go to the end of s1
    // This version does not work
    // while(*s1++);
    // Because, when it exits the loop, null character has been found
    // but the ++ (increment part is executed) and s1 points to the character
    // after the null char so it is necessary to either decrement s1 after this
    // loop or use the structure in which s1 is incremented only if it is not
    // null. While this version works
    while (*s1) s1++;
    while ((*s1++ = *s2++))
        ;
}

int main()
{
    char buf[64] = "hello";
    strcat_(buf, " world");
    printf("%s\n", buf);
}
/* Exercise 5-4. Write the function strend(s,t), which returns 1 if the string t
 * occurs at the end of the string s, and zero otherwise. */

// ALGORITHM
// =========
// Example: s: h e l l o  w o r l d \0
//          t:              o r l d \0
// 1. Find the length of t and s.
// 2. Keep incrementing pointer s and t till they both point to the null
// character.
// 3. If the length of t is greater than that of s, return false
// 4. Keep decrementing pointer s and t, len(t) times. If the char at s and t
// are different return false.
// 5. Return true.

#include <assert.h>
#include <stdio.h>
#include <string.h>

#define DEBUG

#include "utest.h"
int strend_(char *s, char *t)
{
    // Check for null
    if(!s)
        return 0;
    if(!t)
        return 0;
#ifdef DEBUG
    char *sp = s;
    char *tp = t;
#endif
    size_t l_s = strlen(s), l_t = strlen(t);
    // Length of string s is lesser than length of string t, so s can never end
    // with t.
    if (l_s < l_t) return 0;
    // Move both pointers to the end of the string.
    // It can also be done as s = s + l_s; (?)
    // while (*s) s++;
    // while (*t) t++;
    s = s + l_s;
    t = t + l_t;

    // This loop runs one less than the length of the string because
    // decrementing pointer to one element before the first element is UB.
    // C11 6.5.6p8
    // l_t - 1 is not required, becauase s and t point to the null character and
    // not the last character of the string.
    //
    for (size_t i = 0; i < l_t; i++) {
        // printf("[IN LOOP] %c %c\n", *s, *t);
#ifdef DEBUG
        assert(s >= sp);
        assert(t >= tp);
#endif
        if (*s-- != *t--) return 0;
    }
    // Now the pointer points to the first element of t.
    // printf("[OUT OF LOOP] %c %c\n", *s, *t);
#ifdef DEBUG
    assert(s >= sp);
    assert(t >= tp);
#endif
    if (*s != *t) {
        return 0;
    }
    return 1;
}

UTEST(strend_test, basic)
{
    char buffer[256] = {'\0'};
    strcpy(buffer, "The quick brown the over jumps cat fox jumps over the");

    // Test cases when the string is present at the end
    ASSERT_EQ(strend_(buffer, "the"), 1);
    ASSERT_EQ(strend_(buffer, " the"), 1);
    ASSERT_EQ(strend_(buffer, "over the"), 1);
    ASSERT_EQ(strend_(buffer, "jumps over the"), 1);

    // Test cases when the string is not present at the end
    ASSERT_EQ(strend_(buffer, "\nthe"), 0);
    ASSERT_EQ(strend_(buffer, " thee"), 0);
    ASSERT_EQ(strend_(buffer, "Iver the"), 0);
    ASSERT_EQ(strend_(buffer, "jumps ovr the"), 0);

    // Test cases when the string is present elsewhere in the string but not at
    // the end
    ASSERT_EQ(strend_(buffer, "quick brown"), 0);
    ASSERT_EQ(strend_(buffer, "over jumps"), 0);
    ASSERT_EQ(strend_(buffer, "cat"), 0);

    // Test cases when the length of s is equal to t
    strcpy(buffer, "hello");
    ASSERT_EQ(strend_(buffer, "ello"), 1);
    ASSERT_EQ(strend_(buffer, "hello"), 1);

    ASSERT_EQ(strend_(buffer, "hellr"), 0);
    ASSERT_EQ(strend_(buffer, "zello"), 0);

    // Test cases when the length of t is more than that of s
    strcpy(buffer, "world");
    ASSERT_EQ(strend_(buffer, "hello world"), 0);
    ASSERT_EQ(strend_(buffer, " world"), 0);
    ASSERT_EQ(strend_(buffer, "this is the world"), 0);
    ASSERT_EQ(strend_(buffer, "The world"), 0);
    ASSERT_EQ(strend_(buffer, "HHorld"), 0);
}

UTEST(strend_test, edge_cases)
{
    char buffer[256] = {'\0'};
    // Test cases when s is empty
    ASSERT_EQ(strend_(buffer, ""), 1);
    // NOTE: The the above test case should return 1, since both s and t are
    // empty, we can consider that s ends with t.
    ASSERT_EQ(strend_(buffer, "hello"), 0);
    ASSERT_EQ(strend_(buffer, "This is just another sentence"), 0);

    strcpy(buffer, "The quick brown the over jumps cat fox jumps over the");

    // Test cases when t is empty
    // When t is empty, strend_ should return true for every string s
    ASSERT_EQ(strend_(buffer, ""), 1);

    // Test cases when the length of t is 1
    ASSERT_EQ(strend_(buffer, "e"), 1);
    ASSERT_EQ(strend_(buffer, "h"), 0);
    ASSERT_EQ(strend_(buffer, "a"), 0);

    // Test cases when the length of s is 1
    strcpy(buffer, "a");
    ASSERT_EQ(strend_(buffer, "a"), 1);
    ASSERT_EQ(strend_(buffer, ""), 1);
    ASSERT_EQ(strend_(buffer, " a"), 0);
    ASSERT_EQ(strend_(buffer, "abc"), 0);
}

UTEST_MAIN();
/* Exercise 5-5. Write versions of the library functions strncpy, strncat, and
 * strncmp, which operate on at most the first n characters of their argument
 * strings. For example, strncpy(s,t,n) copies at most n characters of t to s.
 * Full descriptions are in Appendix B. */
#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
size_t strncpy_(char *s, char *t, size_t n)
{
    size_t tmp = 1;
    while (tmp <= n) {
        if (!(*s++ = *t++)) break;
        tmp++;
    }
    return tmp;
}

void strlcpy_(char *s, char *t, size_t n)
{
    // Copies a c string and places null character if necessary.
    printf("strlen(t) = %zu n = %zu\n", strlen(t), n);
    if (strlen(t) > n) {
        strncpy_(s, t, n - 1);
        assert(n - 1 < 128);
        printf("Setting element at index %zu to null\n", n - 1);
        s[n - 1] = '\0';
    }
    else
        strncpy_(s, t, n);
}

void strncat_(char *s, char *t, size_t n)
{
    size_t tmp = 1;
    // Go to the end of the string
    while (*s) {
        s++;
        tmp++;
    }
    printf("End of string is at :%zu\n", tmp);
    while (tmp <= n) {
        if (!(*s++ = *t++)) break;
        tmp++;
    }
    // Check if the length was not enough
    printf("%zu %zu\n", tmp, n);
    if (tmp > n) {
        printf("+Length ==%zu\n", tmp);
        s[tmp] = 'A';
        printf("(%c)\n", s[tmp]);
    }
}

int strncmp_(char *cs, char *ct, size_t n)
{
    /* int strncmp(cs,ct,n)
     * compare at most n characters of string cs to string ct; return <0 if
     * cs<ct, 0 if cs==ct, or >0 if cs>ct. */
    // Page 227, The C programming lanugage by K&R, 2nd ed

    size_t tmp = 1;
    while(*cs == *ct)
    {
        if(tmp > n || n == 0)
            return 0;
        if(*cs == '\0')
            // Found the end of the first string.
            return 0;
        cs++;
        ct++;
        tmp++;
    }
    return *cs - *ct;
}

void displayBuffer(char *buff)
{
    // Check for NULL
    char *b = buff;
    if (!buff) return;
    // Assumes that buff is null terminated C-string
    while (*buff) {
        putchar(*buff);
        buff++;
    }
    printf("\n");
    printf("Length of the buffer is %zu\n", buff - b);
    putchar('\n');
}

int main()
{
    /* char buffer1[128] = {'\0'}; */
    char buffer1[128] = "Bhis";
    char buffer2[128] = {'\0'};
    /*
        // Array of 126 ones and one 2
        char *ones =
            "1111111111111111111111111111111111111111111111111111111111111111111111"
            "111111111111111111111111111111111111111111111111111111112";

        strlcpy_(buffer1, ones, 128);

        displayBuffer(buffer1);
        */
    char *h = "hello_";
    char *w = " world";
    /* strncat_(buffer1, h, 6);
     * displayBuffer(buffer1); */
    // strncat_(buffer1, w, 16);
    printf("%d\n", strncmp_(buffer1, "Bhxa", 1));
    // displayBuffer(buffer1);
}
/*
 *
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111 \¿
*/
/* Exercise 5-6. Rewrite appropriate programs from earlier chapters and
 * exercises with pointers instead of array indexing. Good possibilities include
 * getline (Chapters 1 and 4), atoi, itoa, and their variants (Chapters 2, 3,
 * and 4), reverse (Chapter 3), and strindex and getop (Chapter 4). */
#include <ctype.h>
#include <stdio.h>
size_t getline(char *buffer, size_t bufferSize)
{
    if (!buffer) return 0;
    char *buffOrig = buffer;
    int ch;

    while ((buffer - buffOrig) < (unsigned)(bufferSize - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        *buffer++ = (char)ch;
        if (ch == '\n') break;
    }
    *buffer = '\0';
    return (size_t)(buffer - buffOrig);
}
int main()
{
    size_t length;
    char buffer[128];
    while ((length = getline(buffer, 128))) {
        printf("%zu - %s\n", length, buffer);
    }
}
/* Exercise 5-9. Rewrite the routines day_of_year and month_day with pointers instead of
 * indexing. */

static char daymap[2][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}};

int day_of_year(int year, int month, int day)
{
    // Check if year is valid
    if(year < 0)
        return -1;

    // Check if month is valid
    if(!(month >= 1 && month <= 12))
    {
        return -2;
    }

    // Check if day is valid
    if(!(day >= 1 && day <= 31))
    {
        return -3;
    }
    /*
     * Returns the day of year which corresponds to the day of the given month.
     */
    int leap = ((year % 4 == 0) && year % 100 != 0) || (year % 400 == 0);
    for (int i = 1; i < month; i++) day += *(*(daymap+leap) + i);
    return day;
}

int month_day(int year, int yearday, int *pmonth, int *pday)
{
    if(pmonth)
        *pmonth = 0;
    if(pday)
        *pday = 0;

    int i, leap;
    leap = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);

    // Check if yearday is valid
    if(!(yearday >= 0 && yearday <= 366) && leap)
    {
        // A leap year
        return -1;
    }
    else if(!(yearday >= 0 && yearday <= 365))
    {
        // Not a leap year
        return -2;
    }

    if(year < 0)
    {
        return -3;
    }

    for (i = 1; yearday > *(*(daymap+leap)+i); i++) yearday -= *(*(daymap+leap)+ i);

    if(pmonth)
        *pmonth = i;
    if(pday)
        *pday = yearday;
    return 1;
}
#include <stdio.h>
int main()
{
    int m, d;
    month_day(2022, 60, &m, &d);
    printf("%d\n", day_of_year(2022, 8, 31));
    printf("%d %d\n", m, d );
}
#include <ctype.h>
#include <stdio.h>
#include <string.h>

// This preprocessor directive makes it possible to not declare the size of the
// keytable as it'll be calculated automatically
#define NUMBER_OF_KEYWORDS (sizeof(keytable) / sizeof(struct key))
// Maximum size of a single word
#define MAX_WORD_SIZE 256

struct key {
    char *word;
    int count;
};

// List of all 32 keywords in C
struct key keytable[] = {
    {"auto", 0},     {"break", 0},    {"case", 0},     {"char", 0},
    {"const", 0},    {"continue", 0}, {"default", 0},  {"do", 0},
    {"double", 0},   {"else", 0},     {"enum", 0},     {"extern", 0},
    {"float", 0},    {"for", 0},      {"goto", 0},     {"if", 0},
    {"int", 0},      {"long", 0},     {"register", 0}, {"return", 0},
    {"short", 0},    {"signed", 0},   {"sizeof", 0},   {"static", 0},
    {"struct", 0},   {"switch", 0},   {"typedef", 0},  {"union", 0},
    {"unsigned", 0}, {"void", 0},     {"volatile", 0}, {"while", 0},
};
// TODO: Handle multiline comments

typedef enum Status{
    NUMBER,
    IDENTIFIER,
    END_OF_FILE,
    ERR_INVALID_BUFFER
} Status;

void print_char(const char *s, int ch)
{
    printf("%s:", s);
    if (ch == '\n') {
        putchar('\\');
        putchar('n');
    }
    else if (ch == '\t') {
        putchar('\\');
        putchar('t');
    }
    else if (ch == '\r') {
        putchar('\\');
        putchar('r');
    }
    else if (ch == ' ') {
        putchar('_');
    }
    else
        putchar(ch);
    printf("\n");
}

Status get_word(char *buffer, size_t wlimit)
{
    // Get a single word into the buffer with max size equal to wlimit-1
    // As one empty space is required for storing a null character
    // A word is defined as a sequence of characters, numbers or underscores
    // beginning with a letter or underscore
    int ch;
    size_t buffer_index= 0;
    if(!buffer)
    {
        printf("Invalid buffer, buffer is NULL\n");
        return ERR_INVALID_BUFFER;
    }

    while ((ch = getchar()) != EOF) {
        // Skip whitespaces and special characters
        // This loop stops when the first non-whitespace, non-special character
        // is found
        // Check for comments
        if(ch == '/')
        {
            ch = getchar();
            if(ch == '/')
            {
                // Found a single line comment
                while((ch = getchar()) !=EOF) if(ch == '\n') break;
                // Ignore till end of line
            }
            else if(ch == '*')
            {
                // Found a multiline comment
                // Ignore till the next /
                while((ch = getchar()) !=EOF) if(ch == '/') break;
            }
            else
            {
                // Something else
                ungetc(ch, stdin);
            }
        }
        if (isspace(ch) || (!isalnum(ch)))
            continue;
        else
            break;
    }
    // We have reached the end of the file, no more words
    if (ch == EOF) {
        buffer[0] = '\0';
        return END_OF_FILE;
    }
    // Check if the first non blank / special character is an underscore or a
    // letter. If the string starts with a digit, it is not a valid identifier
    if (isdigit(ch)) {
        buffer[0] = '\0';
        return NUMBER;
    }
    // Add the current character to the buffer only if it is an underscore / letter
    if(ch == '_' || isalnum(ch))
        buffer[buffer_index++] = ch;
    // Consume the rest of the characters
    while (buffer_index < (wlimit - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        // If the current character is not a number or letter or underscore
        // Unget the character, and don't add it to the word
        if (!isalnum(ch)) {
            if (ch != '_') {
                ungetc(ch, stdin);
                break;
            }
        }
        buffer[buffer_index++] = ch;
    }
    buffer[buffer_index] = '\0';
    return IDENTIFIER;
}

// Performs binary search to find the given word in the table 
// The table must be sorted. This function returns the index of the element which was found
// or -1, if the element was not found
int binary_search(char *word, struct key table[], int n)
{
    int lb = 0, ub = n-1, mid = 0;
    int outcome = 0;
    while(lb <= ub)
    {
        // To prevent integer overflow when both lb and ub are extremely large
        mid = lb + (ub - lb)/2;
        if((outcome = strcmp(word, table[mid].word)) > 0)
        {
            // Word is larger than middle word
            lb = mid + 1;
        }
        else if(outcome < 0)
        {
            // Word is smaller than middle element
            ub = mid - 1;
        }
        else
            // Word matches to the keyword
            return mid;
    }
    // The word was not found in the table
    return -1;
}

int main()
{
    char word[MAX_WORD_SIZE];
    Status status;
    int pos;
    while ((status = get_word(word, MAX_WORD_SIZE)) != END_OF_FILE) {
        if(status != NUMBER)
        {
            if((pos = binary_search(word, keytable, NUMBER_OF_KEYWORDS)) != -1)
            {
                // The word was found
                keytable[pos].count++;
            }
        }
    }
    // Print the count of each keyword
    printf("================ [ COUNT OF KEYWORDS ] ================\n");
    for(size_t i = 0; i < NUMBER_OF_KEYWORDS; i++)
    {
        // Print out only the non zero entries
        if(keytable[i].count)
            printf("%-12s %d\n", keytable[i].word, keytable[i].count);
    }
    printf("================ [ UNUSED KEYWORDS ] ================\n");
    for(size_t i = 0; i < NUMBER_OF_KEYWORDS; i++)
    {
        // Print out the unused keywords
        if(!keytable[i].count)
        {
            printf("%s, ", keytable[i].word);
        }
    }
    printf("\n");
    printf("================================\n");
}
/*Exercise 6-2. Write a program that reads a C program and prints in
alphabetical order each group of variable names that are identical in the first
6 characters, but different somewhere thereafter. Don't count words within
strings and comments. Make 6 a parameter that can be set from the command
line.*/

// Algorithm
// =========
// 1. Get all identifiers from the program (exclude strings and comments)
// 2. Check if the identifier is a variable.
//      I have simplified this part and considered a variable as any word other
//      than keywords This means that function names, structure names and others
//      will be considered as variable names
// 3. Create a node with the word and add it to the BST
// 4. If the word is a substring of the root node to which this word is to be
// inserted, insert the node to another tree

// Example:
// ┌─────────────────────────────────────────────────────────────────┐
// │                                                                 │
// │                                    │  fish  │                   │
// │                                    │        │                   │
// │   N = 3                            │        │                   │
// │   https://asciiflow.com/#/         │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                  │ dogg│   ────────┘        └─────────  goat    │
// │                  │     │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │    cat    ───────┘  │  └────── eat                              │
// │                     │                                           │
// │                     │                                           │
// │                     ├────────┐                                  │
// │                     │        │                                  │
// │                     │        │                                  │
// │                     │        │                                  │
// │           doga──────┘        └───────dogi                       │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │               dogd ───┘ └──────dogj              │
// │              └──────dogb                                        │
// │                                                                 │
// │                                                                 │
// │                                                                 │
// └─────────────────────────────────────────────────────────────────┘

// In short, if the word in the node to be inserted has that many same chars as
// its parent node, insert it into another tree

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "utest.h"
int n = 0;

typedef struct Node {
    char *word;
    struct Node *left;
    struct Node *right;
    struct Node *subtree_left;
    struct Node *subtree_right;
} Node;

int are_first_n_chars_identical(const char *s, const char *t, int n_chars)
{
    for (int i = 0; i < n_chars; i++) {
        if (s[i] != t[i]) return 0;
        if (s[i] == '\0' || t[i] == '\0') return 0;
    }
    return 1;
}

Node *add_subtree(Node *node, char *word)
{
    int expr;
    // Adds the word to the tree and returns the node which was passed
    // or if node is null, it returns the new node.
    if (node == NULL) {
        node = malloc(sizeof(Node));
        if (!node) {
            printf("Error while creating subtree node ! memory error\n");
            return NULL;
        }
        node->word = malloc(
            sizeof(char) *
            (strlen(word) + 1));  // +1 is to accomodate the null character
        if (!node->word) {
            printf("Error while copying the word to subtree");
            return NULL;
        }
        node->right = NULL;
        node->left = NULL;
        node->subtree_right = NULL;
        node->subtree_left = NULL;
        strcpy(node->word, word);
        return node;
    }
    // TODO: Check that the word is not NULL
    else if ((expr = strcmp(word, node->word)) > 0) {
        // Check if the word is bigger than that of the subtree node
        node->subtree_right = add_subtree(node->subtree_right, word);
    }
    else if (expr < 0) {
        // Check if the word is smaller than that of the subtree node
        node->subtree_left = add_subtree(node->subtree_right, word);
        // ERROR: Change this line to make this program work
         //node->subtree_left = add_subtree(node->subtree_left, word);
    }
    // No need to check if the word is same as that of the node
    return node;
}

Node *add_tree(Node *node, char *word)
{
    int expr = 0;
    // Adds the word to the tree and returns the node which was passed
    // or if node is null, it returns the new node.
    if (node == NULL) {
        node = malloc(sizeof(Node));
        if (!node) {
            printf("Error while creating node ! memory error\n");
            return NULL;
        }
        node->word = malloc(
            sizeof(char) *
            (strlen(word) + 1));  // +1 is to accomodate the null character
        if (!node->word) {
            printf("Error while copying the word");
            return NULL;
        }
        node->right = NULL;
        node->left = NULL;
        node->subtree_right = NULL;
        node->subtree_left = NULL;
        strcpy(node->word, word);
        return node;
    }
    // Check that the word is not NULL
    else if (are_first_n_chars_identical(node->word, word, n)) {
        // Check if the first n characters of the word are same as that of the
        // node
        if (strcmp(word, node->word) > 0) {
            node->subtree_right = add_subtree(node->subtree_right, word);
        }
        if (strcmp(word, node->word) < 0) {
            node->subtree_left = add_subtree(node->subtree_left, word);
        }
    }
    else if ((expr = strcmp(word, node->word)) > 0) {
        // Check if the word is bigger than that of the node
        node->right = add_tree(node->right, word);
    }
    else if (expr < 0) {
        node->left = add_tree(node->left, word);
        // Check if the word is smaller than that of the node
    }
    // No need to check if the word is same as that of the node
    return node;
}
/*
Node *add_tree(Node *root, char *word)
{
    int val;
    if (root == NULL) {
        root = malloc(sizeof(Node));
        if (!root) {
            printf("Couldn't allocate memory for node");
            // May be due to some memory issue
            return NULL;
        }
        // +1 for storing the null character
        root->word = malloc(sizeof(char) * (strlen(word) + 1));
        if (!root) {
            printf("Couldn't allocate memory for word in node");
            return NULL;
        }
        strcpy(root->word, word);
        root->left = NULL;
        root->right = NULL;
    }
    else if(are_first_n_chars_identical(root->word, word, n))
    {
        // Check if the first n characters of the word are same as that of the
node printf("Contains: %s\n",word);
    }
    // if (!root->word) {
    //    // The node does not have a valid word
    //    return NULL;
    //}
    else if ((val = strcmp(word, root->word)) > 0) {
        // The new word is greater than the old word
        root->right = add_tree(root->right, word);
    }
    else if (val < 0) {
        // The new word is smaller than the old word
        root->left = add_tree(root->left, word);
    }
    return root;
}
*/

typedef enum status { END_OF_FILE, NULL_BUFFER, TXTWORD } status;

#define MAX_TXTWORD_SIZE 100

void print_tree(Node *root, int to_print)
{
    if (root) {
        // print the left half first
        print_tree(root->subtree_left, 1);
        print_tree(root->left, 0);
        // print the contents of this node
        if (to_print || root->subtree_right || root->subtree_left)
            printf("%s\n", root->word);
        // print the right half next
        print_tree(root->subtree_right, 1);
        print_tree(root->right, 0);
    }
}

void free_subtree(Node *sub_tree)
{
    // Frees a single subtree
    if (sub_tree) {
        free_subtree(sub_tree->subtree_left);
        free_subtree(sub_tree->subtree_right);

        free(sub_tree->word);
        free(sub_tree);
    }
}

void free_tree(Node *tree)
{
    if (tree) {
        free_tree(tree->right);
        free_tree(tree->left);

        free_subtree(tree->subtree_left);
        free_subtree(tree->subtree_right);

        free(tree->word);
        free(tree);
    }
}

int is_invalid_char(int ch)
{
    if (ch == EOF) return 0;
    return ch == ' ' || !isalnum(ch);
}

status get_word(char *buffer, size_t buffer_size)
{
    size_t buffer_index = 0;
    int ch;

    if (!buffer) return NULL_BUFFER;

    // Skip whitespaces and special chars
    while (is_invalid_char(ch = getchar())) {
        if (ch == '/') {
            ch = getchar();
            if (ch == '/') {
                while ((ch = getchar()))
                    if (ch == '\n') break;
            }
            else {
                ungetc(ch, stdin);
            }
        }
    }
    if (ch == EOF) return END_OF_FILE;
    // Add ch to the buffer
    buffer[buffer_index++] = ch;
    // Get the rest of the word
    // We can read atmost buffer_size-1 chars to make one space free for the
    // null character
    while (buffer_index < (buffer_size - 1)) {
        ch = getchar();
        if (ch == EOF) {
            break;
        }
        if (is_invalid_char(ch)) {
            ungetc(ch, stdin);
            break;
        }
        buffer[buffer_index++] = ch;
    }
    buffer[buffer_index] = '\0';
    return TXTWORD;
}

int main(int argc, char *argv[])
{
    if (argc == 2) {
        if (strcmp("test", argv[1]) == 0) {
            exit(utest_main(argc, argv));
        }
        n = atoi(argv[1]);
    }
    if (argc != 2) {
        printf("Usage: ./exercise-6-2 n\n");
        printf("n is the number of starting chars\n");
        n = 2;
    }
    struct Node *root = NULL;
    status s;
    char buffer[MAX_TXTWORD_SIZE] = {'\0'};
    for (;;) {
        s = get_word(buffer, MAX_TXTWORD_SIZE);
        if (s == END_OF_FILE) break;
        if (s == TXTWORD) {
            root = add_tree(root, buffer);
        }
    }
    // :/ - this does not work as expected --- there are too many memory bugs
    // Rewrite this program again
    print_tree(root, 0);
    free_tree(root);
}

UTEST(test_tree, test_correct_insertion)
{
    n = 3;
    Node *root = NULL;
    root = add_tree(root, "hello");
    ASSERT_STREQ("hello", root->word);

    root = add_tree(root, "zello");
    ASSERT_NE(NULL, root->right);
    ASSERT_STREQ("zello", root->right->word);

    root = add_tree(root, "aello");
    ASSERT_NE(NULL, root->left);
    ASSERT_STREQ("aello", root->left->word);

    ASSERT_EQ(NULL, root->subtree_left);
    ASSERT_EQ(NULL, root->subtree_right);
    free_tree(root);
}

UTEST(test_tree, test_correct_insertion_multiple)
{
    n = 3;
    Node *root = NULL;
    root = add_tree(root, "the");
    ASSERT_STREQ("the", root->word);

    root = add_tree(root, "zuick");
    ASSERT_NE(NULL, root->right);
    ASSERT_STREQ("zuick", root->right->word);

    root = add_tree(root, "brown");
    ASSERT_NE(NULL, root->left);
    ASSERT_STREQ("brown", root->left->word);

    root = add_tree(root, "jumps");
    ASSERT_NE(NULL, root->left->right);
    ASSERT_STREQ("jumps", root->left->right->word);

    ASSERT_EQ(NULL, root->subtree_left);
    ASSERT_EQ(NULL, root->subtree_right);
    free_tree(root);
}

UTEST(test_tree, test_words_with_same_prefix)
{
    n = 3;
    Node *root = NULL;
    root = add_tree(root, "the");
    ASSERT_STREQ("the", root->word);

    root = add_tree(root, "ther");
    ASSERT_NE(NULL, root->subtree_right);
    ASSERT_STREQ("ther", root->subtree_right->word);

    root = add_tree(root, "thea");
    ASSERT_NE(NULL, root->subtree_right->subtree_left);
    ASSERT_STREQ("thea", root->subtree_right->subtree_left->word);

    root = add_tree(root, "thezn");
    ASSERT_NE(NULL, root->subtree_right->subtree_right);
    ASSERT_STREQ("thezn", root->subtree_right->subtree_right->word);

    root = add_tree(root, "thezq");
    ASSERT_NE(NULL, root->subtree_right->subtree_right->subtree_right);
    ASSERT_STREQ("thezq", root->subtree_right->subtree_right->subtree_right->word);

    root = add_tree(root, "theza");
    ASSERT_NE(NULL, root->subtree_right->subtree_right->subtree_left);
    ASSERT_STREQ("theza", root->subtree_right->subtree_right->subtree_left->word);

    ASSERT_EQ(NULL, root->right);
    ASSERT_EQ(NULL, root->left);
    free_tree(root);
}
UTEST_STATE();
/*Exercise 6-2. Write a program that reads a C program and prints in alphabetical order each
group of variable names that are identical in the first 6 characters, but different somewhere
thereafter. Don't count words within strings and comments. Make 6 a parameter that can be
set from the command line.*/

// Algorithm
// =========
// 1. Get all identifiers from the program (exclude strings and comments)
// 2. Check if the identifier is a variable.
//      I have simplified this part and considered a variable as any word other than keywords
//      This means that function names, structure names and others will be considered as variable names
// 3. Create a node with the word and add it to the BST
// 4. If the word is a substring of the root node to which this word is to be inserted, insert the node to another tree

// Example:
// ┌─────────────────────────────────────────────────────────────────┐
// │                                                                 │
// │                                    │  fish  │                   │
// │                                    │        │                   │
// │   N = 3                            │        │                   │
// │   https://asciiflow.com/#/         │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                                    │        │                   │
// │                  │ dogg│   ────────┘        └─────────  goat    │
// │                  │     │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │                  │  │  │                                        │
// │    cat    ───────┘  │  └────── eat                              │
// │                     │                                           │
// │                     │                                           │
// │                     ├────────┐                                  │
// │                     │        │                                  │
// │                     │        │                                  │
// │                     │        │                                  │
// │           doga──────┘        └───────dogi                       │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │                       │ │                        │
// │              │               dogd ───┘ └──────dogj              │
// │              └──────dogb                                        │
// │                                                                 │
// │                                                                 │
// │                                                                 │
// └─────────────────────────────────────────────────────────────────┘

// In short, if the word in the node to be inserted has that many same chars as its parent node, insert it into another tree

#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>
int n;

typedef struct Node
{
    char *word;
    struct Node *left;
    struct Node *right;
    // struct Node *subtree_left;
    // struct Node *subtree_right;
    struct Node *sub_left;
    struct Node *sub_right;
} Node;

int are_first_n_chars_identical(const char *s, const char *t, int n_chars)
{
    for(int i = 0; i < n_chars; i++)
    {
        if(s[i] != t[i])
            return 0;
        if(s[i] == '\0' || t[i] == '\0')
            return 0;
    }
    return 1;
}

Node *add_subtree(struct Node *node, char *word)
{
    int expr;
    // Adds the word to the tree and returns the node which was passed
    // or if node is null, it returns the new node.
    if(node == NULL)
    {
        node = malloc(sizeof(struct Node));
        if(!node)
        {
            printf("Error while creating subtree node ! memory error\n");
            return NULL;
        }
        node->word = malloc(sizeof(char) * (strlen(word)+1)); // +1 is to accomodate the null character
        if(!node->word)
        {
            printf("Error while copying the word to subtree");
            return NULL;
        }
        node->right = NULL;
        node->left = NULL;
        strcpy(node->word, word);
        return node;
    }
    // TODO: Check that the word is not NULL
    else if((expr = strcmp(word, node->word)) > 0)
    {
        // Check if the word is bigger than that of the subtree node
        node->right = add_subtree(node->right, word);
    }
    else if(expr < 0)
    {
        // Check if the word is smaller than that of the subtree node
        node->left = add_subtree(node->left, word);
    }
    // No need to check if the word is same as that of the node
    return node;
}

Node *add_tree(Node *node, char *word)
{
    int expr = 0;
    // Adds the word to the tree and returns the node which was passed
    // or if node is null, it returns the new node.
    if(node == NULL)
    {
        node = malloc(sizeof(Node));
        if(!node)
        {
            printf("Error while creating node ! memory error\n");
            return NULL;
        }
        node->word = malloc(sizeof(char) * (strlen(word)+1)); // +1 is to accomodate the null character
        if(!node->word)
        {
            printf("Error while copying the word");
            return NULL;
        }
        node->right = NULL;
        node->left = NULL;
        node->sub_right = NULL;
        node->sub_left = NULL;
        strcpy(node->word, word);
        return node;
    }
    // Check that the word is not NULL
    else if(are_first_n_chars_identical(node->word, word, n))
    {
        // Check if the first n characters of the word are same as that of the node
        if(strcmp(word, node->word) > 0)
        {
            node->sub_right = add_subtree(node->sub_right, word);
        }
        if(strcmp(word, node->word) < 0)
        {
            node->sub_left = add_subtree(node->sub_left, word);
        }
    }
    else if((expr = strcmp(word, node->word)) > 0)
    {
        // Check if the word is bigger than that of the node
        node->right = add_tree(node->right, word);

    }
    else if(expr < 0)
    {
        node->left = add_tree(node->left, word);
        // Check if the word is smaller than that of the node
    }
    // No need to check if the word is same as that of the node
    return node;
}

typedef enum status { END_OF_FILE, NULL_BUFFER, WORD } status;

#define MAX_WORD_SIZE 100

void print_subtree(struct Node *node)
{
    if(node){
        print_subtree(node->left);
        printf("%s\n", node->word);
        print_subtree(node->right);
    }
}
void print_tree(Node *root, int to_print)
{
    if (root) {
        // print the left half first
        print_subtree(root->sub_left);
        // print the contents of this node
        if(to_print || root->sub_left || root->sub_right)
            printf("%s\n", root->word);
        // print the right half next
        print_subtree(root->sub_right);

        print_tree(root->left, 0);
        print_tree(root->right, 0);
    }
}

void free_subtree(struct Node *node)
{
    if (node) {
        free_subtree(node->left);
        free_subtree(node->right);
        free(node->word);
        free(node);
    }
}


void free_tree(Node *tree)
{
    if (tree) {
        free_tree(tree->left);
        free_tree(tree->right);

        free_subtree(tree->sub_left);
        free_subtree(tree->sub_right);

        free(tree->word);
        free(tree);
    }
}



int is_invalid_char(int ch)
{
    if (ch == EOF) return 0;
    return ch == ' ' || !isalnum(ch);
}

status get_word(char *buffer, size_t buffer_size)
{
    size_t buffer_index = 0;
    int ch;

    if (!buffer) return NULL_BUFFER;

    // Skip whitespaces and special chars
    while (is_invalid_char(ch = getchar()))
    {
        if(ch == '/')
        {
            ch = getchar();
            if(ch == '/')
            {
                while((ch = getchar())) if(ch == '\n') break;
            }
            else
            {
                ungetc(ch, stdin);
            }
        }
    }
    if (ch == EOF) return END_OF_FILE;
    // Add ch to the buffer
    buffer[buffer_index++] = ch;
    // Get the rest of the word
    // We can read atmost buffer_size-1 chars to make one space free for the
    // null character
    while (buffer_index < (buffer_size - 1)) {
        ch = getchar();
        if (ch == EOF) {
            break;
        }
        if (is_invalid_char(ch)) {
            ungetc(ch, stdin);
            break;
        }
        buffer[buffer_index++] = ch;
    }
    buffer[buffer_index] = '\0';
    return WORD;
}



int main(int argc, char *argv[])
{
    if(argc == 2)
        n = atoi(argv[1]);
    else if(argc != 2)
    {
        printf("Usage: ./exercise-6-2 n\n");
        printf("n is the number of starting chars\n");
        n = 2;
    }
    struct Node *root = NULL;
    status s;
    char buffer[MAX_WORD_SIZE] = {'\0'};
    for (;;) {
        s = get_word(buffer, MAX_WORD_SIZE);
        if (s == END_OF_FILE) break;
        if (s == WORD) {
            root = add_tree(root, buffer);
        }
    }
    // :/ - this does not work as expected --- there are too many memory bugs
    // Rewrite this program again
    print_tree(root, 0);
    free_tree(root);
}/*
Exercise 6-3. Write a cross-referencer that prints a list of all words in a
document, and for each word, a list of the line numbers on which it occurs.
Remove noise words like ``the,''
``and,'' and so on.
*/
#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef __WIN32
#define ignorecasecmp_str strcasecmp
#include <strings.h>
#else
#define ignorecasecmp_str stricmp
#endif
#include <string.h>

#define MAX_WORD_SIZE 128
// Taken from here - https://gist.github.com/sebleier/554280
const static char *stopwords[] = {
    "0o",
    "0s",
    "3a",
    "3b",
    "3d",
    "6b",
    "6o",
    "a",
    "a1",
    "a2",
    "a3",
    "a4",
    "ab",
    "able",
    "about",
    "above",
    "abst",
    "ac",
    "accordance",
    "according",
    "accordingly",
    "across",
    "act",
    "actually",
    "ad",
    "added",
    "adj",
    "ae",
    "af",
    "affected",
    "affecting",
    "affects",
    "after",
    "afterwards",
    "ag",
    "again",
    "against",
    "ah",
    "ain",
    "ain't",
    "aj",
    "al",
    "all",
    "allow",
    "allows",
    "almost",
    "alone",
    "along",
    "already",
    "also",
    "although",
    "always",
    "am",
    "among",
    "amongst",
    "amoungst",
    "amount",
    "an",
    "and",
    "announce",
    "another",
    "any",
    "anybody",
    "anyhow",
    "anymore",
    "anyone",
    "anything",
    "anyway",
    "anyways",
    "anywhere",
    "ao",
    "ap",
    "apart",
    "apparently",
    "appear",
    "appreciate",
    "appropriate",
    "approximately",
    "ar",
    "are",
    "aren",
    "arent",
    "aren't",
    "arise",
    "around",
    "as",
    "a's",
    "aside",
    "ask",
    "asking",
    "associated",
    "at",
    "au",
    "auth",
    "av",
    "available",
    "aw",
    "away",
    "awfully",
    "ax",
    "ay",
    "az",
    "b",
    "b1",
    "b2",
    "b3",
    "ba",
    "back",
    "bc",
    "bd",
    "be",
    "became",
    "because",
    "become",
    "becomes",
    "becoming",
    "been",
    "before",
    "beforehand",
    "begin",
    "beginning",
    "beginnings",
    "begins",
    "behind",
    "being",
    "believe",
    "below",
    "beside",
    "besides",
    "best",
    "better",
    "between",
    "beyond",
    "bi",
    "bill",
    "biol",
    "bj",
    "bk",
    "bl",
    "bn",
    "both",
    "bottom",
    "bp",
    "br",
    "brief",
    "briefly",
    "bs",
    "bt",
    "bu",
    "but",
    "bx",
    "by",
    "c",
    "c1",
    "c2",
    "c3",
    "ca",
    "call",
    "came",
    "can",
    "cannot",
    "cant",
    "can't",
    "cause",
    "causes",
    "cc",
    "cd",
    "ce",
    "certain",
    "certainly",
    "cf",
    "cg",
    "ch",
    "changes",
    "ci",
    "cit",
    "cj",
    "cl",
    "clearly",
    "cm",
    "c'mon",
    "cn",
    "co",
    "com",
    "come",
    "comes",
    "con",
    "concerning",
    "consequently",
    "consider",
    "considering",
    "contain",
    "containing",
    "contains",
    "corresponding",
    "could",
    "couldn",
    "couldnt",
    "couldn't",
    "course",
    "cp",
    "cq",
    "cr",
    "cry",
    "cs",
    "c's",
    "ct",
    "cu",
    "currently",
    "cv",
    "cx",
    "cy",
    "cz",
    "d",
    "d2",
    "da",
    "date",
    "dc",
    "dd",
    "de",
    "definitely",
    "describe",
    "described",
    "despite",
    "detail",
    "df",
    "di",
    "did",
    "didn",
    "didn't",
    "different",
    "dj",
    "dk",
    "dl",
    "do",
    "does",
    "doesn",
    "doesn't",
    "doing",
    "don",
    "done",
    "don't",
    "down",
    "downwards",
    "dp",
    "dr",
    "ds",
    "dt",
    "du",
    "due",
    "during",
    "dx",
    "dy",
    "e",
    "e2",
    "e3",
    "ea",
    "each",
    "ec",
    "ed",
    "edu",
    "ee",
    "ef",
    "effect",
    "eg",
    "ei",
    "eight",
    "eighty",
    "either",
    "ej",
    "el",
    "eleven",
    "else",
    "elsewhere",
    "em",
    "empty",
    "en",
    "end",
    "ending",
    "enough",
    "entirely",
    "eo",
    "ep",
    "eq",
    "er",
    "es",
    "especially",
    "est",
    "et",
    "et-al",
    "etc",
    "eu",
    "ev",
    "even",
    "ever",
    "every",
    "everybody",
    "everyone",
    "everything",
    "everywhere",
    "ex",
    "exactly",
    "example",
    "except",
    "ey",
    "f",
    "f2",
    "fa",
    "far",
    "fc",
    "few",
    "ff",
    "fi",
    "fifteen",
    "fifth",
    "fify",
    "fill",
    "find",
    "fire",
    "first",
    "five",
    "fix",
    "fj",
    "fl",
    "fn",
    "fo",
    "followed",
    "following",
    "follows",
    "for",
    "former",
    "formerly",
    "forth",
    "forty",
    "found",
    "four",
    "fr",
    "from",
    "front",
    "fs",
    "ft",
    "fu",
    "full",
    "further",
    "furthermore",
    "fy",
    "g",
    "ga",
    "gave",
    "ge",
    "get",
    "gets",
    "getting",
    "gi",
    "give",
    "given",
    "gives",
    "giving",
    "gj",
    "gl",
    "go",
    "goes",
    "going",
    "gone",
    "got",
    "gotten",
    "gr",
    "greetings",
    "gs",
    "gy",
    "h",
    "h2",
    "h3",
    "had",
    "hadn",
    "hadn't",
    "happens",
    "hardly",
    "has",
    "hasn",
    "hasnt",
    "hasn't",
    "have",
    "haven",
    "haven't",
    "having",
    "he",
    "hed",
    "he'd",
    "he'll",
    "hello",
    "help",
    "hence",
    "her",
    "here",
    "hereafter",
    "hereby",
    "herein",
    "heres",
    "here's",
    "hereupon",
    "hers",
    "herself",
    "hes",
    "he's",
    "hh",
    "hi",
    "hid",
    "him",
    "himself",
    "his",
    "hither",
    "hj",
    "ho",
    "home",
    "hopefully",
    "how",
    "howbeit",
    "however",
    "how's",
    "hr",
    "hs",
    "http",
    "hu",
    "hundred",
    "hy",
    "i",
    "i2",
    "i3",
    "i4",
    "i6",
    "i7",
    "i8",
    "ia",
    "ib",
    "ibid",
    "ic",
    "id",
    "i'd",
    "ie",
    "if",
    "ig",
    "ignored",
    "ih",
    "ii",
    "ij",
    "il",
    "i'll",
    "im",
    "i'm",
    "immediate",
    "immediately",
    "importance",
    "important",
    "in",
    "inasmuch",
    "inc",
    "indeed",
    "index",
    "indicate",
    "indicated",
    "indicates",
    "information",
    "inner",
    "insofar",
    "instead",
    "interest",
    "into",
    "invention",
    "inward",
    "io",
    "ip",
    "iq",
    "ir",
    "is",
    "isn",
    "isn't",
    "it",
    "itd",
    "it'd",
    "it'll",
    "its",
    "it's",
    "itself",
    "iv",
    "i've",
    "ix",
    "iy",
    "iz",
    "j",
    "jj",
    "jr",
    "js",
    "jt",
    "ju",
    "just",
    "k",
    "ke",
    "keep",
    "keeps",
    "kept",
    "kg",
    "kj",
    "km",
    "know",
    "known",
    "knows",
    "ko",
    "l",
    "l2",
    "la",
    "largely",
    "last",
    "lately",
    "later",
    "latter",
    "latterly",
    "lb",
    "lc",
    "le",
    "least",
    "les",
    "less",
    "lest",
    "let",
    "lets",
    "let's",
    "lf",
    "like",
    "liked",
    "likely",
    "line",
    "little",
    "lj",
    "ll",
    "ll",
    "ln",
    "lo",
    "look",
    "looking",
    "looks",
    "los",
    "lr",
    "ls",
    "lt",
    "ltd",
    "m",
    "m2",
    "ma",
    "made",
    "mainly",
    "make",
    "makes",
    "many",
    "may",
    "maybe",
    "me",
    "mean",
    "means",
    "meantime",
    "meanwhile",
    "merely",
    "mg",
    "might",
    "mightn",
    "mightn't",
    "mill",
    "million",
    "mine",
    "miss",
    "ml",
    "mn",
    "mo",
    "more",
    "moreover",
    "most",
    "mostly",
    "move",
    "mr",
    "mrs",
    "ms",
    "mt",
    "mu",
    "much",
    "mug",
    "must",
    "mustn",
    "mustn't",
    "my",
    "myself",
    "n",
    "n2",
    "na",
    "name",
    "namely",
    "nay",
    "nc",
    "nd",
    "ne",
    "near",
    "nearly",
    "necessarily",
    "necessary",
    "need",
    "needn",
    "needn't",
    "needs",
    "neither",
    "never",
    "nevertheless",
    "new",
    "next",
    "ng",
    "ni",
    "nine",
    "ninety",
    "nj",
    "nl",
    "nn",
    "no",
    "nobody",
    "non",
    "none",
    "nonetheless",
    "noone",
    "nor",
    "normally",
    "nos",
    "not",
    "noted",
    "nothing",
    "novel",
    "now",
    "nowhere",
    "nr",
    "ns",
    "nt",
    "ny",
    "o",
    "oa",
    "ob",
    "obtain",
    "obtained",
    "obviously",
    "oc",
    "od",
    "of",
    "off",
    "often",
    "og",
    "oh",
    "oi",
    "oj",
    "ok",
    "okay",
    "ol",
    "old",
    "om",
    "omitted",
    "on",
    "once",
    "one",
    "ones",
    "only",
    "onto",
    "oo",
    "op",
    "oq",
    "or",
    "ord",
    "os",
    "ot",
    "other",
    "others",
    "otherwise",
    "ou",
    "ought",
    "our",
    "ours",
    "ourselves",
    "out",
    "outside",
    "over",
    "overall",
    "ow",
    "owing",
    "own",
    "ox",
    "oz",
    "p",
    "p1",
    "p2",
    "p3",
    "page",
    "pagecount",
    "pages",
    "par",
    "part",
    "particular",
    "particularly",
    "pas",
    "past",
    "pc",
    "pd",
    "pe",
    "per",
    "perhaps",
    "pf",
    "ph",
    "pi",
    "pj",
    "pk",
    "pl",
    "placed",
    "please",
    "plus",
    "pm",
    "pn",
    "po",
    "poorly",
    "possible",
    "possibly",
    "potentially",
    "pp",
    "pq",
    "pr",
    "predominantly",
    "present",
    "presumably",
    "previously",
    "primarily",
    "probably",
    "promptly",
    "proud",
    "provides",
    "ps",
    "pt",
    "pu",
    "put",
    "py",
    "q",
    "qj",
    "qu",
    "que",
    "quickly",
    "quite",
    "qv",
    "r",
    "r2",
    "ra",
    "ran",
    "rather",
    "rc",
    "rd",
    "re",
    "readily",
    "really",
    "reasonably",
    "recent",
    "recently",
    "ref",
    "refs",
    "regarding",
    "regardless",
    "regards",
    "related",
    "relatively",
    "research",
    "research-articl",
    "respectively",
    "resulted",
    "resulting",
    "results",
    "rf",
    "rh",
    "ri",
    "right",
    "rj",
    "rl",
    "rm",
    "rn",
    "ro",
    "rq",
    "rr",
    "rs",
    "rt",
    "ru",
    "run",
    "rv",
    "ry",
    "s",
    "s2",
    "sa",
    "said",
    "same",
    "saw",
    "say",
    "saying",
    "says",
    "sc",
    "sd",
    "se",
    "sec",
    "second",
    "secondly",
    "section",
    "see",
    "seeing",
    "seem",
    "seemed",
    "seeming",
    "seems",
    "seen",
    "self",
    "selves",
    "sensible",
    "sent",
    "serious",
    "seriously",
    "seven",
    "several",
    "sf",
    "shall",
    "shan",
    "shan't",
    "she",
    "shed",
    "she'd",
    "she'll",
    "shes",
    "she's",
    "should",
    "shouldn",
    "shouldn't",
    "should've",
    "show",
    "showed",
    "shown",
    "showns",
    "shows",
    "si",
    "side",
    "significant",
    "significantly",
    "similar",
    "similarly",
    "since",
    "sincere",
    "six",
    "sixty",
    "sj",
    "sl",
    "slightly",
    "sm",
    "sn",
    "so",
    "some",
    "somebody",
    "somehow",
    "someone",
    "somethan",
    "something",
    "sometime",
    "sometimes",
    "somewhat",
    "somewhere",
    "soon",
    "sorry",
    "sp",
    "specifically",
    "specified",
    "specify",
    "specifying",
    "sq",
    "sr",
    "ss",
    "st",
    "still",
    "stop",
    "strongly",
    "sub",
    "substantially",
    "successfully",
    "such",
    "sufficiently",
    "suggest",
    "sup",
    "sure",
    "sy",
    "system",
    "sz",
    "t",
    "t1",
    "t2",
    "t3",
    "take",
    "taken",
    "taking",
    "tb",
    "tc",
    "td",
    "te",
    "tell",
    "ten",
    "tends",
    "tf",
    "th",
    "than",
    "thank",
    "thanks",
    "thanx",
    "that",
    "that'll",
    "thats",
    "that's",
    "that've",
    "the",
    "their",
    "theirs",
    "them",
    "themselves",
    "then",
    "thence",
    "there",
    "thereafter",
    "thereby",
    "thered",
    "therefore",
    "therein",
    "there'll",
    "thereof",
    "therere",
    "theres",
    "there's",
    "thereto",
    "thereupon",
    "there've",
    "these",
    "they",
    "theyd",
    "they'd",
    "they'll",
    "theyre",
    "they're",
    "they've",
    "thickv",
    "thin",
    "think",
    "third",
    "this",
    "thorough",
    "thoroughly",
    "those",
    "thou",
    "though",
    "thoughh",
    "thousand",
    "three",
    "throug",
    "through",
    "throughout",
    "thru",
    "thus",
    "ti",
    "til",
    "tip",
    "tj",
    "tl",
    "tm",
    "tn",
    "to",
    "together",
    "too",
    "took",
    "top",
    "toward",
    "towards",
    "tp",
    "tq",
    "tr",
    "tried",
    "tries",
    "truly",
    "try",
    "trying",
    "ts",
    "t's",
    "tt",
    "tv",
    "twelve",
    "twenty",
    "twice",
    "two",
    "tx",
    "u",
    "u201d",
    "ue",
    "ui",
    "uj",
    "uk",
    "um",
    "un",
    "under",
    "unfortunately",
    "unless",
    "unlike",
    "unlikely",
    "until",
    "unto",
    "uo",
    "up",
    "upon",
    "ups",
    "ur",
    "us",
    "use",
    "used",
    "useful",
    "usefully",
    "usefulness",
    "uses",
    "using",
    "usually",
    "ut",
    "v",
    "va",
    "value",
    "various",
    "vd",
    "ve",
    "ve",
    "very",
    "via",
    "viz",
    "vj",
    "vo",
    "vol",
    "vols",
    "volumtype",
    "vq",
    "vs",
    "vt",
    "vu",
    "w",
    "wa",
    "want",
    "wants",
    "was",
    "wasn",
    "wasnt",
    "wasn't",
    "way",
    "we",
    "wed",
    "we'd",
    "welcome",
    "well",
    "we'll",
    "well-b",
    "went",
    "were",
    "we're",
    "weren",
    "werent",
    "weren't",
    "we've",
    "what",
    "whatever",
    "what'll",
    "whats",
    "what's",
    "when",
    "whence",
    "whenever",
    "when's",
    "where",
    "whereafter",
    "whereas",
    "whereby",
    "wherein",
    "wheres",
    "where's",
    "whereupon",
    "wherever",
    "whether",
    "which",
    "while",
    "whim",
    "whither",
    "who",
    "whod",
    "whoever",
    "whole",
    "who'll",
    "whom",
    "whomever",
    "whos",
    "who's",
    "whose",
    "why",
    "why's",
    "wi",
    "widely",
    "will",
    "willing",
    "wish",
    "with",
    "within",
    "without",
    "wo",
    "won",
    "wonder",
    "wont",
    "won't",
    "words",
    "world",
    "would",
    "wouldn",
    "wouldnt",
    "wouldn't",
    "www",
    "x",
    "x1",
    "x2",
    "x3",
    "xf",
    "xi",
    "xj",
    "xk",
    "xl",
    "xn",
    "xo",
    "xs",
    "xt",
    "xv",
    "xx",
    "y",
    "y2",
    "yes",
    "yet",
    "yj",
    "yl",
    "you",
    "youd",
    "you'd",
    "you'll",
    "your",
    "youre",
    "you're",
    "yours",
    "yourself",
    "yourselves",
    "you've",
    "yr",
    "ys",
    "yt",
    "z",
    "zero",
    "zi",
    "zz",
};

#define STOPWORD_SIZE (sizeof(stopwords) / (sizeof(char *)))
int is_stopword(const char *s)
{
    // Checks if the string is a stopword such as the, and, or etc
    int lb = 0, ub = STOPWORD_SIZE - 1;
    int mid = 0;
    int expr = 0;
    while (lb <= ub) {
        mid = lb + ((ub - lb) / 2);
        if ((expr = ignorecasecmp_str(s, stopwords[mid])) > 0) {
            lb = mid + 1;
        }
        else if (expr < 0) {
            ub = mid - 1;
        }
        else
            return mid;
    }
    return -1;
}
int is_word_separator(const char ch)
{
    if (ch == EOF) return 0;
    return !isalnum(ch);
}
int getword(char *buffer, size_t n, int *line_number)
{
    size_t buffer_index = 0;
    int ch;
    static int line_number__ = 1; // Since lines start from 1

    // Check if size is 0
    if (n == 0) {
        if (line_number) *line_number = line_number__;
        return 0;
    }
    // Skip all word separators
    while (is_word_separator(ch = getchar()))
        if (ch == '\n') line_number__++;
    ;
    if (ch == EOF) {
        buffer[buffer_index] = '\0';
        if (line_number) *line_number = line_number__;
        return EOF;
    }
    buffer[buffer_index++] = ch;

    while (buffer_index < (n - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        if (ch == '\n') line_number__++;
        if (is_word_separator(ch)) break;
        buffer[buffer_index++] = ch;
    }
    buffer[buffer_index] = '\0';
    if (line_number) *line_number = line_number__;
    return buffer_index;
}

// I am going to use a binary tree with a linked list inside it for the lines in
// which it appears
typedef struct ListNode {
    int value;
    struct ListNode *next;
} ListNode;
typedef struct TreeNode {
    struct ListNode *list;
    struct ListNode *list_end;
    char *word;
    struct TreeNode *right;
    struct TreeNode *left;
} TreeNode;

TreeNode *create_tree(TreeNode *root, char *word, int line_number)
{
    int expr = 0;
    if (root == NULL) {
        root = malloc(sizeof(TreeNode));
        if (!root) {
            printf(
                "Error: Unable to create a node in the tree, looks like your "
                "computer has run out of memory\n");
            exit(1);
        }
        root->word = malloc(sizeof(char) * (strlen(word) + 1));
        if (!root->word) {
            printf(
                "Error: Unable to create a node in the tree, looks like your "
                "computer has run out of memory\n");
            exit(1);
        }
        root->right = NULL;
        root->left = NULL;

        root->list = malloc(sizeof(ListNode));
        if (!root->list) {
            printf(
                "Error: Unable to create a node in the list, looks like "
                "your "
                "computer has run out of memory\n");
            exit(1);
        }
        root->list_end = root->list;
        root->list->next = NULL;
        root->list->value = line_number;

        strcpy(root->word, word);
    }
    else if ((expr = ignorecasecmp_str(word, root->word)) > 0) {
        root->right = create_tree(root->right, word, line_number);
    }
    else if (expr < 0) {
        root->left = create_tree(root->left, word, line_number);
    }
    else {
        // This word has already repeated, add the line number to the list
        if (!root->list) {
            root->list = malloc(sizeof(ListNode));
            if (!root->list) {
                printf(
                    "Error: Unable to create a node in the list, looks like "
                    "your "
                    "computer has run out of memory\n");
                exit(1);
            }
            root->list_end = root->list;
            root->list->next = NULL;
            root->list->value = line_number;
        }
        else {
            // A list node already exists, append it to the last node
            ListNode *new_node = malloc(sizeof(ListNode));
            if (!new_node) {
                printf(
                    "Error: Unable to create another node in the list, looks "
                    "like "
                    "your "
                    "computer has run out of memory\n");
                exit(1);
            }
            new_node->value = line_number;
            new_node->next = NULL;
            root->list_end->next = new_node;
            root->list_end = new_node;
        }
    }
    return root;
}

void print_list(ListNode *list)
{
    while (list) {
        // Condition to check if there is one more node
        // This is to determine if a comma is to be printed or not
        if(list->next)
            printf("%d, ", list->value);
        else
            printf("%d", list->value);
        list = list->next;
    }
}

void print_tree(TreeNode *root)
{
    // Displays the tree in-order
    if (root) {
        print_tree(root->left);
        printf("%s: ", root->word);
        print_list(root->list);
        printf("\n");
        print_tree(root->right);
    }
}
void free_tree(TreeNode *root)
{
    if (root) {
        free_tree(root->left);
        free_tree(root->right);
        free_list(root->list);
        free(root->word);
        free(root);
    }
}
void free_list(ListNode *list)
{
    ListNode *tmp;
    while (list) {
        tmp = list;
        list = list->next;
        free(tmp);
    }
}

int main()
{
    int length;
    char buffer[MAX_WORD_SIZE];
    int stop_index = 0;
    int line_number = 0;
    TreeNode *root = NULL;
    while ((length = getword(buffer, MAX_WORD_SIZE, &line_number)) != EOF) {
        if ((stop_index = is_stopword(buffer)) == -1) {
            // Not a stopword
            // printf("%d %s\n", line_number, buffer);
            root = create_tree(root, buffer, line_number);
        }
    }
    print_tree(root);
    free_tree(root);
}
/* Exercise 6-4. Write a program that prints the distinct words in its input
 * sorted into decreasing order of frequency of occurrence. Precede each word by
 * its count. */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_WORD_LENGTH 512
// My method
// 1. Get all the words from the input
// 2. Store all the words and it's frequency in a binary tree
// 3. When adding a node in the binary tree, also add the node to a global
// linked list
// 4. Sort the linked list in non-increasing order
// 5. Display the linked list
//
struct Node {
    char *word;         // Pointer to a word
    int count;          // To count the occurrences of the word
    struct Node *next;  // For the linked list
    struct Node *prev;  // For the linked list

    // Pointer in the binary tree
    struct Node *left;
    struct Node *right;
};

typedef struct Node Node;

Node *node_llist = NULL;
Node *node_head = NULL;

int is_word_separator(const int ch)
{
    if (ch == EOF) return 0;
    return !isalnum(ch);
}

int get_word(char *buffer, int n, int *line_number)
{
    int buffer_index = 0;
    int ch;
    static int line_number__ = 1;  // Since lines start from 1

    // Check if size is 0
    if (n == 0) {
        if (line_number) *line_number = line_number__;
        return 0;
    }
    // Skip all word separators
    while (is_word_separator(ch = getchar()))
        if (ch == '\n') line_number__++;

    if (ch == EOF) {
        buffer[buffer_index] = '\0';
        if (line_number) *line_number = line_number__;
        return EOF;
    }
    buffer[buffer_index++] = (char)ch;

    while (buffer_index < (n - 1)) {
        ch = getchar();
        if (ch == EOF) break;
        if (ch == '\n') line_number__++;
        if (is_word_separator(ch)) break;
        buffer[buffer_index++] = (char)ch;
    }
    buffer[buffer_index] = '\0';
    if (line_number) *line_number = line_number__;
    return buffer_index;
}

Node *node_create(void)
{
    // Creates a new node, initialize it to default values and then return it
    Node *new_node = malloc(sizeof(Node));
    if (!new_node) {
        printf("Memory error\n");
        exit(0x128);
    }
    new_node->word = NULL;
    new_node->count = 0;

    new_node->next = NULL;
    new_node->left = NULL;
    new_node->right = NULL;
    return new_node;
}

void node_insert(Node *first, Node *second)
{
    // appends second to first i.e. sets first->next to second
    first->next = second;
}

Node *tree_create(Node *root, char *word)
{
    // Adds the word to the binary tree and returns the the pointer root, or if
    // root is null, returns the pointer to the newly created node
    int cmp = 0;
    if (root == NULL) {
        root = node_create();

        root->word = malloc(sizeof(char) * (strlen(word) + 1));
        if (!root->word) {
            printf("Memory error\n");
            exit(0x256);
        }
        root->count = 1;
        strcpy(root->word, word);
        if (!node_llist) {
            node_llist = root;
            node_head = root;
            node_llist->next = NULL;
            node_llist->prev = NULL;
        }
        else {
            node_llist->next = root;
            node_llist->prev = node_llist;
            node_llist = root;
        }
    }
    else if ((cmp = strcmp(word, root->word)) > 0) {
        // Add to the right as word is greater than root
        root->right = tree_create(root->right, word);
    }
    else if (cmp < 0) {
        root->left = tree_create(root->left, word);
    }
    else {
        root->count++;
    }
    return root;
}

void tree_print(Node *root)
{
    if (root) {
        tree_print(root->left);
        if (root->count) printf("%d: %s\n", root->count, root->word);
        tree_print(root->right);
    }
}

void tree_free(Node *root)
{
    if (root) {
        tree_free(root->left);
        tree_free(root->right);
        free(root->word);
        free(root);
    }
    node_llist = NULL;
    node_head = NULL;
    // Frees the tree
}

void print_words_in_desc_order(Node *list_head)
{
    if (!list_head) return;
    Node *in_sentry = list_head;
    Node *out_sentry = list_head;
    Node *max_val = NULL;

    int tmp_count = 0;
    char *tmp_word = NULL;

    while(out_sentry)
    {
        in_sentry = out_sentry;
        max_val = in_sentry;

        while(in_sentry)
        {
            if(in_sentry->count > max_val->count)
                max_val = in_sentry;

            in_sentry = in_sentry->next;
        }
        // Swap
        printf("%d: %s\n", max_val->count, max_val->word);
        tmp_count = max_val->count;
        tmp_word = max_val->word;

        max_val->count = out_sentry->count;
        max_val->word = out_sentry->word;

        out_sentry->count = tmp_count;
        out_sentry->word = tmp_word;
        
        out_sentry = out_sentry->next;
    }
}

int main()
{
    int length;
    char buffer[MAX_WORD_LENGTH];
    int line_no = 0;
    Node *root = NULL;
    while ((length = get_word(buffer, MAX_WORD_LENGTH, &line_no)) != EOF) {
        root = tree_create(root, buffer);
    }
    // tree_print(root);
    /* while(node_head)
     * {
     *
     *     printf("%d: %s\n", node_head->count, node_head->word);
     *     node_head = node_head->next;
     * } */
    print_words_in_desc_order(node_head);
    /*
    while(node_head)
    {

        printf("%d: %s\n", node_head->count, node_head->word);
        node_head = node_head->next;
    }
    */
    tree_free(root);
}
// I am going to implement a hash table in this program

// Algorithm:
// 1. Generate a hash for the given word
// 2. In the internal array, place the string as a node at the hash position
// 3. If that index is non empty, add the new string to the end of that list
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TABLE_SIZE 5  // 100003  // Nearest prime around 100k

struct h_list {
    struct h_list *next;
    struct h_list *prev;
    char *key;
    char *value;
};

typedef struct h_list h_list;

h_list *hash_table[TABLE_SIZE] = {NULL};

h_list *h_list_create(const char *key, const char *value);
h_list *h_list_append(h_list *parent, const char *key, const char *value);
// Frees a single node
void h_list_free_single(h_list *hl);
// Frees the entire list starting from root
void h_list_free(h_list *root);

void table_store(const char *key, const char *value);
// Look up the key in the table
h_list *table_lookup(const char *key);
// Really inefficient, TODO: Create a slab/arena allocator
void table_free(void);
// Removes the entry in the table (if present). Returns 1 if removal is
// successful
int table_remove(const char *key);
unsigned int hash(const char *s);

// A safer version of malloc which causes the program to exit if memory cannot
// be allocated
void *safe_malloc(size_t n);
// Works like the strdup() function
char *duplicatestr(const char *s);

char *duplicatestr(const char *s)
{
    // +1 for the \0 character
    char *buffer = safe_malloc(sizeof(char) * (strlen(s) + 1));
    strcpy(buffer, s);
    return buffer;
}

void *safe_malloc(size_t n)
{
    void *ptr = malloc(n);
    if (!ptr) {
        printf(
            "Memory allocation failed! Check if your PC ran out of memory\n");
        exit(2);
    }
    return ptr;
}

void *safe_realloc(void *memory, size_t new_size)
{
    void *ptr = realloc(memory, new_size);
    if (!ptr) {
        printf(
            "Memory reallocation failed! Check if your PC ran out of memory\n");
        free(memory);
        exit(2);
    }
    return ptr;
}

h_list *h_list_create(const char *key, const char *value)
{
    h_list *new_node = safe_malloc(sizeof(h_list));
    new_node->key = duplicatestr(key);
    new_node->value = duplicatestr(value);
    new_node->next = NULL;
    new_node->prev = NULL;
    return new_node;
}
h_list *h_list_append(h_list *parent, const char *key, const char *value)
{
    // This is a modified version of append to list
    // This function creates a new node if the key does not appear in the list
    // otherwise it updates that node
    if (parent) {
        // Go to the last node
        while (parent->next) {
            if (strcmp(key, parent->key) == 0) {
                parent->value = safe_realloc(parent->value, strlen(value) + 1);
                strcpy(parent->value, value);
                return parent;
            }
            parent = parent->next;
        }

        // To test if the first node has the same key as the given key
        if (strcmp(key, parent->key) == 0) {
            parent->value = safe_realloc(parent->value, strlen(value) + 1);
            strcpy(parent->value, value);
            return parent;
        }
        h_list *created_node = h_list_create(key, value);
        parent->next = created_node;
        created_node->prev = parent;
        return created_node;
    }
    else {
        return h_list_create(key, value);
    }
}
void h_list_free_single(h_list *hl)
{
    if (hl) {
        free(hl->key);
        free(hl->value);
        hl->key = NULL;
        hl->value = NULL;
        free(hl);
    }
}
void h_list_free(h_list *root)
{
    h_list *tmp;
    while (root) {
        tmp = root;
        root = root->next;
        h_list_free_single(tmp);
    }
}

void table_store(const char *key, const char *value)
{
    unsigned int hash_val = hash(key);
    h_list *ins_pos = hash_table[hash_val];
    if (!ins_pos) {
        hash_table[hash_val] = h_list_create(key, value);
    }
    else {
        h_list_append(hash_table[hash_val], key, value);
    }
}
h_list *table_lookup(const char *key)
{
    if (key == NULL) return NULL;
    unsigned int hash_val = hash(key);
    h_list *node = hash_table[hash_val];
    while (node) {
        if (strcmp(key, node->key) == 0) return node;
        node = node->next;
    }
    return NULL;
}

unsigned int hash(const char *s)
{
    // The djb2 hash function
    // http://www.cse.yorku.ca/~oz/hash.html
    unsigned int hash_val = 5381;
    while (*s) {
        hash_val = hash_val * 33 + (unsigned)*s;
        s++;
    }
    return hash_val % TABLE_SIZE;
}

void table_free(void)
{
    // Really inefficient :/ Use a slab allocator
    for (int i = 0; i < TABLE_SIZE; i++) {
        if (hash_table[i]) h_list_free(hash_table[i]);
    }
}

void table_find(const char *key)
{
    h_list *node = table_lookup(key);
    if (!node)
        printf("%-12s : %s\n", key, "Key Error: Such a key does not exist");
    else
        printf("%-12s : %s\n", key, node->value);
}

int table_remove(const char *key)
{
    unsigned int calc_hash = hash(key);
    h_list *node = table_lookup(key);
    if (!node) return 0;
    // Unlink the node
    h_list *next_node = node->next;
    h_list *prev_node = node->prev;

    if (next_node == NULL && prev_node == NULL) {
        // There is a single node in the list
        hash_table[calc_hash] = NULL;
    }

    if (prev_node != NULL) {
        prev_node->next = next_node;
    }
    if (next_node != NULL) {
        if (prev_node == NULL) {
            // This is the first node of the list
            next_node->prev = NULL;
            hash_table[calc_hash] = next_node;
        }
        else {
            next_node->prev = prev_node;
        }
    }
    h_list_free_single(node);
    return 1;
}

int main()
{
    table_store("Hello", "world");
    table_store("this", "is");
    table_store("the", "quick");
    table_store("brown", "fox");
    table_store("Hello earth",
                "This string is about the great planet called earth");
    table_store("This is earth", "what is the earth");
    table_store("foo", "ffjskflskafdljas");

    table_find("Hello");
    table_find("brown");
    table_find("the");
    table_find("this");
    printf("===============\n");

    table_remove("Hello");
    table_remove("this");
    table_remove("the");
    table_remove("brown");
    table_remove("Hello earth");
    table_remove("This is earth");
    table_remove("foo");

    table_find("Hello");
    table_find("brown");
    table_find("the");
    table_find("this");

    table_remove("Hello");
    table_remove("this");
    table_remove("the");
    table_remove("brown");
    table_remove("Hello earth");
    table_remove("This is earth");
    table_remove("foo");

    table_store("Hello", "world");
    table_store("this", "is");
    table_store("the", "quick");
    table_store("brown", "fox");
    table_store("Hello earth",
                "This string is about the great planet called earth");
    table_store("This is earth", "what is the earth");
    table_store("foo", "ffjskflskafdljas");

    table_find("This does not");
    table_find("Hello earth");
    table_find("BA BA BA");
    table_find("Hello");
    table_find("brown");
    table_find("the");
    table_find("this");
    printf("===============\n");
    table_store("Abcd", "The first four letters of the alphabet");
    table_find("Abcd");

    table_store("Abcd", "Some more chars now");
    table_find("Abcd");

    table_store("Abcd", "Third attempt at repetition");
    table_find("Abcd");

    table_remove("Abcd");
    table_find("Abcd");

    table_store("Abcd", "Something totally different");
    table_find("Abcd");

    table_free();
}
/* Exercise 6-6. Implement a simple version of the #define processor (i.e., no
 * arguments) suitable for use with C programs, based on the routines of this
 * section. You may also find getch and ungetch helpful */
// Author: Shankar
// Date: 17-September-2022
// +-----------------------------------------------------------------+
// |                                                                 |
// |  Requirements                                                   |
// |  --------------                                                 |
// |                                                                 |
// |  The program should replace all occurrences of the macro NAME   |
// |  with the VALUE, while ignoring strings, characters and comments|
// |                                                                 |
// |  1. Preprocessor directives are of the form #define NAME VALUE  |
// |  2. NAME must be a character from [A-Za-z0-9_]                  |
// |  3. NAME must not start with a digit.                           |
// |  4. Both NAME and VALUE must be present on the same line.       |
// |  5. In case of any errors, the program should report it along   |
// |     with the line number on which the error occured.            |
// |  6. The program must not replace complex #defines, such as      |
// |     define with args.                                           |
// +-----------------------------------------------------------------+

// +------------------------------------------------------+
// |                                                      |
// |  Overview                                            |
// |  ------------                                        |
// |                                                      |
// |  1. Get all the words from the file/stdin            |
// |  2. A word is a group of alphanumeric characters     |
// |     including underscore or a special character      |
// |  3. For example, the below line will be interpreted  |
// |     as # define MAX_LINES 1 0 0 0 \n                 |
// |     #define MAX_LINES 1000                           |
// |  4. Check if the line is a preprocessor directiveon. |
// |  5. Add the NAME and VALUE to the hash table.        |
// |  6. For each word, replace the word if it is present |
// |     in the hash table.                               |
// +------------------------------------------------------+

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define DEFAULT_BUFFER_SIZE 16

void *safe_malloc(size_t size);
void *safe_realloc(void *mem, size_t size);
char *get_a_line(size_t *size);
void exit_handler(const char *message, int exit_code);
char *tokenize(const char *line, size_t *size);
#define TABLE_SIZE 5  // 100003  // Nearest prime around 100k

struct h_list {
    struct h_list *next;
    struct h_list *prev;
    char *key;
    char *value;
};

typedef struct h_list h_list;

h_list *hash_table[TABLE_SIZE] = {NULL};

h_list *h_list_create(const char *key, const char *value);
h_list *h_list_append(h_list *parent, const char *key, const char *value);
// Frees a single node
void h_list_free_single(h_list *hl);
// Frees the entire list starting from root
void h_list_free(h_list *root);

void table_store(const char *key, const char *value);
// Look up the key in the table
h_list *table_lookup(const char *key);
// Really inefficient, TODO: Create a slab/arena allocator
void table_free(void);
// Removes the entry in the table (if present). Returns 1 if removal is
// successful
int table_remove(const char *key);
unsigned int hash(const char *s);


char *duplicatestr(const char *s)
{
    // +1 for the \0 character
    char *buffer = safe_malloc(sizeof(char) * (strlen(s) + 1));
    strcpy(buffer, s);
    return buffer;
}

void *safe_malloc(size_t n)
{
    void *ptr = malloc(n);
    if (!ptr) {
        printf(
            "Memory allocation failed! Check if your PC ran out of memory\n");
        exit(2);
    }
    return ptr;
}

void *safe_realloc(void *memory, size_t new_size)
{
    void *ptr = realloc(memory, new_size);
    if (!ptr) {
        printf(
            "Memory reallocation failed! Check if your PC ran out of memory\n");
        free(memory);
        exit(2);
    }
    return ptr;
}

h_list *h_list_create(const char *key, const char *value)
{
    h_list *new_node = safe_malloc(sizeof(h_list));
    new_node->key = duplicatestr(key);
    new_node->value = duplicatestr(value);
    new_node->next = NULL;
    new_node->prev = NULL;
    return new_node;
}
h_list *h_list_append(h_list *parent, const char *key, const char *value)
{
    // This is a modified version of append to list
    // This function creates a new node if the key does not appear in the list
    // otherwise it updates that node
    if (parent) {
        // Go to the last node
        while (parent->next) {
            if (strcmp(key, parent->key) == 0) {
                parent->value = safe_realloc(parent->value, strlen(value) + 1);
                strcpy(parent->value, value);
                return parent;
            }
            parent = parent->next;
        }

        // To test if the first node has the same key as the given key
        if (strcmp(key, parent->key) == 0) {
            parent->value = safe_realloc(parent->value, strlen(value) + 1);
            strcpy(parent->value, value);
            return parent;
        }
        h_list *created_node = h_list_create(key, value);
        parent->next = created_node;
        created_node->prev = parent;
        return created_node;
    }
    else {
        return h_list_create(key, value);
    }
}
void h_list_free_single(h_list *hl)
{
    if (hl) {
        free(hl->key);
        free(hl->value);
        hl->key = NULL;
        hl->value = NULL;
        free(hl);
    }
}
void h_list_free(h_list *root)
{
    h_list *tmp;
    while (root) {
        tmp = root;
        root = root->next;
        h_list_free_single(tmp);
    }
}

void table_store(const char *key, const char *value)
{
    unsigned int hash_val = hash(key);
    h_list *ins_pos = hash_table[hash_val];
    if (!ins_pos) {
        hash_table[hash_val] = h_list_create(key, value);
    }
    else {
        h_list_append(hash_table[hash_val], key, value);
    }
}


void table_store_fixed(const char *key, size_t m, const char *value, size_t n)
{
    // Stores the first m characters of key and first n characters of value
    char *ky = duplicatestr(key); 
    char *val = duplicatestr(value); 

    if(m <= strlen(key))
        ky[m] = '\0';
    if(n <= strlen(value))
        val[n] = '\0';

    unsigned int hash_val = hash(ky);
    h_list *ins_pos = hash_table[hash_val];
    if (!ins_pos) {
        hash_table[hash_val] = h_list_create(ky, val);
    }
    else {
        h_list_append(hash_table[hash_val], ky, val);
    }
    free(ky);
    free(val);
}

h_list *table_lookup(const char *key)
{
    if (key == NULL) return NULL;
    unsigned int hash_val = hash(key);
    h_list *node = hash_table[hash_val];
    while (node) {
        if (strcmp(key, node->key) == 0) return node;
        node = node->next;
    }
    return NULL;
}

unsigned int hash(const char *s)
{
    // The djb2 hash function
    // http://www.cse.yorku.ca/~oz/hash.html
    unsigned int hash_val = 5381;
    while (*s) {
        hash_val = hash_val * 33 + (unsigned)*s;
        s++;
    }
    return hash_val % TABLE_SIZE;
}

void table_free(void)
{
    // Really inefficient :/ Use a slab allocator
    for (int i = 0; i < TABLE_SIZE; i++) {
        if (hash_table[i]) h_list_free(hash_table[i]);
    }
}

void table_find(const char *key)
{
    h_list *node = table_lookup(key);
    if (!node)
        printf("%-12s : %s\n", key, "Key Error: Such a key does not exist");
    else
        printf("%-12s : %s\n", key, node->value);
}

int table_remove(const char *key)
{
    unsigned int calc_hash = hash(key);
    h_list *node = table_lookup(key);
    if (!node) return 0;
    // Unlink the node
    h_list *next_node = node->next;
    h_list *prev_node = node->prev;

    if (next_node == NULL && prev_node == NULL) {
        // There is a single node in the list
        hash_table[calc_hash] = NULL;
    }

    if (prev_node != NULL) {
        prev_node->next = next_node;
    }
    if (next_node != NULL) {
        if (prev_node == NULL) {
            // This is the first node of the list
            next_node->prev = NULL;
            hash_table[calc_hash] = next_node;
        }
        else {
            next_node->prev = prev_node;
        }
    }
    h_list_free_single(node);
    return 1;
}
 void exit_handler(const char *message, int exit_code)
{
    printf("%s", message);
    exit(exit_code);
}


char *get_a_line(size_t *size)
{
    // Get a single line from standard input into a growable buffer
    char *buffer = safe_malloc(DEFAULT_BUFFER_SIZE);
    size_t allocated_buffer_size = DEFAULT_BUFFER_SIZE;
    size_t buffer_size = 0;
    int ch;
    // Check that size is non zero as unsgined 0-1 wraps around
    if (size == 0) return NULL;

    while (buffer_size < (allocated_buffer_size - 1)) {
        // -1 to hold the \0 character
        ch = getchar();
        if (ch == EOF) {
            break;
        }
        buffer[buffer_size++] = (char)ch;
        if (ch == '\n') break;

        // Double allocated_buffer_size if the next character to be read will
        // overflow it
        if (buffer_size == (allocated_buffer_size - 1)) {
            allocated_buffer_size *= 2;
            buffer = safe_realloc(buffer, allocated_buffer_size);
        }
    }
    buffer[buffer_size] = '\0';
    if (size) *size = buffer_size;
    return buffer;
}

char *tokenize(const char *line, size_t *size)
{
    // Returns a pointer to the first token of the word and sets size to the
    // size of the token
    static char *internal_line = NULL;

    static char *lastchar = NULL;
    static int unget_required = 0;

    if (line != NULL) {
        internal_line = line;
    }
    if (unget_required) {
        unget_required = 0;
        if(size) *size = 1;
        return lastchar;
    }
    char *beg = internal_line;
    while (*internal_line) {
        if (!isalnum(*internal_line) && *internal_line != '_') {
            if (size) *size = internal_line - beg;

            unget_required = 1;
            lastchar = internal_line;

            internal_line++;
            return beg;
        }
        internal_line++;
    }
    return NULL;
}

void print_tok(char *tok, size_t tok_size)
{
    printf("%.*s", (int)tok_size, tok);
    // for(int i = 0; i < tok_size; i++) putchar(*(tok+i));
}

void process_token(char *token, size_t token_size)
{
    /*
    if (token_size <= 0) return;

    if (*token == '\n')
        printf("[1: \\n]\n");
    else if (*token == '\r')
        printf("[1: \\r]\n");
    else if (*token == '\t')
        printf("[1: \\t]\n");
    else if (*token == ' ')
        printf("[1: SPACE]\n");
    else {
        printf("[%d: ", token_size);
        print_tok(token, token_size);
        printf("]\n");
    }
    */

    // Find the pattern #define NAME VALUE\n
    // There can be any amount of space between define and NAME, NAME and VALUE
    // and VALUE and the newline
    // There should not be any spaces between # and define
    char *token2 = NULL;
    size_t token2_size = 0;

    char *tok = duplicatestr(token);
    if(token_size <= strlen(token))
        tok[token_size] = '\0';
    //printf("<%s>\n", tok);
    h_list *lookup = table_lookup(tok);
    free(tok);

    if(lookup)
    {
        //printf("FOUND\n");
        printf("%s",lookup->value);
        return;
    }

    if(token_size == 1)
    {
        if(*token == '#')
        {
            token = tokenize(NULL, &token_size);
            // if(token_size == 6)
            if(strncmp(token, "define", 6) == 0)
            {
                // Skip whitespace
                tokenize(NULL, NULL);

                // Read name
                token = tokenize(NULL, &token_size);
                //print_tok(token, token_size);

                // Skip whitespace
                tokenize(NULL, NULL);

                // Read value
                token2 = tokenize(NULL, &token2_size);
                //printf(" VALUE:");
                // print_tok(token, token_size);
                table_store_fixed(token, token_size, token2, token2_size);

                printf("#define");
                printf(" ");
                print_tok(token, token_size);
                printf(" ");
                print_tok(token2, token2_size);
            }
            else
            {
                putchar('#');
                print_tok(token, token_size);
            }
        }
        else
        {
            putchar(*token);
        }
    }
    else
    {
        print_tok(token, token_size);
    }
}
int main()
{
    size_t size = 0;
    char *buffer = NULL;
    char *tok;
    size_t tok_size = 0;
    int line_index = 0;
    while (1) {
        buffer = get_a_line(&size);
        line_index++;

        if (size != 0) {
            tok = tokenize(buffer, &tok_size);
            // printf("(%d)", line_index);
            process_token(tok, tok_size);
            while ((tok = tokenize(NULL, &tok_size))) {
                // printf("(%d)", line_index);
                process_token(tok, tok_size);
            }
            /*
            print_tok(tok, tok_size);
            while((tok = tokenize(NULL, &tok_size)))
            {
                print_tok(tok, tok_size);
            }
            */
            free(buffer);
        }
        else {
            free(buffer);
            break;
        }
    }
    table_free();
}
// What I learnt?
// 1. There can be weird bugs such as in the process token function, wherein a
// space or newline character was printed twice
// 2. The fix is to use if-else if-else ladder instead of plain ifs

// TODO:
// This program is not fully complete and there are a few more features which are necessary.
// 1. Does not handle quoted strings/chars in define.
// 2. Does not ignore #define and replacement in comments/strings
// 3. This code can be organized in a much better way
// 4. Display syntax error when the define is not correct as in the middle of lines, not having a single identifier after define, etc
// 5. Fix the bug when define replaces spaces, such as when passing this program source file using <, all spaces are replaced by "such"
//    due to the line #defines, such as
//    Rectify this error#include<stdio.h>
#include<ctype.h>
#include<string.h>
int main(int argc, char *argv[])
{
    int ch;
    if(strcmp(argv[0], "exercise-7-1.exe") == 0)
    {
        while((ch=getchar())!=EOF)putchar(tolower(ch));
    }
    else
    {
        while((ch=getchar())!=EOF)putchar(toupper(ch));
    }
}
/*
Exercise 7-2. Write a program that will print arbitrary input in a sensible way.
As a minimum, it should print non-graphic characters in octal or hexadecimal
according to local custom, and break long text lines.
*/

// 1. If the character is not printable (using isgraph() function), print its
// hexadecimal value.
// 2. If the non printable character is ' ' or '\n', print it, for all other
// character such as tab, print its escaped form
// 3. If the line is too long, defined as 80 and can be set through command line
// arguments, break it as in the fold program from exercise 1.

#include <ctype.h>
#include <stdio.h>
#define HEX_SIZE 4
#define MAX_LINE_SIZE 80

void print_escape_char(int ch) { 
    printf("\\%c ", ch); 
}

int main()
{
    int ch;
    // To open stdin in binary mode
    freopen(NULL, "rb", stdin);
    int line_ptr = 0;

    while ((ch = getchar()) != EOF) {
        if(line_ptr >= MAX_LINE_SIZE)
        {
            printf("\n");
            line_ptr = 0;
        }
        if (isprint(ch))
        {
            printf("%c", ch);
            line_ptr++;
        }
        else if (ch == '\n') {
            // print_escape_char('n');
            printf("\n");
            line_ptr = 0;
        }
        else if (ch == '\r') {
            print_escape_char('r');
            line_ptr++;
        }
        else if (ch == '\t') {
            print_escape_char('t');
            line_ptr++;
        }
        else if (ch == '\a') {
            print_escape_char('a');
            line_ptr++;
        }
        else if (ch == '\b') {
            print_escape_char('b');
            line_ptr++;
        }
        else if (ch == '\f') {
            print_escape_char('f');
            line_ptr++;
        }
        else if (ch == '\v') {
            print_escape_char('v');
            line_ptr++;
        }
        else {
            // Print the hex version of the character
            printf("%0*x ", HEX_SIZE, ch);
            line_ptr += HEX_SIZE;
        }
    }
}#include <stdarg.h>
#include<stdio.h>

void my_printf(const char *fmt, ...)
{
    va_list ap;
    double fval;
    int ival;
    unsigned int uval;
    char *s;
    va_start(ap, fmt);
    const char *fmt_ptr = fmt;
    for (fmt_ptr = fmt; *fmt_ptr != '\0'; fmt_ptr++) {
        if (*fmt_ptr != '%') {
            putchar(*fmt_ptr);
        }
        else {
            switch(*++fmt_ptr)
            {
                case 'd':
                case 'i':
                    ival = va_arg(ap, int);
                    printf("%d", ival);
                    break;
                case 'u':
                    uval = va_arg(ap, unsigned int);
                    printf("%u", uval);
                    break;
                case 'f':
                    fval = va_arg(ap, double);
                    printf("%f", fval);
                    break;
                case 's':
                    s = va_arg(ap, char *);
                    if(s == NULL) break;
                    while(*s)
                    {
                        putchar(*s++);
                    }
                    break;
                default:
                    putchar(*fmt_ptr);
                    break;
            }
        }
    }
    va_end(ap);
}

int main()
{
    my_printf(":%s:\n", "This is a string!");
    my_printf("%s%d\n", "This is a number!:", 71);
}#include <ctype.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
Grammar - EBNF
========
format specifier = "%", [{digit} | "*"], character;
digit = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9";
character = "s" | "f" | "d" | "c";
*/

int consume_character(char ch, int *err_occured)
{
    // ch - character to be compared with.
    // err_occured - pointer to int which serves as a flag to check if error
    // occured. Function returns the character if the same character is read
    // from the input, else 0 and err_occured flag is set accordingly.
    int inp_ch = getchar();
    if (inp_ch == ch) {
        if (err_occured) *err_occured = 0;
        return inp_ch;
    }
    else {
        ungetc(inp_ch, stdin);
        if (err_occured) *err_occured = 1;
        return 0;
    }
}
int consume_number(int *err_occured)
{
    // err_occured - pointer to int which serves as a flag to check if error
    // occured.
    int ch = 0;
    int converted = 0;
    // Skip whitespaces when reading a number
    while (isspace(ch = getchar()))
        ;
    // A non-whitespace char was read, push it back so that it can be read in
    // next call to getchar
    ungetc(ch, stdin);

    while (isdigit(ch = getchar())) {
        converted = converted * 10 + (ch - '0');
    }
    // Push back the non numeric character
    ungetc(ch, stdin);
    if (err_occured) *err_occured = 0;
    return converted;
}

int my_scanf(const char *fmt, ...)
{
    va_list args;
    int ch;
    int to_save = 0;
    int elements_read = 0;
    int errflag;
    char *c_ptr;

    union val {
        int i_val;
        float f_val;
        char c_val;
    } value;
    va_start(args, fmt);

    if (fmt == NULL) {
        va_end(args);
        return 0;
    }
    while (*fmt) {
        if (*fmt == '%') {
            // Found the start of a format specifier
            // Field width is currently not supported
            to_save = 1;
            ch = *(++fmt);

            if (ch == '*') {
                to_save = 0;
                ch = *(++fmt);
            }
            switch (ch) {
                case 's':
                    c_ptr = va_arg(args, char *);

                    break;

                case 'f':
                    break;

                case 'd':
                    value.i_val = consume_number(&errflag);
                    int *d_ptr = va_arg(args, int *);
                    elements_read++;
                    if (d_ptr && to_save) *d_ptr = value.i_val;
                    break;

                case 'c':
                    ch = getchar();
                    if (ch != EOF) {
                        c_ptr = va_arg(args, char *);
                        if (c_ptr && to_save) c_ptr[0] = ch;
                        elements_read++;
                    }
                    else {
                        va_end(args);
                        return elements_read;
                    }
                    break;

                default:
                    printf("Unknown format letter to scanf, %c\n", ch);
                    exit(1);
                    break;
            }
            fmt++;
        }
        else {
            // A literal character
            ch = getchar();
            if (ch != *fmt) {
                // We have read some other character
                ungetc(ch, stdin);
                va_end(args);
                return elements_read;
            }
            fmt++;
        }
    }

    va_end(args);
    return elements_read;
}

int main()
{
    int a;
    char ch;
    int b;
    printf("%d\n", my_scanf("%d-%c-%d", &a, &ch, &b));
    printf("%d %c %d\n", a, ch, b);
}#include<stdio.h>

int sum(int a, int b){return a+b;}
int mul(int a, int b){return a*b;}
int div(int a, int b){return a/b;}
int sub(int a, int b){return a-b;}
int unk(int a, int b){printf("Unknown symbol %d %d \n", a, b); return 0;}

typedef int (*fptr)(int, int);

fptr givefunc(char ch)
{
    switch(ch)
    {
        case '+':
            return sum;
        case '-':
            return sub;
        case '/':
            return div;
        case '*':
            return mul;
        default:
            return unk;
    }
}

int main()
{
    int res = givefunc('+')(5, 2);
    fptr f = givefunc('-');
    printf("%d\n", res);
    printf("%d\n", f(4, 8));
}
#include "utest.h"

UTEST(FunCheck, CheckFunc2) { ASSERT_TRUE(1); }

UTEST(FunCheck, CheckFunc)
{
    int a = 5;
    int b = 5;
    ASSERT_TRUE(a != b);
}

UTEST_MAIN();
#include <stdio.h>
int main()
{
    printf("%s\n", "Hello world!");
    return 0;
}
#include<stdio.h>
#define dprint(expr) printf(#expr " = %g\n", expr)
#define noteof(character) while(character != EOF)
int main()
{
    double a, b, c;
    a = 3;
    b = 2;
    c = 7;
    int ch;
    dprint(a + b * c );
    // Can be used to print code
    dprint(printf("Hello\n"));

    // Macros can be used to create your own constructs, or keywords :)
    noteof((ch = getchar()))
    {
        putchar(ch);
    }

}
/*
 * My implementation of a custom command line argument parser
 */
// NOTE:
// 1. Only single letter options are supported
// 2. If the option has an argument, it should be after the option with an =, no
// spaces are allowed
// 3. = is only supported with multi char options
//
// Pseudocode
// For each command line argument
//      If the argument starts with a "-"
//          Get the next character, if it is also a "-"
//              It is a multicharacter option
//                  If there is an equals(=) sign
//                      Return type="optval", ptr to third char of argument,
//                      (after the --), ptr to the next character after "="
//                      (valptr)
//                  Else
//                      Return type="opt", ptr to third char of arg(after --),
//                      valptr=NULL
//          Else
//              It is a group of single character options
//              return type="sopt", list of separate chars, valptr=NULL
//
//      Else
//          It is an argument
//              Return type="arg", ptr to the argument, valptr=NULL


#include <math.h>
#include <stdio.h>
typedef unsigned long long int ul_int;
int isPrime(ul_int n)
{
    if (n == 2 || n == 3)
        return 1;
    int rem = n % 6;
    // All prime numbers except 2 or 3 are of the form 6k +- 1
    if (rem != 1) {
        if (rem != 5)
            return 0;
    }
    if (rem != 5) {
        if (rem != 1)
            return 0;
    }
    for (ul_int i = 2; i <= sqrt(n); i++) { if (n % i == 0)
            return 0;
    }
    return 1;
}

ul_int gcd(ul_int a, ul_int b)
{
    ul_int t;
    while (b != 0) {
        t = b;
        b = a % b;
        a = t;
    }
    return a;
}
ul_int largestDivUptoN(ul_int n)
{
    ul_int num = 1;
    for (ul_int i = 2; i <= n; i++) {
        if (isPrime(i)) {
            num *= i;
        } else {
            num *= i / gcd(num, i);
        }
    }
    return num;
}
int main()
{
    printf("%llu\n", largestDivUptoN(20));
}
#include<stdio.h>
int main()
{
    int arr[] = {1, 2, 3, 14, 15};
    int *ptr = arr;
    int *ptr2 = &arr[0];

    printf("%d\n", ptr[2]);
    printf("%d\n", ptr2[2]);

    // Gets a pointer to the 3rd element (3)
    int *ptr3 = &arr[2];

    ++*ptr3;
    // Increments the value pointed by ptr3 or the 3rd element
    printf("++*ptr3 = %d\n", arr[2]);

    // Increments ptr to the next object, then get its old value
    printf("*ptr3++ = %d\n", *ptr3++);
    printf("*ptr3 = %d\n", *ptr3);

    // undefined behaviour :)
    int *ptr4 = &arr[4];
    printf("*ptr4++ = %d\n", *ptr4++);
    printf("*ptr4 = %d\n", *ptr4);

    printf("*(ptr4+1000) = %d\n", *(ptr4-1000));
}
typedef const char* string;
#include <stdio.h>
void printString(string s)
{
    while (*s) {
        putchar(*s);
        s++;
    }
    // For readability
    putchar('\n');
}

int main()
{
    printString("Hello world");
    printString("This is another string");

    string str = "The quick brown fox jumps over the lazy dogs";
    // Prints the whole string
    printString(str);
    // Should print starting from h
    printString(str + 1);
    printString(&str[1]);
    // Should print starting from fox
    printString(str + 16);
    printString(&str[16]);

    // Compiler is not warning :(
    // It warns when using const
    // str[2] = 'a';

    // Are array of pointers and pointer to int same?
    int var = 100;
    int *ptr;
    ptr = &var;

    int array [] = {1, 2, 3, 4, 5};
    int *arr = array;

    printf("%d\n", arr[2]);
    printf("%d\n", *(arr+2));
    printf("%d\n", array[2]);

    printf("%d\n", ptr[0]);
    printf("%d\n", *ptr);
    // UB here
    //printf("%d\n", ptr[1]);


    // Negative indexing
    int *arr3 = (arr+2);
    printf("%d\n", *arr3);
    printf("%d\n", arr3[-1]);
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SWAP(x, y, t) \
    {                 \
        t tmp = x;    \
        x = y;        \
        y = tmp;      \
    }

#define PRINT_SPACES(n)                                                       \
    for (int z = 0; z < n; z++) putchar((z % INDENT_WIDTH == 0) ? '|' : ' '); \
    putchar('|');                                                             \
    putchar('-')

#define INDENT_WIDTH 3
#define SIZE 10*1000*1000 // 10 MB of storage
int VISUAL = 0;
int OUTPUT = 0;

void displayArray(int *arr, size_t n);

size_t ssort(int *arr, size_t n)
{
    // Performs selection sort on the input array
    // Returns an integer representing the number of times the loop has run
    size_t smallest;
    size_t run = 0;
    for (size_t i = 0; i < n; i++) {
        if (VISUAL) {
            printf("Pass %zu: ", i);
            displayArray(arr, n);
        }

        smallest = i;
        // Find the smallest element in the array
        for (size_t j = i + 1; j < n; j++) {
            ++run;
            if (arr[j] < arr[smallest]) smallest = j;
        }
        // Swap the element at ith position with the smallest element
        int tmp = arr[i];
        arr[i] = arr[smallest];
        arr[smallest] = tmp;
        if (VISUAL) {
            printf("        ");
            displayArray(arr, n);
            printf("====================\n");
        }
    }
    return run;
}

void bubble_sort(int *arr, size_t n)
{
    // Repeat the loop n times
    for (size_t i = 0; i < n; i++) {
        // Repeat the inner swapping loop upto the penultimate element.
        // NOTE: This can be optimized by noting the fact that after every pass,
        // an element at the end gets sorted.
        for (size_t j = 0; j < (n - 1); j++) {
            if (arr[j + 1] < arr[j]) {
                // Swap the numbers
                SWAP(arr[j + 1], arr[j], int)
            }
        }
    }
}

size_t merge(int *aux, int *arr1, size_t n1, int *arr2, size_t n2)
{
    // Merges elements from two arrays into an auxillary array
    // in a sorted manner
    // Find the pointer to last element of both arrays
    // Returns the number of times the loop has run
    size_t run = 0;

    int *arr1_end = arr1 + n1 - 1;
    int *arr2_end = arr2 + n2 - 1;
    while ((arr1 <= arr1_end) && (arr2 <= arr2_end)) {
        ++run;
        // Put the lower of the two element in the aux array first
        if (*arr1 < *arr2) {
            // Only increase the pointer in the first array
            *aux++ = *arr1++;
        }
        else {
            *aux++ = *arr2++;
        }
    }
    while (arr1 <= arr1_end) {
        ++run;
        // Copy remaining elements
        *aux++ = *arr1++;
    }
    while (arr2 <= arr2_end) {
        ++run;
        // Copy remaining elements
        *aux++ = *arr2++;
    }
    return run;
}
size_t merge_sort(int *arr, size_t n, int *aux, int depth)
{
    // depth parameter for printing appropriate number of spaces
    size_t run = 0;
    if (n < 1) {
        printf("%s\n", "SERIOUS ERROR, n < 1");
        exit(-1);
    }
    // Only one element, it is already sorted
    if (n == 1) return 1;

    size_t l_i = n / 2;
    size_t r_i = n - (n / 2);
    if (VISUAL) {
        PRINT_SPACES(depth * INDENT_WIDTH);
        displayArray(arr, n);
    }

    // merge sort the left half
    run += merge_sort(arr, l_i, aux, depth + 1);
    // merge sort the right half
    run += merge_sort(arr + l_i, r_i, aux, depth + 1);

    // merge the two halves together
    run += merge(aux, arr, l_i, arr + l_i, r_i);
    for (size_t i = 0; i < n; i++) *(arr + i) = *(aux + i);
    // displayArray(aux, n);
    if (VISUAL) {
        PRINT_SPACES(depth * INDENT_WIDTH);
        putchar('-');
        putchar(' ');
        displayArray(arr, n);
    }
    return run;
}
void displayArray(int *arr, size_t n)
{
    // Prints an array
    // Gets the pointer to the last element of the array.
    int *end = arr + n - 1;
    while (arr <= end) {
        printf("%d ", *arr++);
    }
    printf("\n");
}

void get_integers(int *buff, size_t n)
{
    // Get n integers from stdin
    // No input checking done here
    for (size_t i = 0; i < n; i++) {
        // printf("Enter the %zu number: ", i);
        scanf("%d", buff++);
    }
}

int main(int argc, char *argv[])
{
    // Array of SIZE numbers
    // int arr[SIZE] = {1, 11, 7, 8, 2, 0, 3, 16, 4, 9, 3, 5, 12};
    // displayArray(arr, SIZE);
    char *str;
    while (--argc > 0) {
        str = *++argv;
        if(strcmp(str, "-v") == 0)
            VISUAL = 1;
        if(strcmp(str, "-o") == 0)
            OUTPUT = 1;
    }

    // int arr[SIZE] = {0};
    // int arr2[SIZE] = {0};
    // int aux[SIZE] = {0};

    int *arr = (int*)malloc(SIZE*sizeof(int)); 
    int *arr2 = (int*)malloc(SIZE*sizeof(int)); 
    int *aux = (int*)malloc(SIZE*sizeof(int)); 

    size_t n = 0;
    printf("How many numbers? : ");
    scanf("%zu", &n);
    printf("\n");
    get_integers(arr, n);

    memcpy(arr2, arr, n * sizeof(int));

    printf("\n");
    printf("========== MERGE SORT ==========\n");
    printf("%zu\n", merge_sort(arr, n, aux, 0));
    if(OUTPUT)
        displayArray(arr, n);
    printf("========== SELECTION SORT ==========\n");
    printf("%zu\n", ssort(arr, n));
    if(OUTPUT)
        displayArray(arr, n);
}
// TEST
// $ gen_sort_num.py 1000 100000 | sorting_algorithms.exe
// How many numbers? :
// ========== MERGE SORT ==========
// 1768928
// ========== SELECTION SORT ==========
// 4999950000
//
// On calculating n*log to base 2 n, for merge sort the value comes out to
//      1 660 964
// The actual run(excluding thecopying time)
//      1 768 928    
//
// On calculating n^2, for selection sort the value is
//      10^5, or 10 billion
// The actual run value is 
//      4 999 950 000 
//      Which is close to 5 billion
// Finding n*(n-1)/2, which is the predicted running steps of this algorithm
//      4 999 950 000
// 
// The base of log as calculated by me for various inputs on my machine comes out to 1.9334
// A simple array based storage allocator in C (similar to malloc and free)

#define MAX_BUFFER_SIZE 8 * 1000 * 1000  // 8 million bytes or 8MB
#include <stdio.h>
#include <string.h>
// Define a fixed length char array to perform the allocations.
static char buffer[MAX_BUFFER_SIZE] = {'\0'};
// Pointer to the next free location in the buffer.
static char *buffer_p = buffer;

char *alloc_buffer(size_t size)
{
    // Check if there is enough space in the buffer to perform the allocation.
    if ((unsigned)(buffer + MAX_BUFFER_SIZE - buffer_p) >= size) {
        buffer_p = buffer_p + size;
        return buffer_p - size;
    }
    printf("%s\n", "Allocation failed, not enough memory!");
    return NULL;
}

int free_buffer(char *ptr)
{
    // Check if the given pointer is within the buffer
    if ((ptr >= buffer) && ptr < (buffer_p + MAX_BUFFER_SIZE)) {
        buffer_p = ptr;
        return 1;
    }
    printf("%s\n", "Couldn't free memory as pointer is not within the buffer");
    return 0;
}
int main()
{
    char *buff = alloc_buffer(1024);
    strcpy(buff, "hello");
    printf("%s\n", buff);

    char *buff2 = alloc_buffer(1024);
    strcpy(buff2, "world");
    printf("%s\n", buff2);

    free_buffer(buff2);

    // Array of 10 integers
    // storage-allocator.c|47 col 16| warning: cast from 'char *' to 'int *'
    // increases required alignment from 1 to 4 [-Wcast-align]
    char *arr_inter = alloc_buffer(sizeof(int) * 10);
    int *arr = (int *)arr_inter;

    arr[0] = 3;
    arr[1] = 4;
    arr[2] = 32768;
    arr[3] = 2048;
    arr[4] = 97432;
    arr[5] = 1000;

    // For the fun part :)
    for (int i = 0; i < 6; i++) {
        printf("==%d\n", arr[i]);
    }
    // The individual bytes
    for (size_t i = 0; i < 6*sizeof(int); i++)
    {
        if(i % 4 == 0)
            printf("*****\n");
        printf("%x", (unsigned char)arr_inter[i]);
        printf(" [%c]\n", arr_inter[i]);
    }

    printf("%s\n", arr_inter);
    // Frees everything
    free_buffer(buff);
}
