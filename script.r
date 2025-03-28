# Create an empty data frame to store the mean execution times, file size (number of lines), and filenames
df <- data.frame(Filename = character(),
                 FileSize = numeric(),  # Number of lines in the file
                 Mean_BubbleSort = numeric(),
                 Mean_MergeSort = numeric(),
                 Mean_QuickSort = numeric(),
                 Mean_SelectionSort = numeric(),
                 Mean_InsertionSort = numeric(),
                 stringsAsFactors = FALSE)

# List of input files (replace with your actual filenames)
input_files <- c("data3.txt",
                 "data5.txt", 
                 "data7.txt",
                 "data12.txt", 
                 "data20.txt",
                 "data30.txt",
                 "data50.txt",
                 "data90.txt", 
                 "data400.txt",
                 "data660.txt", 
                 "data1000.txt")  # Add more files as needed

# Loop over each file
for (file in input_files) {
  
  # Create vectors to store the execution times for each sorting algorithm
  bubble_times <- numeric()
  merge_times <- numeric()
  quick_times <- numeric()
  selection_times <- numeric()
  insertion_times <- numeric()
  
  # Measure the number of lines in the file (number of "rows" or data entries)
  file_size <- length(readLines(file))  # Count the number of lines in the file
  
  # Loop to run each sorting method 10 times per file
  for (i in 1:50) {
    bubble_times <- c(bubble_times, system.time(system(paste("./BubbleSort", file)))["elapsed"])
    merge_times <- c(merge_times, system.time(system(paste("./MergeSort", file)))["elapsed"])
    quick_times <- c(quick_times, system.time(system(paste("./QuickSort", file)))["elapsed"])
    selection_times <- c(selection_times, system.time(system(paste("./SelectionSort", file)))["elapsed"])
    insertion_times <- c(insertion_times, system.time(system(paste("./InsertionSort", file)))["elapsed"])
  }
  
  # Calculate mean runtime for each sorting algorithm
  mean_bubble <- mean(bubble_times)
  mean_merge <- mean(merge_times)
  mean_quick <- mean(quick_times)
  mean_selection <- mean(selection_times)
  mean_insertion <- mean(insertion_times)
  
  # Add a new row to the data frame with the file name, file size (number of lines), and mean runtimes
  new_row <- data.frame(Filename = file,
                        FileSize = file_size,
                        Mean_BubbleSort = mean_bubble,
                        Mean_MergeSort = mean_merge,
                        Mean_QuickSort = mean_quick,
                        Mean_SelectionSort = mean_selection,
                        Mean_InsertionSort = mean_insertion)
  
  df <- rbind(df, new_row)
}

# Save the resulting DataFrame to a CSV file
write.csv(df, "res.csv", row.names = FALSE)

print("Mean sorting execution times and file sizes (number of lines) have been saved to res.csv")
#summary(df)

# Open a PNG device to save the plot
png("plot.png", width = 800, height = 600)  # You can adjust the size (width and height) as needed

# Generate the plot
plot(df$FileSize, df$Mean_BubbleSort, type = "b", col = "red", 
     xlab = "Number of Lines (File Size)", ylab = "Mean Runtime (seconds)", 
     main = "Sorting Algorithm Runtimes vs. File Size (Logarithmic Scale)", 
     ylim = range(df[, 3:7]), log = "x")

# Add other lines for other sorting algorithms
lines(df$FileSize, df$Mean_MergeSort, type = "b", col = "blue")
lines(df$FileSize, df$Mean_QuickSort, type = "b", col = "green")
lines(df$FileSize, df$Mean_SelectionSort, type = "b", col = "purple")
lines(df$FileSize, df$Mean_InsertionSort, type = "b", col = "orange")

# Add legend
legend("topleft", legend = c("BubbleSort", "MergeSort", "QuickSort", 
                             "SelectionSort", "InsertionSort"),
       col = c("red", "blue", "green", "purple", "orange"), 
       lty = 1, pch = 16)

# Close the PNG device (this writes the plot to the file)
dev.off()

print("Plot saved as plot.png")
