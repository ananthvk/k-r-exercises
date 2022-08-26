#include <stdio.h>
#include <stdlib.h>
#define SWAP(x, y, t) \
    {                 \
        t tmp = x;    \
        x = y;        \
        y = tmp;      \
    }

void displayArray(int *arr, size_t n);

void ssort(int *arr, size_t n)
{
    // Performs selection sort on the input array
    size_t smallest;
    for (size_t i = 0; i < n; i++) {
        printf("Pass %zu: ", i);
        displayArray(arr, n);

        smallest = i;
        // Find the smallest element in the array
        for (size_t j = i + 1; j < n; j++) {
            if (arr[j] < arr[smallest]) smallest = j;
        }
        // Swap the element at ith position with the smallest element
        int tmp = arr[i];
        arr[i] = arr[smallest];
        arr[smallest] = tmp;
        printf("        ");
        displayArray(arr, n);
        printf("====================\n");
    }
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

void merge(int *aux, int *arr1, size_t n1, int *arr2, size_t n2)
{
    // Merges elements from two arrays into an auxillary array
    // in a sorted manner
    // Find the pointer to last element of both arrays
    int *arr1_end = arr1 + n1 - 1;
    int *arr2_end = arr2 + n2 - 1;
    while ((arr1 <= arr1_end) && (arr2 <= arr2_end)) {
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
        // Copy remaining elements
        *aux++ = *arr1++;
    }
    while (arr2 <= arr2_end) {
        // Copy remaining elements
        *aux++ = *arr2++;
    }
}
void merge_sort(int *arr, size_t n, int *aux)
{
    if (n < 1) {
        printf("%s\n", "SERIOUS ERROR, n < 1");
        exit(-1);
    }
    // Only one element, it is already sorted
    if (n == 1) return;

    size_t l_i = n / 2;
    size_t r_i = n - (n / 2);


    // merge sort the left half
    merge_sort(arr, l_i, aux);
    // merge sort the right half
    merge_sort(arr + l_i, r_i, aux);

    // merge the two halves together
    merge(aux, arr, l_i, arr + l_i, r_i);
    for(size_t i = 0; i < n; i++)
        *(arr+i) = *(aux+i);
    // displayArray(aux, n);
    displayArray(arr, n);
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

#define SIZE 13
int main()
{
    // Array of SIZE numbers
    int arr[SIZE] = {1, 11, 7, 8, 2, 0, 3, 16, 4, 9, 3, 5, 12};
    int aux[SIZE];
    displayArray(arr, SIZE);
    // ssort(arr, SIZE);
    merge_sort(arr, SIZE, aux);
    displayArray(arr, SIZE);
}
