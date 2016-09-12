# Purpose: Lab Week 2 Monday, Introduction to R, Sampling Variability
# Date: 9/12/2016
# Instructor: Julian Wills
# Author: JAW 9.10.16


# Draw samples (N=10) from population (mu = 5, sigma = 2) --------------------------------------------

set.seed(09122016)  # This just sets the random number generator to today's date.

# Let's drawgive samples from the population with the specified parameters. 
sample1 <- rnorm(n = 10, mean = 5, sd = 2)
sample2 <- rnorm(n = 10, mean = 5, sd = 2)
sample3 <- rnorm(n = 10, mean = 5, sd = 2)
sample4 <- rnorm(n = 10, mean = 5, sd = 2)
sample5 <- rnorm(n = 10, mean = 5, sd = 2)

# And let's print this out to the console. Go ahead and hit 'Source' in the top right of the editor. 
#  Notice that the mean and standard deviation change with each draw.
#  Also notice that the results always stay the same each time you source because we set the seed. 
cat("Mean(SD) of sample 1: ", round(mean(sample1),2), "(", round(sd(sample1),2) , ") \n", sep="")
cat("Mean(SD) of sample 2: ", round(mean(sample2),2), "(", round(sd(sample2),2) , ") \n", sep="")
cat("Mean(SD) of sample 3: ", round(mean(sample3),2), "(", round(sd(sample3),2) , ") \n", sep="")
cat("Mean(SD) of sample 4: ", round(mean(sample4),2), "(", round(sd(sample4),2) , ") \n", sep="")
cat("Mean(SD) of sample 5: ", round(mean(sample5),2), "(", round(sd(sample5),2) , ") \n", sep="")


# Automated using a loop ---------------------------------------------------------------

mu = 5  # Determine the population mean
sigma = 2  # Determine the population standard deviation
N = 10000  # Determine the sample size of the sample


# Let's use a loop to see the process continue. Feel free to change/play with the parameters a bit.
#  For example notice what happens when you change the sample size from 10 to 10,000.
for (i in 1:10) {

  sample_n <- rnorm(n = N, mean = mu, sd = sigma)
  cat("Mean(SD) of sample ", i,": ", round(mean(sample_n),2),"(", round(sd(sample_n),2) ,") \n", sep="")
  if (i<10) {Sys.sleep(1)}

}

