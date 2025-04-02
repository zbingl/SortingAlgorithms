confidenceInterval <- function(x, confidenceLevel=0.95){
	N <- length(x)
	alpha <- 1-confidenceLevel
	if (N<30)
	   stat <- qt(1-alpha/2, N-1)
	else
	   stat <- qnorm(1-alpha/2)
	interval <- stat * sd(x) / sqrt(N)
	mean_value <- mean(x)
	result <- c(mean_value-interval, mean_value+interval)
	names(result) <- c("lower", "upper")
	result
}