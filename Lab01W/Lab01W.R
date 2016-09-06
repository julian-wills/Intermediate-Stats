# Author: Julian Wills
# Date: 9/7/2016
# Purpose: Lab 1, Introduction to R, RStudio, and Exercise 1 Practice


# Install Packages and Initialize Functions --------------------------------------------------------

# Run these lines of code to load and install packages. We won't be using these today but it is good
#  practice. 
require(dplyr) || {install.packages("dplyr"); require(dplyr)}
require(ggplot2) || {install.packages("ggplot2"); require(ggplot2)}
require(tidyr) || {install.packages("tidyr"); require(tidyr)}

# From: http://stackoverflow.com/questions/2547402/is-there-a-built-in-function-for-finding-the-mode
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


# Introduction to R -------------------------------------

# This is a comment. You can know this because (1) the line begins with a '#' and the RStudio font is green. 
# You can turn a comment into a 'section' by adding four dashes like this ----
# You can now collapse all the information in this section by clicking the tiny arrow right next to line 13. 

# If you don't know a function, you can look it up by typing '?' in front. 
?sample
?mean 
?cat


# Calculator --------------------------------------------------------------

# You can always use R as a calculator. E.g. adding/subtract/multiply numbers. This can be done
#  through the editor or directly through the console. 
1 + 1   # = 2
11.5 / 0   # = Inf

# Vectors and Random Samples ----------------------------------------------

# Let's create a vector of integers from 1 to 5. We can do this by using the c() function to 
#  "concatenate" a set of "values" into a single "vector"
c(1, 2, 3, 4, 5)   # manual approach
c(1:5)  # shortcut using sequence operator ':'

# Now let's generate a random sample of numbers from a uniform distribution
set.seed(09072016)  # This resets the random number generator for reproducibility
sample(10:50,10,TRUE)  # prints to console, but doesn't save it
sample1 <- sample(10:50,10,TRUE)  # assign the output to a new variable


# Descriptive Statistics --------------------------------------------------

# Mean
mean1a <- mean(sample1)  # You can always check your work by using the built in function
mean1b <- (16 + 16 + 20 + 20 + 33 + 25 + 41 + 15 + 23 + 43) / 10  # But always show your work by hand
all.equal(mean1a, mean1b)  # This compares these two vectors and says 'TRUE' if they are equivalent

cat("\n Mean of sample1 is: ", mean1b)  # This prints out to console. The '\n' means insert 'new line'

# Median
median1a <- median(sample1)
sort(sample1)  #helpful function
median1b <- (20 + 23) / 2  # 15 16 16 20 [20 23] 25 33 41 43
all.equal(median1a, median1b)
cat("\n Median of sample1 is: ", mean1b)

# Mode
mode1a <- mode(sample1)  
mode1b <- 16  # 15 [16 16] [20 20] 23 25 33 41 43
all.equal(mode1a, mode1b)
cat("\n Mode of sample1 is: ", mode1b)

#BONUS: 
#mode <- mode(sample1)   <==== Why would we NOT want to run this code?

# Sample Variance
sampleVar1a <- var(sample1)
sampleVar1b <-
  ( 
    (16 - 25.2) ^ 2 + 
      (16 - 25.2) ^ 2 + 
      (20 - 25.2) ^ 2 + 
      (20 - 25.2) ^ 2 + 
      (33 - 25.2) ^ 2 + 
      (25 - 25.2) ^ 2 + 
      (41 - 25.2) ^ 2 + 
      (15 - 25.2) ^ 2 + 
      (23 - 25.2) ^ 2 + 
      (43 - 25.2) ^ 2
    ) / (10 - 1)
all.equal(sampleVar1a, sampleVar1b)
cat("\n Sample variance of sample1 is: ", sampleVar1b)

# Population Variance
popVar1a <- var(sample1) * (length(sample1) - 1) / length(sample1) # lot of code...
popVar1b <-
  ( 
    (16 - 25.2) ^ 2 + 
      (16 - 25.2) ^ 2 + 
      (20 - 25.2) ^ 2 + 
      (20 - 25.2) ^ 2 + 
      (33 - 25.2) ^ 2 + 
      (25 - 25.2) ^ 2 + 
      (41 - 25.2) ^ 2 + 
      (15 - 25.2) ^ 2 + 
      (23 - 25.2) ^ 2 + 
      (43 - 25.2) ^ 2
  ) / 10
all.equal(popVar1a, popVar1b)
cat("\n Population variance of sample1 is: ", popVar1b)

# Stem and leaf -----------------------------------------------------------
stem(sample1) #This is one way to check your work.


# Combining Samples -------------------------------------------------------
sample2 <- sample1 <- sample(10:50,10,TRUE) #create another sample
combined_sample <- c(sample1, sample2) #combine vectors with c() function ("concatenate")


# Find Percentile ---------------------------------------------------------

# What proportion of the data is less than or equal to 19?
ecdf(sample1)(19)

# What proportion of the data is greater than or equal to 19?
1 - ecdf(sample1)(19) 


# Misc: Importing and writing data --------------------------------------------------

# Let's now create a file where we can store our sample
write.table(sample1, file="Lab01W_sample1.txt", col.names=F, row.names=F)

# Now that we have saved this vector in a file we can import it into a new object. 
sample1_import <- scan(file="Lab01W_sample1.txt")

# We use 'scan' for vectors but more often we will use write.csv and read.csv when we have multiple vectors
#  in the format of a table. R calls this type of object a 'dataframe' which we will explore more in the
#  next section. 

