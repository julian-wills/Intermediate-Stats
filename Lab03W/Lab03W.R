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

# Go ahead and uncomment the lines below and fill in the answers:

# Exp_X <- 
#   
# Var_X <- 

# Q2(a) Practice ----------------------------------------------------------

# Assume our population mean = 38.55 and population variance = 353.25
# If we were to draw samples of 9 observations, what would the 
#  expected variance of the sample means be?

# Formula: V(X_bar) = sigma^2 / N

# Go ahead and uncomment the lines below and fill in the answers:

# mu <- 
# sigma_sq <-
# N <- 
# 
# Var_Xbar  <-


# Q2(b-d) Practice -------------------------------------------------------------

# setwd("/Users/Julian/GDrive/Misc/Classes/InterStats/")
Lab03_data <- read.csv( file.choose() )  # Select the 'Lab03W_data.csv' in downloads

# Let's take a look at the data we just imported
Lab03_data

# Let's examine the distributions and means of these estimates (the last 3 columns).
# HINT: let's use the hist() and mean() functions.


# How do these compare to the expected values we calculated in the last section?

# Compute the (sample) variance from the last replication sample


# Q3 Practice -------------------------------------------------------------

# Assume we have a normal distribution with 
#  mean = 38.55 and variance = 353.25. 
# What proportion of scores would be less than 10? 

# Formula: z = (X - mu) / sigma
# Go ahead and uncomment the lines below and fill in the answers:

# X <- 
# mu <- 
# sigma  <- 
# z <- 

# HINT: We will be using the pnorm() function to convert z scores to probabilities. 


# What proportion of scores would fall between 50 and 60? 

# X1 <- 
# z1 <- 
# p1 <-
# 
# X2 <- 
# z2 <-  
# p2 <- 



