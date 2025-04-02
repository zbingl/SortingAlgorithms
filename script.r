source("rng.r")
source("ci.r")

# Create an empty data frame to store execution times and file sizes
df <- data.frame(Filename = character(),
                 FileSize = numeric(),
                 Mean_BubbleSort = numeric(),
                 Mean_MergeSort = numeric(),
                 Mean_QuickSort = numeric(),
                 Mean_SelectionSort = numeric(),
                 Mean_InsertionSort = numeric(),
                 stringsAsFactors = FALSE)

# Dictionary to store execution times across 20 runs
execution_times <- list()

# Repeat the experiment 20 times
for (i in 1:20) {

  # Generate new datasets each iteration
  input_files <- c(generateDatasetFile(3),
                   generateDatasetFile(5),
                   generateDatasetFile(7),
                   generateDatasetFile(12),
                   generateDatasetFile(20),
                   generateDatasetFile(30),
                   generateDatasetFile(50),
                   generateDatasetFile(90),
                   generateDatasetFile(400),
                   generateDatasetFile(660),
                   generateDatasetFile(1000))

  # Loop over each generated file
  for (file in input_files) {

    # Measure the number of lines in the file
    file_size <- length(readLines(file))

    # Initialize a key for this file if not already present
    if (!file %in% names(execution_times)) {
      execution_times[[file]] <- list(FileSize = file_size,
                                      BubbleSort = numeric(),
                                      MergeSort = numeric(),
                                      QuickSort = numeric(),
                                      SelectionSort = numeric(),
                                      InsertionSort = numeric())
    }

    # Run each sorting algorithm once per file
    execution_times[[file]]$BubbleSort <- c(execution_times[[file]]$BubbleSort,
                                            system.time(system(paste("bin/BubbleSort", file)))["elapsed"])
    execution_times[[file]]$MergeSort <- c(execution_times[[file]]$MergeSort,
                                           system.time(system(paste("bin/MergeSort", file)))["elapsed"])
    execution_times[[file]]$QuickSort <- c(execution_times[[file]]$QuickSort,
                                           system.time(system(paste("bin/QuickSort", file)))["elapsed"])
    execution_times[[file]]$SelectionSort <- c(execution_times[[file]]$SelectionSort,
                                               system.time(system(paste("bin/SelectionSort", file)))["elapsed"])
    execution_times[[file]]$InsertionSort <- c(execution_times[[file]]$InsertionSort,
                                               system.time(system(paste("bin/InsertionSort", file)))["elapsed"])
  }
}

# Compute the mean execution times over the 20 runs
for (file in names(execution_times)) {
  file_data <- execution_times[[file]]

    # Compute mean and confidence intervals for each algorithm
  ci_bubble <- confidenceInterval(file_data$BubbleSort)
  ci_merge <- confidenceInterval(file_data$MergeSort)
  ci_quick <- confidenceInterval(file_data$QuickSort)
  ci_selection <- confidenceInterval(file_data$SelectionSort)
  ci_insertion <- confidenceInterval(file_data$InsertionSort)

  new_row <- data.frame(
                        FileSize = file_data$FileSize,
                        Mean_BubbleSort = mean(file_data$BubbleSort), Lower_BubbleSort = ci_bubble[1], Upper_BubbleSort = ci_bubble[2],
                        Mean_MergeSort = mean(file_data$MergeSort), Lower_MergeSort = ci_merge[1], Upper_MergeSort = ci_merge[2],
                        Mean_QuickSort = mean(file_data$QuickSort), Lower_QuickSort = ci_quick[1], Upper_QuickSort = ci_quick[2],
                        Mean_SelectionSort = mean(file_data$SelectionSort), Lower_SelectionSort = ci_selection[1], Upper_SelectionSort = ci_selection[2],
                        Mean_InsertionSort = mean(file_data$InsertionSort), Lower_InsertionSort = ci_insertion[1], Upper_InsertionSort = ci_insertion[2])

  df <- rbind(df, new_row)
}

# Save results to CSV
write.csv(df, "output/res.csv", row.names = FALSE)
print("Mean sorting execution times and file sizes saved to res.csv")

# Generate plot
png("output/plot.png", width = 800, height = 600)
plot(df$FileSize, df$Mean_BubbleSort, type = "b", col = "red",
     xlab = "Number of Lines (File Size)", ylab = "Mean Runtime (seconds)",
     main = "Sorting Algorithm Runtimes vs. File Size (Logarithmic Scale)",
     ylim = range(df[, 3:7]), log = "x")

# Add other algorithms
lines(df$FileSize, df$Mean_MergeSort, type = "b", col = "blue")
lines(df$FileSize, df$Mean_QuickSort, type = "b", col = "green")
lines(df$FileSize, df$Mean_SelectionSort, type = "b", col = "purple")
lines(df$FileSize, df$Mean_InsertionSort, type = "b", col = "orange")

# Add legend
legend("topleft", legend = c("BubbleSort", "MergeSort", "QuickSort",
                             "SelectionSort", "InsertionSort"),
       col = c("red", "blue", "green", "purple", "orange"),
       lty = 1, pch = 16)

dev.off()
print("Plot saved as plot.png")

for (input_file in input_files) {
  execution_times[[file]]$BubbleSort
  confidenceInterval()
}
