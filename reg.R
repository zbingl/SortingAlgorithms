df <- read.csv("output/res.csv")

algorithms <- c("Mean_BubbleSort", "Mean_MergeSort", "Mean_QuickSort", "Mean_SelectionSort", "Mean_InsertionSort")

fit_models <- function(x, y) {
  linear <- lm(y ~ x)
  quadratic   <- lm(y ~ I(x^2))
  nlogn  <- lm(y ~ x * log(x))

  models <- list(linear = linear, quadratic = quadratic, nlogn = nlogn)
  adj_r2 <- sapply(models, function(m) summary(m)$adj.r.squared)
  best_name <- names(which.max(adj_r2))
  list(name = best_name, model = models[[best_name]], adj_r2 = adj_r2[best_name])
}

for (algo in algorithms) {
  x <- df$FileSize
  y <- df[[algo]]

  result <- fit_models(x, y)


  cat("\nAlgorithm:", algo, "\n")
  cat("  Model with best fit:", result$name , "\n")
  cat("  Adjusted R² value (coefficient of determination):", round(result$adj_r2, 4), "\n")

  # Graphs
  # plot(x, y, main = paste(algo, "Runtime vs Input Size"), xlab = "Input Size", ylab = "Mean Runtime", pch = 19, col = "blue")
  # lines(x, predict(result$model), col = "red", lwd = 2)
  # legend("topleft", legend = c("Data", paste("Best Fit:", result$name)), col = c("blue", "red"), pch = c(19, NA), lty = c(NA, 1))
}
