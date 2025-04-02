#include <stdio.h>
#include <stdlib.h>  // For atoi() and malloc()

// Merge function
void merge(int arr[], int p, int q, int r) {

    int n1 = q - p + 1;
    int n2 = r - q;

    int *L = malloc(n1 * sizeof(int));
    int *M = malloc(n2 * sizeof(int));

    if (L == NULL || M == NULL) {
        // Handle allocation failure
        printf("Memory allocation failed\n");
        exit(1);
    }

    for (int i = 0; i < n1; i++)
        L[i] = arr[p + i];
    for (int j = 0; j < n2; j++)
        M[j] = arr[q + 1 + j];

    int i = 0, j = 0, k = p;

    while (i < n1 && j < n2) {
        if (L[i] <= M[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = M[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = M[j];
        j++;
        k++;
    }

    free(L);
    free(M);
}

// Recursive merge sort function
void mergeSort(int arr[], int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;

        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}

// Function to print the array
void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

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

    int arr[5000];  // Array to store up to 1000 numbers (adjustable)
    int size = 0;

    // Read integers from the file
    while (fscanf(file, "%d", &arr[size]) != EOF) {
        size++;
    }
    fclose(file);

    //printf("Unsorted array: \n");
    //printArray(arr, size);

    mergeSort(arr, 0, size - 1);

    //printf("Sorted array: \n");
    //printArray(arr, size);

    return 0;
}

