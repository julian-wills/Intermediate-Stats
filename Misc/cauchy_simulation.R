# Purpose: Simulate expected mean and variance of Cauchy distribution
# Author: JAW 9.24.16

# Specify three random seeds
seeds <- c(0924201601, 0924201602, 0924201603)

iters = 10000  # Specify number of iterations
N = 100        # Specify sample size

cauchyMeans <- NULL  # Create empty vector to store sample means
cauchyVars <- NULL   # Create empty vector to store sample variances
dFinal <- NULL       # Create empty dataframe to store output

for (s in seeds) {
  set.seed(s)
  for (i in 1:iters) { 
    cauchySample <- rcauchy(n = 100)                   # Draw random sample from Cauchy distribution
    cauchyMeans <- c(cauchyMeans, mean(cauchySample))  # Append mean
    cauchyVars <- c(cauchyVars, var(cauchySample))     # Append variance
  }
  
  # Append row to dataframe with mean and variance for each seed
  dFinal <- rbind(dFinal, data.frame(Seed = s, Mean = mean(cauchyMeans), Variance = mean(cauchyVars)))
  cat("Finished seed: ", s, "\n")  # Print progress to console
}

dFinal  # Print final dataframe to console


# An alternative approach without rcauchy ---------------------------------

# Specify three random seeds
seeds <- c(0924201601, 0924201602, 0924201603)

iters = 10000  # Specify number of iterations
N = 100        # Specify sample size

cauchyMeans <- NULL  # Create empty vector to store sample means
cauchyVars <- NULL   # Create empty vector to store sample variances
dFinal <- NULL       # Create empty dataframe to store output

for (s in seeds) {
  set.seed(s)
  for (i in 1:iters) { 
    sample1 <- rnorm(n = 100)
    sample2 <- rnorm(n = 100)
    cauchySample <- (sample1 / sample2)               
    cauchyMeans <- c(cauchyMeans, mean(cauchySample))  # Append mean
    cauchyVars <- c(cauchyVars, var(cauchySample))     # Append variance
  }
  
  # Append row to dataframe with mean and variance for each seed
  dFinal <- rbind(dFinal, data.frame(Seed = s, Mean = mean(cauchyMeans), Variance = mean(cauchyVars)))
  cat("Finished seed: ", s, "\n")  # Print progress to console
}

dFinal  # Print final dataframe to console


