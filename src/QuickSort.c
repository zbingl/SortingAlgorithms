#include <stdio.h>
#include <stdlib.h>  // For malloc() and dynamic memory allocation

// Function to swap elements
void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

// Function to find the partition position
int partition(int array[], int low, int high) {
    int pivot = array[high];  // Select the rightmost element as pivot
    int i = (low - 1);        // Pointer for the greater element

    for (int j = low; j < high; j++) {
        if (array[j] <= pivot) {
            i++;
            swap(&array[i], &array[j]);  // Swap if element smaller than pivot is found
        }
    }
    swap(&array[i + 1], &array[high]);  // Swap pivot element with the greater element at i
    return (i + 1);  // Return the partition point
}

void quickSort(int array[], int low, int high) {
    if (low < high) {
        int pi = partition(array, low, high);  // Find the pivot element
        quickSort(array, low, pi - 1);         // Recursively sort left of pivot
        quickSort(array, pi + 1, high);        // Recursively sort right of pivot
    }
}

// Function to print array elements
void printArray(int array[], int size) {
    for (int i = 0; i < size; ++i) {
        printf("%d  ", array[i]);
    }
    printf("\n");
}

// Main function: Load data from "data.txt" and sort it
int main(int argc, char *argv[]) {
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

    int arr[1000];  // Array to store numbers from the file (up to 1000 integers)
    int size = 0;

    // Read integers from the file
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
    }
    fclose(file);

    //printf("Unsorted Array:\n");
    //printArray(arr, size);

    quickSort(arr, 0, size - 1);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);

    return 0;
}

