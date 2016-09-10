# Purpose: Lab Week 2 Wednesday, Introduction to R, Exercise 2 Practice
# Date: 9/14/2016
# Instructor: Julian Wills
# Author: JAW 9.9.16


# Install Packages and Initialize Functions --------------------------------------------------------

# Let's first install ggplot2 for better plots. This should take ~15 seconds. 
require(ggplot2) || {install.packages("ggplot2", repos="http://cran.us.r-project.org"); require(ggplot2)}

# If you are on the quant lab computer, you must run all these lines of codes to install dplyr. 
require(DBI) || {install.packages("DBI", repos="http://cran.us.r-project.org"); require(DBI)}
require(assertthat) || {install.packages("assertthat", repos="http://cran.us.r-project.org"); require(assertthat)}
require(R6) || {install.packages("R6", repos="http://cran.us.r-project.org"); require(R6)}
require(tibble) || {install.packages("tibble", repos="http://cran.us.r-project.org"); require(tibble)}
utils::install.packages("/Users/quant/Downloads/dplyr_0.5.0.zip", repos=NULL)
library(dplyr)

# NOTE: If you are working from a personal computer, you should be able to just run this line of code instead:
# require(dplyr) || {install.packages("dplyr", repos="http://cran.us.r-project.org"); require(dplyr)}


#  We call this function 'mode2' because 'mode' already refers to a function in R. 
mode2 = function(x){
  
  # Author: Ethan Ludwin-Peery
  output = as.numeric(names(table(x)[table(x) == max(table(x))]))
  
  if (length(output) < length(x)) {
    return(output)
  } else {
    stop("No mode or all modes. All values occur equally often.")
  }
} 

# This function automatically creates bins for ggplot histograms so that it can emulate the base::hist() function. 
#  ^ By the way, the notation base::hist refers to the hist() function from the base package. This is a common 
#  notation for referring to functions since different packages will sometimes use the same function names.  
brx = function(x) {
  
  #From: http://stackoverflow.com/questions/25146544/r-emulate-the-default-behavior-of-hist-with-ggplot2-for-bin-width
  
  output = pretty(range(x), 
                  n = nclass.Sturges(x),min.n = 1)
  return(output)
  
}

# This shortcut is from the ggplot2 documentation. When you run it, it basically sets the default ggplot theme to 'light'. 
#  I also increase the base size from 12 to ~16 since my PC often generates smaller font sizes on plots for some reason. 
#  You should tweak these settings to your liking (or just not run it in the first place if it makes things worse.)
old <- theme_set(theme_light(base_size = 16)) 

# The default theme is 'gray' which you can always revert to with the code below. I just prefer theme_light because it 
#  accentuates grey histograms more. 

# old <- theme_set(theme_gray(base_size = 12))  # This manually resets it. 
# rm(old)  # Or you just can clear the 'old' object to go back to the ggplot default. 

# Importing Data ----------------------------------------------------------

# First thing you want to do is make sure you set your working directory to whichever folder has the data for exercise 2.
#  The code below references my own path but you will want to change it to your local path. 
setwd("/Users/quant/Downloads/")
# setwd("/Users/Julian/GDrive/Misc/Classes/InterStats/Lab02M/")  # This is my local path.

# You can always check your working directory by running the 'getwd()' function. Check now to make sure you're in the right path. 
getwd()

# Now that we've told R which directory to look for files, let's import the .csv file with the CESD scores. 
#  We're going to use the 'read.csv' function with two arguments: (1) the .csv filename and (2) header = TRUE.
#  The header argument tells R that the first line refers to the names of the variable (rather than importing it as the first
#  line of data.)
CESD_data <- read.csv(file = "Ex2_Lab_data.csv", header=TRUE)

# Compute Descriptive Statistics ------------------------------------------

# Now we are going to use the same functions from the previous lab script to compute descriptive statistics. 
#  Better yet, we don't have to calculate these manually this time around. 
#  Let's start with the mean...

CESD_mean <- mean(CESD_data$CESD)
cat("The mean of the sample is: ", CESD_mean)

CESD_median <- median(CESD_data$CESD)
cat("The median of the sample is: ", CESD_median)

CESD_mode <- mode2(CESD_data$CESD)
cat("The mode(s) of the sample is/are: ", CESD_mode)

CESD_var <- var(CESD_data$CESD)
cat("The sample variance is: ", CESD_var)

CESD_sd <- sd(CESD_data$CESD)
cat("The sample standard deviation is: ", CESD_var)

# You can also skip the intermediate steps if you prefer. The code below yields identical output to the code above. 

cat("The mean of the sample is: ", mean(CESD_data$CESD))
cat("The median of the sample is: ", median(CESD_data$CESD))
cat("The mode(s) of the sample is/are: ",  mode2(CESD_data$CESD))
cat("The sample variance is: ", var(CESD_data$CESD))
cat("The sample SD is: ", sd(CESD_data$CESD))


# Display Distribution ----------------------------------------------------

# In this lab we are going to use histograms to visualize our distributions. 
#  R comes preloaded with a hist() function for plotting histograms. 
hist(CESD_data$CESD)

