// Write a function reverse(s) that reverses the character string s. Use it to
// write a program that reverses its input a line at a time.
// This version of the program has a fixed max line length constraint, as I have 
// used no dynamic memory allocation, it is not possible to reverse and print
// if the line is split into multiple buffers.
#include<stdio.h>
int getline(char buffer[], int bufferSize);

int main(){

}


int getline(char buffer[], int bufferSize){
    int ch, bufferIndex = 0;
    // Characters are stored in the buffer, leaving 
    // one space vacant for the null character.
    while(bufferIndex < (bufferSize-1)){
        ch = getchar();
        if(ch == EOF)
            break;

        buffer[bufferIndex] = ch;
        // bufferIndex is the index for the next character to be read.
        bufferIndex++;

        if(ch == '\n'){
            break;
        }

    }
    buffer[bufferIndex] = '\0';
    return bufferIndex;
}
