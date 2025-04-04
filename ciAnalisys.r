# Read the data
data_raw <- read.csv("output/res.csv")

# Extract the mean columns (change these if you want lower/upper instead)
grupp1 <- data_raw$Mean_BubbleSort
grupp2 <- data_raw$Mean_MergeSort
grupp3 <- data_raw$Mean_QuickSort
grupp4 <- data_raw$Mean_SelectionSort
grupp5 <- data_raw$Mean_InsertionSort

# Combine into one dataframe
data <- data.frame(
  värden = c(grupp1, grupp2, grupp3, grupp4, grupp5),
  grupp = factor(rep(c("Bubble", "Merge", "Quick", "Selection", "Insertion"), each = length(grupp1)))
)

# Perform pairwise t-test with Bonferroni correction
pairwise.t.test(data$värden, data$grupp, p.adjust.method = "none")