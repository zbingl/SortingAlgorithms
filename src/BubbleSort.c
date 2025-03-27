#include <stdio.h>
#include <stdlib.h>  // For handling dynamic allocation, if needed

// Perform the optimized bubble sort
void bubbleSort(int array[], int size) {
    // Loop to access each array element
    for (int step = 0; step < size - 1; ++step) {
        int swapped = 0;  // Check if swapping occurs

        // Loop to compare adjacent elements
        for (int i = 0; i < size - step - 1; ++i) {
            // Compare two array elements and swap if necessary
            if (array[i] > array[i + 1]) {
                int temp = array[i];
                array[i] = array[i + 1];
                array[i + 1] = temp;
                swapped = 1;
            }
        }

        // If no swapping occurs, the array is already sorted
        if (swapped == 0) {
            break;
        }
    }
}

// Function to print the array
void printArray(int array[], int size) {
    for (int i = 0; i < size; ++i) {
        printf("%d  ", array[i]);
    }
    printf("\n");
}

int main() {
    FILE *file = fopen("data.txt", "r");
    if (file == NULL) {
        printf("Error: Could not open file 'data.txt'.\n");
        return 1;
    }

    int arr[1000];  // Array to store up to 1000 integers from the file
    int size = 0;

    // Read integers from the file and store them in the array
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
    }
    fclose(file);  // Close the file

    //printf("Unsorted Array:\n");
    //printArray(arr, size);

    // Sort the array using Bubble Sort
    bubbleSort(arr, size);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);

    return 0;
}

