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
void exit_handler(const char *message, int exit_code)
{
    printf("%s", message);
    exit(exit_code);
}

void *safe_malloc(size_t size)
{
    // Safe malloc function, exits the program incase of failure instead of
    // returning NULL
    void *ptr = malloc(size);
    if (!ptr) {
        exit_handler(
            "Error: Memory allocation failed. Ensure that your computer has "
            "enough memory\n",
            1);
    }
    return ptr;
}
void *safe_realloc(void *mem, size_t size)
{
    // Safe realloc function, exits the program incase of failure instead of
    // returning NULL
    void *ptr = realloc(mem, size);
    if (!ptr) {
        free(mem);
        exit_handler(
            "Error: Memory reallocation failed. Ensure that your computer has "
            "enough memory\n",
            1);
    }
    return ptr;
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
        buffer[buffer_size++] = ch;
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
        *size = 1;
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
    printf("%.*s", tok_size, tok);
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

    if(token_size == 1)
    {
        if(*token == '#')
        {
            token = tokenize(NULL, &token_size);
            // if(token_size == 6)
            if(strncmp(token, "define", 6) == 0)
            {
                // Skip whitespace
                tokenize(NULL, &token_size);

                // Read name
                token = tokenize(NULL, &token_size);
                printf("NAME:");
                print_tok(token, token_size);

                // Skip whitespace
                tokenize(NULL, &token_size);

                // Read value
                token = tokenize(NULL, &token_size);
                printf(" VALUE:");
                print_tok(token, token_size);
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
}
// What I learnt?
// 1. There can be weird bugs such as in the process token function, wherein a
// space or newline character was printed twice
// 2. The fix is to use if-else if-else ladder instead of plain ifs
