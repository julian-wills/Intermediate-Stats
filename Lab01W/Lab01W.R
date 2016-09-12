# Purpose: Lab 1, Introduction to R, RStudio, and Exercise 1 Practice
# Date: 9/7/2016
# Author: Julian Wills


# Install Packages and Initialize Functions --------------------------------------------------------

# Run these lines of code to load and install packages. We won't be using these today but it is good
#  practice. 
require(dplyr) || {install.packages("dplyr"); require(dplyr)}
require(ggplot2) || {install.packages("ggplot2"); require(ggplot2)}
require(tidyr) || {install.packages("tidyr"); require(tidyr)}

#  We call this function 'mode2' because 'mode' already refers to a function in R. 
mode2 = function(x){
  
  # Author: Ethan Ludwin-Peery
  output = as.numeric(names(table(x)[table(x) == max(table(x))]))
  
  if (length(output) < length(table(x))) {
    return(output)
  } else {
    stop("No mode or all modes. All values occur equally often.")
  }
  
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
sample1 <- sample(10:50,10,TRUE)  # assign the output to a new variable 'sample1'.
# We want to avoid assigning this variable to 'sample' because that would (temporarily) overwrite the sample() function


# Descriptive Statistics --------------------------------------------------

# Now we are going to compute some descriptives statistics of this sample using
#  both (a) functions in R and (b) manually by showing our work. For HW1 you will be evaluated based on your 
#  manual calculations, though you can always use R's functions to check your work. Going forward, we will
#  refer to computations done w/ R functions using the '_a' suffix and manual computations using the '_b' suffix.
#  For example, 'mean_a' uses the built in function mean() whereas 'mean_b' was computed manually. 

# Mean
mean_a <- mean(sample1)  # You can always check your work by using the built in function
mean_b <- (16 + 16 + 20 + 20 + 33 + 25 + 41 + 15 + 23 + 43) / 10  # But always show your work by hand
all.equal(mean_a, mean_b)  # This compares these two vectors and says 'TRUE' if they are equivalent

cat("\n Mean of sample1 is: ", mean_b)  # This prints out to console. The '\n' means insert 'new line'

# Median
median_a <- median(sample1)
sort(sample1)  #helpful function
median_b <- (20 + 23) / 2  # 15 16 16 20 [20 23] 25 33 41 43
all.equal(median_a, median_b)
cat("\n Median of sample1 is: ", mean_b)

# Mode
mode_a <- mode2(sample1) 
mode_b <- c(16, 20)  # 15 [16 16] [20 20] 23 25 33 41 43
all.equal(mode_a, mode_b)
cat("\n Mode(s) of sample1 is: ", mode_b)

# Sample Variance
sampleVar_a <- var(sample1)
sampleVar_b <-
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
all.equal(sampleVar_a, sampleVar_b)
cat("\n Sample variance of sample1 is: ", sampleVar_b)

# Population Variance
popVar_a <- var(sample1) * (length(sample1) - 1) / length(sample1) # lot of code...
popVar_b <-
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
all.equal(popVar_a, popVar_b)
cat("\n Population variance of sample1 is: ", popVar_b)

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