# However, we are going to use this opportunity to begin learning ggplot2 which provides a popular alternative. 
#  Every ggplot object begins with the function ggplot(data, ...). This notation indicates that the first 
#  argument supplied to the ggplot function is almost always a dataframe object. The ellipsis (...) is a standin for 
#  other arguments that could hypothetically be passed to the ggplot function. Often the next argument is where
#  we map 'aesthetics' using the 'aes()' function. The idea here is that we are mapping variables in our dataframe
#  to various features of the plot we are trying to create. This is easy for histograms since we only need to supply 
#  a variable for the x-axis. So in this case, we supply 'CESD_data' as our dataframe and 'CESD' as our x variable. 
#  When we run this, we see the beginning of our ggplot canvas. Go ahead and run it now. 
ggplot(CESD_data)  # Blank canvas
ggplot(CESD_data, aes(x = CESD))  # Blank canvas with x axis variable specified 

# For those of you who have used photoshop you may already have an intuition for what comes next. We are going to 
#  add different 'layers' to our ggplot. Let's start by adding the histogram layer without any arguments. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram()

# Notice the warning message printed in the console. Since we did not specify the number of bins in our histogram
#  it defaulted to 30 bins. We only have 20 observations in our dataframe though, so let's try something smaller
#  and see what happens. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(bins=10)

# Now we're going to try using that 'brx()' function we initialized in the beginning of the script. Don't worry about 
#  how it works for now. Just know that it is designed to emulate the output of the base R hist() function. 
#  In addition, it takes a vector as an argument. In this case we can just supply 'CESD' since ggplot is smart enough
#  to infer that we really mean CESD_data$CESD. This is because we specified the 'CESD_data' dataframe in the beginning. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(breaks=brx(CESD_data$CESD))

# Now let's add some labels to this plot. Even though we know what it's saying, a naive reader could use more information. 
#  Use 'xlab', 'ylab', and 'ggtitle' to add labels to the x-axis, y-axis, and plot title respectively. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(breaks=brx(CESD_data$CESD)) + 
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") 

###
# NOTE: At this point, this is ALL you will need for your homework submission. The steps after this are just flourish. 
### 

# By default the size of the bars reflect counts (or frequencies) of the observations in each bin. We can change this to
#  reflect densities instead. This virtually communicates the same information, only that densities typically add up to 1.
#  Don't worry if this next bit of code isn't completely clear, we really only need it for something else coming up. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(aes(y = ..density..), breaks=brx(CESD_data$CESD)) +
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") 

# Now we are going to overlay a normal density curve on top of our (modified) histogram. This will give us a sense of whether 
#  our data is normally distributed. The code to generate this is very compicated given where we are (and I had to find it online),
#  so don't worry about trying to understand it at this point. 
#  Adapted from: http://stackoverflow.com/questions/5688082/ggplot2-overlay-histogram-with-density-curve
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(aes(y = ..density..), breaks=brx(CESD_data$CESD)) + 
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") +
  stat_function(fun=dnorm,
                color="red",
                size=1.2,
                linetype=3,
                aes(x = seq(5,50,(45/19))),
                args=list(mean=mean(CESD_data$CESD), 
                          sd=sd(CESD_data$CESD)))

# Personally I like seeing the boundaries of the different histogram bins. Let's recolor the ggplot elements to make it easier. 
#  By setting fill="grey" we are telling R to color the histograms bar a lighter shade of gray.
#  By setting color="black" we are telling R to color the boundaries of the histograms bars black.
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(aes(y = ..density..), fill="grey", color="black", breaks=brx(CESD_data$CESD)) + 
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") +
  stat_function(fun=dnorm,
                color="red",
                size=1.2,
                linetype=3,
                aes(x = seq(5,50,(45/19))),
                args=list(mean=mean(CESD_data$CESD), 
                          sd=sd(CESD_data$CESD)))

# Now let's add some dashed vertical lines to indicate the mean (blue) and median (green). 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(aes(y = ..density..), fill="grey", color="black", breaks=brx(CESD_data$CESD)) + 
  stat_function(fun=dnorm,
                color="red",
                size=1.2,
                linetype=3,
                aes(x = seq(5,50,(45/19))),
                args=list(mean=mean(CESD_data$CESD), 
                          sd=sd(CESD_data$CESD))) +
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") +
  geom_vline(aes(xintercept = mean(CESD)), color="blue", linetype="dashed", size=1) +
  geom_vline(aes(xintercept = median(CESD)), color="forestgreen", linetype=4, size=1.5)

