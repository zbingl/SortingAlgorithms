#include <stdio.h>
#include <stdlib.h>  // For malloc() if needed
#include <time.h>


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

    int arr[1000];  // Array to store up to 1000 numbers from the file
    int size = 0;

    // Read integers from the file
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
    }
    fclose(file);

    //printf("Unsorted Array:\n");
    //printArray(arr, size);

    start = clock();

    selectionSort(arr, size);

    //printf("Sorted Array in Ascending Order:\n");
    //printArray(arr, size);

    end = clock();
    cpu_time_used = ((int) (end - start));

    printf("%d\n", cpu_time_used);


    return 0;
}

