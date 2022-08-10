/*
 * Implementation of a Reverse Polish Notation Calculator.
 * This file has all the exercises from exercise 4-3 to exercise 4-10
 * The book separates the functions into many files, but because I have kept a single file per exercise,
 * I'm doing everything here.
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
 * 1) I have made the a function, which returns the result instead of directly finding the result from stdin.
 * 2) This allows me to test the code.
 * 3) No getch and ungetch as the program takes a char array as argument.
 */
#include<stdio.h>
#include<string.h>
typedef enum TokenType {
    NUMBER,
    // Operators
    PLUS,
    MINUS,
    FORWARD_SLASH,
    STAR,

    END_OF_FILE,
    NEWLINE,
    UNKNOWN
} TokenType;

typedef struct Token{
    TokenType type; // Type of the token
    char *src; // Pointer to the string which contains the token
    int index; // Position of token
    int length; // Length of the token.
} Token;


// GLOBAL Variables here
// ===================================
#define MAX_OPERANDS 1024
#define BUFFER_SIZE 512
double op_stack[MAX_OPERANDS] = {0}; /* Stack to store the operands */
int sp = -1; /* Stack index */
int cp = 0; /* Character index which is the index of the current character to be considered*/
char src_string[BUFFER_SIZE] = {'\0'};
int TOKEN_DEBUG_ENABLED = 1; /* Whether to print token details or not */
// ===================================
int pop(double *var)
{
    /*
     * Function which pops an element from the stack and sets the passed element to that value.
     * If the stack is empty, 0 will be returned 
     */
    if(sp < 0)
    {
        if(var) *var = 0;
        return 0;
    }
    else
    {
        if(var) *var = op_stack[sp--];
        return 1;
    }
}

int push(double var)
{
    /*
     * Function which pushes an element to the stack
     * If the stack is full, 0 will be returned and 1 in case of success
     */
    if(sp == (MAX_OPERANDS - 1))
    {
        return 0;
    }
    else
    {
        op_stack[++sp] = var;
        return 1;
    }
}

Token getNextToken()
{
    if(cp == -1)
        return (Token){END_OF_FILE, src_string, cp, 0};

    while(src_string[cp] != '\0')
    {
        // Single character tokens
        if(src_string[cp] == '*')
            return (Token){STAR, src_string, cp++, 1};
        if(src_string[cp] == '/')
            return (Token){FORWARD_SLASH, src_string, cp++, 1};
        if(src_string[cp] == '+')
            return (Token){PLUS, src_string, cp++, 1};
        if(src_string[cp] == '-')
            return (Token){MINUS, src_string, cp++, 1};
        if(src_string[cp] == '\n')
            return (Token){NEWLINE, src_string, cp++, 1};

        else
            return (Token){UNKNOWN, src_string, cp++, 1};

        // Multi character tokens like numbers
    }
    cp = -1;
    return (Token){END_OF_FILE, src_string, cp, 0};
}

void reset()
{
    // Resets all variables to initial state
    sp = -1;
    cp = 0;
    memset(src_string, 0, sizeof(src_string));
}

void displayToken(Token t)
{
    putchar('<');
    switch(t.type)
    {
        // I know, this is ugly
        case NUMBER:
            printf("%s", "NUMBER");
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
        case END_OF_FILE:
            printf("%s>\n", "EOF");
            // Returns for EOF as it is not printable
            return;
            break;
        case NEWLINE:
            printf("%s>\n", "EOL");
            // Returns for EOF as it is not printable
            return;
            break;
        case UNKNOWN:
            printf("%s", "UKNWN");
            break;
        default:
            printf("%s", "*UKNWN");
            break;
    }
    // Add a space
    putchar(' ');

    // Code for handling single character tokens only.
    printf("%c", t.src[t.index]);

    putchar('>');
    putchar('\n');
}

void calculate()
{
    Token t;
    do
    {
        t = getNextToken();
        if(TOKEN_DEBUG_ENABLED)
            displayToken(t);
    }while(t.type != END_OF_FILE);
}

int getline(char buffer[], int bufferSize)
{
    int bufferIndex = 0, ch;
    while(bufferIndex < (bufferSize-1))
    {
        ch = getchar();
        if(ch == EOF) break;
        buffer[bufferIndex++] = ch;
        if(ch == '\n') break;
    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}

int main()
{
    int length;
    printf("%s",">>");
    while((length = getline(src_string, 512)))
    {
        // :-), such a silly error, The code did not work when I used getline and worked 
        // when using hardcoded strings.
        // The  mistake was that I called reset() before calculate(), so the 
        // entire buffer was wiped to 0s.
        calculate();
        reset();
        printf("\n%s",">>");
    }
}