# However, a reader might not be able to discern which line reflects the mean or median. Let's add a color coded
#  legend in the top right corner as well as rounded estimates of the mean, median, standard deviation, and sample size. 
ggplot(CESD_data, aes(x = CESD)) + 
  geom_histogram(aes(y = ..density..), fill="grey", color="black", breaks=brx(CESD_data$CESD)) + 
  stat_function(fun=dnorm,
                color="red",
                size=1.2,
                linetype=3,
                aes(x = seq(5,50,(45/19))),
                args=list(mean=mean(CESD_data$CESD), 
                          sd=sd(CESD_data$CESD))) +
  xlab("CESD Scores") + 
  ylab("Density") + 
  ggtitle("Distribution of 20 CESD Scores") +
  geom_vline(aes(xintercept = mean(CESD)), color="blue", linetype="dashed", size=1) +
  geom_vline(aes(xintercept = median(CESD)), color="forestgreen", linetype=4, size=1.5) +
  geom_text(aes(label = paste("Mean:", mean(CESD)), x= Inf,y=Inf), hjust=+1.5, vjust=+3, color="blue") +
  geom_text(aes(label = paste("Median:", median(CESD)), x= Inf,y=Inf), hjust=+1.85, vjust=+4.2, color="forestgreen") +
  geom_text(aes(label = paste("SD:", round(sd(CESD),2)), x= Inf,y=Inf), hjust=+1.62, vjust=+5.4) +
  geom_text(aes(label = paste("N:", length(CESD)), x= Inf,y=Inf), hjust=+2.76, vjust=+6.6)


# Last but not least, make sure to save your work. The 'ggsave()' function will save the last plot with the arguments you supply. 
ggsave(filename = "lab02_CESD_histogram.jpg", device="jpg")

# BONUS: You can also resize your images by indicates the width and height as extra arguments. 
ggsave(filename = "lab02_CESD_histogram_resized.jpg", device="jpg", width = 5, height = 5)


# Transformations ---------------------------------------------------------

# Now we are going to use the 'dplyr' package to compute transformations on our data. 
#  Specifically, we are going to use the 'mutate' function. 
#  Let's start by creating a new variable 'CESD_a' where we simply add 50 to each CESD score. 
mutate(CESD_data, CESD_a = CESD + 50)  

# Let's do a few more transformations to see what the effects are (if any) on the distributions. 
mutate(CESD_data, 
       CESD_a = CESD + 50,
       CESD_b = CESD * 10,
       CESD_c = (CESD - 90) / 2) 

# Now that we have a sense of how mutate works, let's save these transformations to a new dataframe object.
#  Let's use the "_T" suffix to remind ourselves that this new dataframe contains the transformed CESD scores. 
CESD_data_T <- CESD_data %>% 
  mutate(CESD_a = CESD + 50,
         CESD_b = CESD * 10,
         CESD_c = (CESD - 90) / 2)


# Descriptive Stats of Transformed Data -----------------------------------

# Let's start with the base function 'summary' to look at some descriptive statistics of our new variables. 
summary(CESD_data_T)

# We can use the 'summarize' function to calculate the mean and SD of each of these variables.
summarize(CESD_data_T, 
          CESD_mean = mean(CESD), CESD_SD = sd(CESD),
          CESD_a_mean = mean(CESD_a), CESD_a_SD = sd(CESD_a),
          CESD_b_mean = mean(CESD_b), CESD_b_SD = sd(CESD_b),
          CESD_c_mean = mean(CESD_c), CESD_c_SD = sd(CESD_c))

# NOTE: You should actually be able to calculate these by hand using what you know about expectation operators. 


# BONUS: If you find the code above a bit tedious, you can also use the 'summarize_all' function as a shortcut. 
#  We won't go over what these arguments mean but feel free to look them up in your own time '?summarize_all'
summarize_all(CESD_data_T, funs(mean, SD=sd))


# Visualize Transformed Data ----------------------------------------------

# Now let's see how the distributions look after making these transformations. 
#  Let's start with CESD_a (where we add 50 to each score).
ggplot(CESD_data_T, aes(x=CESD_a)) + 
  geom_histogram(fill="grey", color="black", breaks=brx(CESD_data_T$CESD_a)) + 
  xlab("CESD Scores") + 
  ylab("Frequency") + 
  ggtitle("Distribution of 20 CESD Scores \n after Adding 50 to Each Score")

# Now let's look at CESD_b (where we multiply each score by 10).
ggplot(CESD_data_T, aes(x=CESD_b)) + 
  geom_histogram(fill="grey", color="black", breaks=brx(CESD_data_T$CESD_b)) + 
  xlab("CESD Scores") + 
  ylab("Frequency") + 
  ggtitle("Distribution of 20 CESD Scores \n after Multiplying Each Score by 10")

# Now let's look at CESD_c (where we subtract 90 from each score then divide by 2).
ggplot(CESD_data_T, aes(x=CESD_c)) + 
  geom_histogram(fill="grey", color="black",
                 breaks= c(-42.5, -40, -37.5, -35, -32.5, -30, -27.5, -25, -22.5, -20)) +
  xlab("CESD Scores") + 
  ylab("Frequency") + 
  ggtitle("Distribution of 20 CESD Scores \n after Subtracting 90 and Dividing by 2")

# NOTE: If we use the brx() function for the CESD_c scores, the histogram looks different. This is because the function
#  only deals with whole numbers. But when we manually specify the 'breaks' of the bins we see a familiar histogram. 
#  In the homework, don't worry if your last histogram has fewer bins than you'd expect -- you won't be penalized.  
  

