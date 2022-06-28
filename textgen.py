import random
import sys

escape_chars = [' ', '\n', '\t', '\\']

symbols = [i for i in range(33, 48)] + [i for i in range(58, 65)] + [i for i in range(91, 97)] + [i for i in range(123, 127)]
symbols = [chr(i) for i in symbols]

upperalpha = [chr(i) for i in range(65, 91)]
loweralpha = [chr(i) for i in range(97, 123)]
numbers = [chr(i) for i in range(48, 58)]

def main():
    if(len(sys.argv) >= 2):
        if sys.argv[1] == 'test':
            print('Escape characters:', escape_chars)
            print('Symbols:', symbols)
            print('Uppercase:', upperalpha)
            print('Lowercase:', loweralpha)
            print('Numbers:', numbers)


if __name__ == '__main__':
    main()
