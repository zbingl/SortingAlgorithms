# Skapa exempeldata (5 grupper)
set.seed(123)
grupp1 <- rnorm(20, mean = 10, sd = 2)
grupp2 <- rnorm(20, mean = 12, sd = 2)
grupp3 <- rnorm(20, mean = 11, sd = 2)
grupp4 <- rnorm(20, mean = 13, sd = 2)
grupp5 <- rnorm(20, mean = 10.5, sd = 2)

# Kombinera data till en dataframe
data <- data.frame(
  värden = c(grupp1, grupp2, grupp3, grupp4, grupp5),
  grupp = factor(rep(c("G1", "G2", "G3", "G4", "G5"), each = 20))
)

# Parvisa t-tester med Bonferroni-korrigering
pairwise.t.test(data$värden, data$grupp, p.adjust.method = "bonferroni")
