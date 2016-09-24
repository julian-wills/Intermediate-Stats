# Purpose: Lab Week 3 Monday, Introduction to R, Exercise 3 Practice
# Date: 9/19/2016
# Instructor: Julian Wills
# Author: JAW 9.19.16

# Install Packages and Initialize Functions --------------------------------------------------------

# NOTE: If you already have 'dplyr' and 'ggplot2' installed, you only need to run these two lines of codes below.
#  If this doesn't work on your personal or lab computer, then you will need to run the lines below instead. 
library(dplyr)
library(ggplot2)
#library(psych)
#library(stats)

# If the code above doesn't work, uncomment and run this section:

# # Let's first install ggplot2 for better plots. This should take ~15 seconds. 
# require(ggplot2) || {install.packages("ggplot2", repos="http://cran.us.r-project.org"); require(ggplot2)}
# 
# # If you are on the quant lab computer, you must run all these lines of codes to install dplyr. 
# require(DBI) || {install.packages("DBI", repos="http://cran.us.r-project.org"); require(DBI)}
# require(assertthat) || {install.packages("assertthat", repos="http://cran.us.r-project.org"); require(assertthat)}
# require(R6) || {install.packages("R6", repos="http://cran.us.r-project.org"); require(R6)}
# require(tibble) || {install.packages("tibble", repos="http://cran.us.r-project.org"); require(tibble)}
# utils::install.packages("/Users/quant/Downloads/dplyr_0.5.0.zip", repos=NULL)
# library(dplyr)

# R Practice -------------------------------------------------------------

# Let's start by printing the values 0, 1, and 2
0 
1
2

# Now let's save (or assign) these values into variables (or objects)
value1 <- 0
value2 <- 1
value3 <- 2

# We see that 'value1' and '0' return the same value.
value1
0

value2
1

value3
2

# Use c() to concatenate these values into a single vector
c(0, 1, 2)

# Now let's assign these three values into a vector object
vector1 <- c(0, 1, 2) 

# Now, anytime we 'reference' vector1 in our script, we are referring to the vector [0, 1, 2]
vector1

# We can remove this object from our workspace by using rm()
rm(vector1)
vector1  # ERROR! We just deleted this object

# Since vector1 no longer exists, we have to redefine it. 
vector1 <- c(0, 1, 2) 

# This are alternative ways of achieving the same outcome
vector1_b <- c(value1, value2, value3) 
vector1_c <- c(value1, 
               value2, 
               value3) 

vector1_b
vector1_c

# Now let's create another vector object
vector2 <- c(.25, .5, .25)

# Now we are going to create a 'dataframe' object. Think of a dataframe as a collection of vectors. 
# Each vector is is a column (or variable) in our dataframe. 
# Here we are labeling the columns 'variable1' and 'variable2'
data_object <- data.frame(variable1 = c(0, 1, 2),
                          variable2 = c(.25, .5, .25))

# These are alternative ways of achieving the same outcome
data_object_b <- data.frame(variable1 = vector1,
                            variable2 = vector2)
install.packages("dplyr")


library(dplyr)

c(1, 2, 3, 4, 5, 6)

data_object_c <- read.csv(file.choose(), header = T)

data_object_c <- read.csv(file = "Lab03M_practice_data.csv", header = FALSE)
data_object_d <- read.csv(file = "Lab03M_practice_data.csv")
data_object_e <- read.csv("Lab03M_practice_data.csv")


data_object2 <- read.csv( file.choose() )

# Use class() to examine what kind of object you are dealing with. 
class(data_object)
class(vector1)  # Most vectors we will be using will be 'numeric'

mean()
mean(vector1)
median(vector1)


file.choose()

data_object
data_object

mean(data_object)

data_object$variable1

mean( data_object$variable1 )
data_object[1, 1]
# There are several ways to reference (or 'index') values in a dataframe.
# Let's start by isolating the first variable. 
data_object$variable1  # Most common
data_object[ ,1]       # Less common
data_object[[1]]       # Least common

# NOTE: This output looks similar, but it is still a dataframe
data_object[1]

# Now let's index the second variable only. 
data_object[[2]]
data_object[ ,2]
data_object$variable2

# Now let's look inside the first row (or observation)
data_object[1, ]

