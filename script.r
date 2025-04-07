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
for (i in 1:5) {

  # Generate new datasets each iteration
  input_files <- c(generateDatasetFile(3),
                   generateDatasetFile(4),
                   generateDatasetFile(5),
                   generateDatasetFile(6),
                   generateDatasetFile(7),
                   generateDatasetFile(9),
                   generateDatasetFile(10),
                   generateDatasetFile(12),
                   generateDatasetFile(15),
                   generateDatasetFile(18),
                   generateDatasetFile(21),
                   generateDatasetFile(30),
                   generateDatasetFile(35),
                   generateDatasetFile(36),
                   generateDatasetFile(43),
                   generateDatasetFile(52),
                   generateDatasetFile(62),
                   generateDatasetFile(74),
                   generateDatasetFile(89),
                   generateDatasetFile(106),
                   generateDatasetFile(127),
                   generateDatasetFile(152),
                   generateDatasetFile(182),
                   generateDatasetFile(218),
                   generateDatasetFile(261),
                   generateDatasetFile(312),
                   generateDatasetFile(374),
                   generateDatasetFile(447),
                   generateDatasetFile(535),
                   generateDatasetFile(640),
                   generateDatasetFile(766),
                   generateDatasetFile(916))

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
        as.numeric(system(paste("bin/BubbleSort", file), intern = TRUE)))

    execution_times[[file]]$MergeSort <- c(execution_times[[file]]$MergeSort,
        as.numeric(system(paste("bin/MergeSort", file), intern = TRUE)))

    execution_times[[file]]$QuickSort <- c(execution_times[[file]]$QuickSort,
        as.numeric(system(paste("bin/QuickSort", file), intern = TRUE)))

    execution_times[[file]]$SelectionSort <- c(execution_times[[file]]$SelectionSort,
        as.numeric(system(paste("bin/SelectionSort", file), intern = TRUE)))

    execution_times[[file]]$InsertionSort <- c(execution_times[[file]]$InsertionSort,
        as.numeric(system(paste("bin/InsertionSort", file), intern = TRUE)))
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
     xlab = "Number of Lines (File Size)", ylab = "Mean clockcycles elapsed",
     main = "Sorting Algorithm nbr. of cycles per run vs. Size of sorted list (Logarithmic Scale)",
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

