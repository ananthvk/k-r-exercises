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
#include <assert.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef enum TokenType {
    NUMBER,
    IDENTIFIER,
    // Operators
    PLUS,
    MINUS,
    FORWARD_SLASH,
    STAR,
    MODULUS,

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
double op_stack[MAX_OPERANDS] = {0}; /* Stack to store the operands */
int sp = -1;                         /* Stack index */
int cp = 0; /* Character index which is the index of the current character to be
               considered*/
char src_string[BUFFER_SIZE] = {'\0'};
char buffer[512] = {'\0'};
/* Temporary buffer to store numbers, to convert them */
int TOKEN_DEBUG_ENABLED = 1; /* Whether to print token details or not */
int err_occured = 0;
// ===================================
// Functions for safely handling the source string
// by including length checks
// These functions consider a null char at the end of src_string, i.e. at index
// BUFFER_SIZE -1 So they check if the index is less than BUFFER_SIZE - 1
double valueAt(int n);
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

void clearScreen()
{
    // I couldn't find a proper way of clearing the console
    // (especially for displaying the stack)
    // So this method is slightly portable and works in *nix and windows
    system("cls||clear");
}

void displayStack()
{
    for (int k = 0; k <= sp; k++) {
        printf("[%d: ", k);
        printf("%.3f ", valueAt(k));
        printf("%s", " ]\n");
    }
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

int push(double var)
{
    /*
     * Function which pushes an element to the stack
     * If the stack is full, 0 will be returned and 1 in case of success
     */
    if (sp == (MAX_OPERANDS - 1)) {
        if(TOKEN_DEBUG_ENABLED)
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

void binop(char op)
{
    double result = 0, lhs, rhs;
    int rhs_success = 0;

    if (!pop(&rhs)) {
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
        if(rhs_success)
            push(rhs);
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
        case '/':
            if (fabs(rhs) <= 1e-16) {
                printf("%s\n", "ERROR: Division by zero");
                err_occured = 1;
                return;
            }
            else {
                result = lhs / rhs;
            }
            break;
        case '%':
            if (fabs(rhs) <= 1e-16) {
                printf("%s\n", "ERROR: Modulus by zero");
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
            printf("ERROR: Unknown operator (%c) \n", op);
            err_occured = 1;
            break;
    }
    if (!push(result)) {
        printf("ERROR: %s\n", "Stack is full, Internal error");
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
    do {
        t = getNextToken();
        if (t.type == UNKNOWN) {
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
                        printf("ERROR: %s\n", "Stack is full, Internal error");
                        err_occured = 1;
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

int getline(char buffer_[], int bufferSize)
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
    clearScreen();
    printf("%s", ">>");
    while ((length = getline(src_string, 512))) {
        clearScreen();
        calculate();
        displayStack();
        // reset();
        cp = 0;
        err_occured = 0;
        printf("%s", ">>");
    }
}
