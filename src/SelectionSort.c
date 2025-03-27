#include <stdio.h>
#include <stdlib.h>  // For malloc() if needed

// Function to swap the position of two elements
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void selectionSort(int array[], int size) {
    for (int step = 0; step < size - 1; step++) {
        int min_idx = step;
        for (int i = step + 1; i < size; i++) {
            // Select the minimum element in each iteration
            if (array[i] < array[min_idx])
                min_idx = i;
        }
        // Put the minimum element at the correct position
        swap(&array[min_idx], &array[step]);
    }
}

// Function to print an array
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

    int arr[1000];  // Array to store up to 1000 numbers from the file
    int size = 0;

    // Read integers from the file
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
    }
    fclose(file);

    //printf("Unsorted Array:\n");
    //printArray(arr, size);

    selectionSort(arr, size);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);

    return 0;
}

