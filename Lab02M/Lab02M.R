# Purpose: Lab Week 2 Monday, Introduction to R, Sampling Variability
# Date: 9/12/2016
# Instructor: Julian Wills
# Author: JAW 9.10.16


# Draw samples (N=10) from population (mu = 10, sigma = 1) --------------------------------------------

set.seed(09122016)

sample1 <- rnorm(n = 10, mean = 5, sd = 2)
sample2 <- rnorm(n = 10, mean = 5, sd = 2)
sample3 <- rnorm(n = 10, mean = 5, sd = 2)
sample4 <- rnorm(n = 10, mean = 5, sd = 2)
sample5 <- rnorm(n = 10, mean = 5, sd = 2)

cat("Mean(SD) of sample 1: ", round(mean(sample1),2), "(", round(sd(sample1),2) , ") \n", sep="")
cat("Mean(SD) of sample 2: ", round(mean(sample2),2), "(", round(sd(sample2),2) , ") \n", sep="")
cat("Mean(SD) of sample 3: ", round(mean(sample3),2), "(", round(sd(sample3),2) , ") \n", sep="")
cat("Mean(SD) of sample 4: ", round(mean(sample4),2), "(", round(sd(sample4),2) , ") \n", sep="")
cat("Mean(SD) of sample 5: ", round(mean(sample5),2), "(", round(sd(sample5),2) , ") \n", sep="")


# Automated using a loop ---------------------------------------------------------------

mu = 5  # Determine the population mean 
sigma = 2  # Determine the population standard deviation
N = 10  # Determine the sample size of the sample

for (i in 1:10) {

  sample_n <- rnorm(n = N, mean = mu, sd = sigma)
  cat("Mean(SD) of sample ", i,": ", round(mean(sample_n),2),"(", round(sd(sample_n),2) ,") \n", sep="")
  if (i<10) {Sys.sleep(1)}

}

