#include <stdio.h>
#include <stdlib.h>  // For handling dynamic allocation, if needed

// Function to print an array
void printArray(int array[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

void insertionSort(int array[], int size) {
    for (int step = 1; step < size; step++) {
        int key = array[step];
        int j = step - 1;

        // Compare key with each element on the left of it
        // until an element smaller than it is found
        while (j >= 0 && key < array[j]) {
            array[j + 1] = array[j];
            --j;
        }
        array[j + 1] = key;
    }
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

    // Sort the array using Insertion Sort
    insertionSort(arr, size);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);

    return 0;
}

