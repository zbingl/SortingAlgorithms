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





    int arr[1000];  // Array to store up to 1000 integers from the file
    int size = 0;

    // Read integers from the file and store them in the array
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
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


    return 0;
}

