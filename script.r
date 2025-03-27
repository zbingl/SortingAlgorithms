library(dplyr)

# Create an empty data frame to store the execution times
df <- data.frame(BubbleSort = numeric(),
                 MergeSort = numeric(),
                 QuickSort = numeric(),
                 SelectionSort = numeric(),
                 InsertionSort = numeric())

# Loop to run and time each sorting method 5 times
for (i in 1:20) {
  # Measure and record execution times for each sorting algorithm
  bubble_time <- system.time(system("./BubbleSort"))["elapsed"]
  merge_time <- system.time(system("./MergeSort"))["elapsed"]
  quick_time <- system.time(system("./QuickSort"))["elapsed"]
  selection_time <- system.time(system("./SelectionSort"))["elapsed"]
  insertion_time <- system.time(system("./InsertionSort"))["elapsed"]

  # Add the results to the data frame
  df <- df %>%
    add_row(BubbleSort = bubble_time,
            MergeSort = merge_time,
            QuickSort = quick_time,
            SelectionSort = selection_time,
            InsertionSort = insertion_time)
}

# Save the resulting DataFrame to a CSV file
write.csv(df, "res.csv", row.names = FALSE)

print("Sorting execution times saved to res.csv")
summary(df)