# Now let's look at the first observation in the first variable. 
data_object[1, 1]
data_object[[1]][1]
data_object$variable1[1]

# Now let's look at the first observation in the second variable. 
data_object[1, 2]
data_object[[2]][1]
data_object$variable2[1]

# Now let's look at the second observation in the first variable. 
data_object[2, 1]
data_object[[1]][2]
data_object$variable1[2]

# These are three ways of adding values together
data_object[1,2] + data_object[2,2]  # (1)
0.25 + 0.5                           # (2)
0.25 +                               # (3)
  0.5

# These are two ways of computing a weighted sum
data_object[1,1] * data_object[1,2] +  # (1)
  data_object[2,1] * data_object[2,2] +
  data_object[3,1] * data_object[3,2] 

#                                      # (2)
0 * .25 +
  1 * .5 + 
  2 * .25

# This distinction between dfs and vectors is very important! 
# Some functions work on vectors (or df variables), (e.g., base::mean() )
#  some only work on dfs,                           (e.g., dplyr::mutate() )
#  and some work on both dfs and vectors.           (e.g., base::summary() )

# For example, let's use the mean() function to describe our data
mean()            # ERROR: need to supply a numeric vector
mean(1)           # SUCCESS: (1) is technically a vector with length = 1
mean(0, 1, 2)     # ERROR: this supplies multiple arguments
mean(c(0, 1, 2))  # SUCCESS: use c() to create a vector
mean(vector1)     # SUCCESS: supply a vector we previously defined
mean(data_object$variable1)  # SUCCESS: supply a variable within a dataframe (df)
mean(variable1)   # ERROR: 'variable1' is not an object. It is the name of a column in our df   
mean(data_object) # ERROR: mean() only works on vectors, not dataframes

variable1 <- c(4,5,6)

# Notice that hist() also only accepts vector inputs
hist(vector1)     # SUCCESS: supply a vector we previously defined
hist(data_object$variable1) # SUCCESS: supply a variable within a df
hist(variable1)   # ERROR: 'variable1' is not an object. It is the name of a column in our df  
hist(data_object) # ERROR: hist() only works on vectors, not dataframes

# summary() works on either dfs or vectors (but is primarily used for dfs)
summary(data_object)            # df
summary(data_object$variable1)  # vector

# dplyr verbs (functions) are designed to work on dataframes only.
# In addition, dplyr verbs always give back (or 'return') a df. 
mutate(data_object, new_variable = "This is our new variable!")

# The '$' operator can be a bit confusing, which is part of what makes 'dplyr' and 'ggplot2' so great. 
# When transforming a variable, for instance, dplyr assumes that variables belong to the df specified
#   in the first argument. 
mutate(data_object, variable2_T = variable2 + 1)  # dplyr knows that 'variable2' belongs to the df
mutate(data_object, variable2_T = data_object$variable2 + 1)  # same output as line above

ggplot(data_object) + 
  geom_bar(aes(x = variable1, y = variable2), stat="identity")

5 + 
summarize(data_object, mean(variable2))

mutate(data_object,
       variable2_C = variable2 - mean(variable2),
       variable2_S = variable2_C / sd(variable2),
       var6 = 0,
       var5 = 5
       )

geom 

# These also return the same output, but this is not how ggplot is used. 
ggplot(data_object) + 
  geom_bar(aes(x = data_object$variable1, y = data_object$variable2), stat="identity")

ggplot(data_object) + 
  geom_point(aes(x = variable1, y = variable2))


#-- arguments
#-- ggplot
#-- saving .csv from excel
#-- commas, plus signs for continuan
#-- math operators ^ = exponent 

5 ^ 5
5 ^ 2

sqrt( 500) / 40
# Q1 Practice -------------------------------------------------------------

## Might not have time to go through this but will resume on Wednesday.

# Exp_X <- 
#   0 * .25 +
#   1 * .5 + 
#   2 * .25
# 
# Var_X <- 
#   (0 - Exp_X) ^ 2 * .25 +
#   (1 - Exp_X) ^ 2 * .5 + 
#   (2 - Exp_X) ^ 2 * .25
# 
# 
# # ggplot(data_object) + 
# #   geom_bar(aes(variable1, variable2), stat="identity")


