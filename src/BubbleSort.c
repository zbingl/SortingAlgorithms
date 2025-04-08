#include <stdio.h>
#include <stdlib.h>  // For handling dynamic allocation, if needed
#include <time.h>

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

int main(int argc, char *argv[]) {
    clock_t start, end;
    int cpu_time_used;

    int *arr = NULL;
    int capacity = 100;  // Start with a small initial array capacity

    // Check if the user provided the input file as a command-line argument
    if (argc != 2) {
        printf("Usage: %s <inputfile>\n", argv[0]);
        return 1;
    }

    // Open the input file passed as an argument
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error: Could not open file '%s'.\n", argv[1]);
        return 1;
    }





    // Allocate initial memory
    arr = (int *)malloc(capacity * sizeof(int));
    if (arr == NULL) {
        perror("malloc failed");
        return 1;
    }
    int size = 0;


    // Read integers from the file, expanding array as needed
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;

        // If size reaches capacity, double the capacity
        if (size >= capacity) {
            capacity *= 2;
            int *temp = realloc(arr, capacity * sizeof(int));
            if (temp == NULL) {
                perror("realloc failed");
                free(arr);
                return 1;
            }
            arr = temp;
        }
    }
    fclose(file);  // Close the file

    //printf("Unsorted Array:\n");
    //printArray(arr, size);

    start = clock();

    // Sort the array using Bubble Sort
    bubbleSort(arr, size);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);
    end = clock();
    cpu_time_used = ((int) (end - start));

    printf("%d\n", cpu_time_used);

    free(arr);

    return 0;
}

