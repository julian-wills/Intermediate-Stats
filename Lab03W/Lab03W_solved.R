# Purpose: Lab Week 3 Wednesday, Exercise 3 Practice
# Date: 9/21/2016
# Instructor: Julian Wills
# Author: JAW 9.20.16

# Install Packages and Initialize Functions --------------------------------------------------------

# NOTE: If you already have 'dplyr' and 'ggplot2' installed, you only need to run these two lines of codes below.
library(dplyr)
library(ggplot2)

# If the code above doesn't work, uncomment and run the lines below:

# # Let's first install ggplot2 for better plots. This should take ~15 seconds. 
# require(ggplot2) || {install.packages("ggplot2", repos="http://cran.us.r-project.org"); require(ggplot2)}
# require(dplyr) || {install.packages("dplyr", repos="http://cran.us.r-project.org"); require(dplyr)}

# Q1 Practice -------------------------------------------------------------

# Imagine we flip a coin twice and count the number of heads. 
# Let's say we repeat this 'experiment' 1 million times. 
# We should eventually converge on the following probability distribution. 
coin_data <- data.frame(num_heads = c(0, 1, 2),
                        probability = c(.25, .5, .25))

ggplot(coin_data) +
  geom_bar(aes(num_heads, probability), stat="identity") + 
  xlab("Number of Times Heads Comes Up") + 
  ylab("Probability of Outcome") + 
  ggtitle("2 Coin Flips (1 Million Times)")

coin_data

Exp_X <- 
  0 * .25 +
  1 * .5 + 
  2 * .25

Exp_X

Var_X <- 
  (0 - Exp_X) ^ 2 * .25 +
  (1 - Exp_X) ^ 2 * .5 + 
  (2 - Exp_X) ^ 2 * .25


# Q2(a) Practice ----------------------------------------------------------

# Assume our population mean = 38.55 and population variance = 353.25
# If we were to draw samples of 9 observations, what would the 
#  expected variance of the sample means be?

# Formula: V(X_bar) = sigma^2 / N

# Go ahead and uncomment the lines below and fill in the answers:
  
mu <- 38.55
sigma_sq <- 353.25
N <- 9

Var_Xbar  = sigma_sq / N
  

# Q2(b-d) Practice -------------------------------------------------------------

setwd("/Users/Julian/GDrive/Misc/Classes/InterStats/")
Lab03_data <- read.csv("Lab03W_data.csv")

hist(Lab03_data$average)     # plot histogram of replication averages
mean(Lab03_data$average)     # compute mean of replication averages
var(Lab03_data$average)      # compute variance of replication averages

hist(Lab03_data$sd ^ 2)      # plot histogram of replication (sample) variances
mean(Lab03_data$sd ^ 2)      # compute mean of replication (sample) variances
var(Lab03_data$sd ^ 2)       # compute variance of replication (sample) variances

hist(Lab03_data$sigma ^ 2)   # plot histogram of replication (population) variances
mean(Lab03_data$sigma ^ 2)   # compute mean of replication (population) variances
var(Lab03_data$sigma ^ 2)    # compute variance of replication (sample) variances

(Lab03_data$sd[9] ^ 2) / 9   # compute the (sample) variance from the last replication sample

# Q3 Practice -------------------------------------------------------------

# Assume we have a normal distribution with 
#  mean = 38.55 and variance = 353.25. 
# What proportion of scores would be less than 10? 

# Formula: z = (X - mu) / sigma
X <- 10
sigma <- sqrt( sigma_sq )
z <- (X - mu) / sigma

pnorm(0)                 # Prob. of scores less than 38.55 (the mean)?
pnorm(z)                 # Prob. of scores less than 10?


# What proportion of scores would fall between 50 and 60? 
X1 <- 50
z1 <- (X - mu) / sigma   # How many SDs is 50 from mean?
p1 <- pnorm(z1)          # Prob. of scores less than 50?

X2 <- 60
z2 <- (X - mu) / sigma   # How many SDs is 60 from mean? 
p2 <- pnorm(z2)          # Prob. of scores less than 60?

p2 - p1                  # Prob. of scores between 50 and 60?


