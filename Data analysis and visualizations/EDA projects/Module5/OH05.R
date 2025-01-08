
#****************************************
#                                       #
#             OH - Week 5               #
#                                       #
#****************************************

# rm(list=ls())  # clear all objects
# cat("\014") # clear the console

library(sampling)

#//////////////////////////////////////////////////////////////////////////////////////
# PLEASE READ
#
# * Pls use set.seed() whenever you use random number generator, otherwise we cannot 
#   reproduce and verify your same results.
#//////////////////////////////////////////////////////////////////////////////////////


#//////////
#   CLT   #
#//////////
# One of the most important punchlines of the CLT is that for *any* distribution of *raw* data, even if the 
# *raw* data itself is not Normal, the distribution of the sample average xbar *becomes* more Normal as the
# sample size increases.

# Beta Distribution 
# Clearly this is not Normal: this particular Beta distribution is U-shaped (unlike Normal bell-shape)
# and the values are continuous between [0,1] (unlike Normal (-Inf, Inf))
set.seed(1234)
B = 10000
raw = rbeta(n = B, shape1 = 1/2, shape2 = 1/2)
hist(x = raw, breaks = 100, main = "Random Betas", freq = FALSE, xlim = c(0,1), ylim = c(0, 10),
     col=rgb(1,0,0,0.5), xlab = "x")

# Tiny detail, but even though we plotted freq=FALSE, i.e. we plotted the densities/probabilities,
# we get densities > 1 which does not make sense and is due to numerical precision because the Beta PDF
# goes to infinity as x approaches 0 from the right and also as x approaches 1 from the left.
# Just look at the general shape for the big picture.


# Notice that even with a sample size of only 3, the average starts to look a little bit more Normal in the blue.
set.seed(5678)
n = 3
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(0,0,1,0.5), add = TRUE)

# As the sample size increases to even just 15, without hitting the "magic number" of 30, it really starts to
# look Normal in the green.
set.seed(4321)
n = 15
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(0,1,0,0.5), add = TRUE)

# As the sample size increases to the "magic number" of 30, it really looks Normal in yellow.
set.seed(8765)
n = 30
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(1,1,0,0.5), add = TRUE)

# So the punchline is that as the sample size n increases, then the *shape* of the distribution of 
# the sample mean xbar becomes more Normal (symmetric and mound shaped, i.e. bell curve).  
# Recall that the distribution of xbar means all possible values of xbar (created from all possible unique sample
# combinations) and the probability of each sample.  When we take a large number of samples (not sample size),
# i.e. when we take B=10000 samples, we *approximate* all possible combinations.

# So for example, if you have a dataset of 1,000,000 observations, and you want to know the distribution of the sample mean xbar
# for the sample size n=30, then you need to enumerate (list out) every single possible combination of samples of size 30 that
# can be taken out of 1,000,000 observations, which is a huge number of combinations.  
# Instead, what we do is *approximate* the distribution xbar by
# take a sample of size 30, then calculate xbar
# take another sample of size 30, then calculate xbar
# take another sample of size 30, then calculate xbar
# take another sample of size 30, then calculate xbar
# ...
# take another sample of size 30, then calculate xbar
# take another sample of size 30, then calculate xbar
# take another sample of size 30, then calculate xbar
# repeat that process of sampling of size 30 then calculate xbar a total of say B=1000 or maybe B=100,000 times.   
# Now you should have B=1000 or B=100,000 values of xbar.  
# Plot that distribution of xbar as the approximate distribution of all possible combinations.
# Compute the mean of those values of xbar as your approximation for the population mean mu.




# Now let's take a look at the other punchline of the CLT that as the sample size increases, 
# the distribution of xbar becomes narrower, i.e. the standard deviation of xbar, SD[xbar] gets smaller.
# Why? Because SD[xbar] = SD[x]/sqrt(n) so as n increases, the denominator increases at the rate of sqrt(n) so
# SD[xbar] = SD[x]/sqrt(n) decreases.


# Look at the next 4 plots.  What's wrong with these??
# What happens when scales are not consistent?
# We cannot easily see one of the other most important punch lines of the CLT which is SD[xbar] = sigma/sqrt(n) 
# so the SD[xbar] gets *NARROWER* as n increases.

par(mfrow = c(2,2))
set.seed(1234)
B = 10000
raw = rnorm(n = B, mean = 100, sd = 5)
hist(x = raw, breaks = 50, main = "Raw Data", freq = FALSE, col=rgb(1,0,0,0.5), xlab = "x")

set.seed(5678)
n = 2
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(0,0,1,0.5), main = "Xbar n = 2")

set.seed(4321)
n = 5
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(0,0,1,0.5), main = "Xbar n = 5")

set.seed(8765)
n = 8
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, freq = FALSE, col=rgb(0,0,1,0.5), main = "Xbar n = 8")
par(mfrow = c(1,1))











# Notice the different scales on the x-axis.  R will naturally try to fit the histogram to available plot
# area and does so by changing the scales automatically.  Unfortunately, when things are on different scales
# interpretation becomes more difficult and people can be *tricked* with statistics and data.


# Now if we put them on the same scale, we show what is really going on - SD[xbar] gets *NARROWER*..
par(mfrow = c(2,2))
set.seed(1234)
B = 10000
raw = rnorm(n = B, mean = 100, sd = 5)
hist(x = raw, breaks = 50, main = "Random Normals", col=rgb(1,0,0,0.5), xlab = "x", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE)

set.seed(5678)
n = 2
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(0,0,1,0.5), main = "Xbar n = 2", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE)

set.seed(4321)
n = 5
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(0,0,1,0.5), main = "Xbar n = 5", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE)

set.seed(8765)
n = 8
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(0,0,1,0.5), main = "Xbar n = 8", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE)
par(mfrow = c(1,1))







# OR, like the first example with *shape*, we can plot them on top of each other and notice the *narrowing*.
set.seed(1234)
B = 10000
raw = rnorm(n = B, mean = 100, sd = 5)
hist(x = raw, breaks = 50, main = "Random Normals", col=rgb(1,0,0,0.5), xlab = "x", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE)

set.seed(5678)
n = 2
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(0,0,1,0.5), main = "Xbar n = 2", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE, add = TRUE)

set.seed(4321)
n = 5
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(0,0,1,0.5), main = "Xbar n = 5", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE, add = TRUE)

set.seed(8765)
n = 8
xbar = rowMeans(matrix(data = sample(x = raw, size = n*B, replace = TRUE), nrow = B, ncol = n))
hist(x = xbar, breaks = 50, col=rgb(1,1,0,0.5), main = "Xbar n = 8", 
     xlim = c(80,120), ylim = c(0,0.25), freq = FALSE, add = TRUE)

# Notice that the original data is Normal to begin with, so the distributions of the sample means xbar
# are exactly Normal by a Theorem.  Compare this to the Exponentials that become approximately Normal.







# Q: Difference between frequency counts vs. probabilities/densities?
# A: The shape of the distribution is the same, just the scale is different.  In most cases, you will want to use probs/densities
set.seed(1234)
B = 10000
raw = rbeta(n = B, shape1 = 1/2, shape2 = 1/2)
par(mfrow=c(2,1))
hist(x = raw, breaks = 100, main = "Random Betas", freq = TRUE, xlim = c(0,1), ylim = c(0, 1000),
     col=rgb(1,0,0,0.5), xlab = "x")

hist(x = raw, breaks = 100, main = "Random Betas", freq = FALSE, xlim = c(0,1), ylim = c(0, 10),
     col=rgb(1,0,0,0.5), xlab = "x")
par(mfrow=c(1,1))





#///////////////////////
#   Sampling examples  #
#///////////////////////

# Simple Random Sample (SRS) is not just every single person (or object) is equally likely,
# it's that every sample set of size n is equally likely as every other sample set of the same size n.  

# Suppose you want to estimate average income for people living in New York City.  There are many different ways
# that you could get a sample of people to get your estimate for the average income.

# SRS just puts all the people in New York City into one bucket, then we simple random sample
# say n = 1000 people from the entire city.

# Stratified Random Sample.  We first break New York City into neighborhoods, say the 
# 5 Boroughs (Manhattan, Brooklyn, Bronx, Queens, Staten Island).  Then we go into each of the 5 strata,
# or Boroughs here, and do a SRS, most often a SRS with sizes in each strata (NY boroughs for example) that 
# are proportional to the size of that strata relative to the size of the whole so bigger strata get bigger sample sizes.
# So here we call the neighborhoods strata because we sample from all of them proportional to their size.

# Clustered Sampling would be randomly select a few, say 3 of the 5 clusters or 5 Boroughs, and then sample 
# within the those Boroughs or clusters that were selected.  If it is a One-stage cluster sample, then
# you measure all units in the selected clusters.  If it is a two-stage cluster sample, then you do a SRS within 
# the selected clusters.
# So here we call the neighborhoods clusters because we first choose a few of the neighborhoods (clusters) and then
# we sample from the clusters we just selected.

# So strata and clusters very similar but easily confused, but we just want to use a different word.  Just groups.




# Unequal inclusion probalities
# Load a sample dataset
# This data provides information about the Belgian population of July 1, 2004 
# compared to that of July 1, 2003, and some financial information about the 
# municipality incomes at the end of 2001.
?belgianmunicipalities
data(belgianmunicipalities)
head(belgianmunicipalities)

# Computation of the inclusion probabilities proportional to the number 
# of inhabitants in each municipality of the Belgian database.
data(belgianmunicipalities)

# Inclusion based on Tot04 = total population on July 1, 2004.
pik = inclusionprobabilities(belgianmunicipalities$Tot04, 200)
length(pik)

head(pik)

# Check that the sum of the inclusion probabilities is equal to the sample size
sum(pik)

# You have inclusion probabilities, now use the probabilities to get the sample rows.
# Extracts the observed data from a data frame. The function is used after a sample has been drawn.
# Notice that this returns a sample or subset of data from which you can now compute things.
s <- UPsystematic(pik)

sample.data = belgianmunicipalities[ s != 0, ]



#====================================
#   Hints for homework assignment   #
#====================================


# Parts 1) and 2) are similar to the examples of CLT above or you can use the code from the Module, 
# just need to change the input raw data.



# Part 3)
# The functions from the sampling package such as srswor() and UPsystematic() create vectors of 0's and 1's, i.e.
# a logical vector where 0=FALSE and 1=TRUE that has the same number of elements as the number of rows in the dataset.  
# Use the resulting vector of 0's and 1's to subset the data using the subset operator square brackets, 
# i.e. [ rows, columns ].  The code from the module is very important here.




#====================================
#   Other interesting questions     #
#====================================

# Q: How does set.seed() work?
# A: It creates a "stream" of random numbers (usually between [0,1]) and then depending on the task or function,
#    it scales those values to something that you want to use like integers to subset rows for example.
?set.seed

# If I re-run this code *without* using set.seed(), who knows what I will get because we do not know the current
# starting value in the stream of random numbers, and if you run it without using set.seed() you will likely 
# (i.e. almost certainly) get different values from me because we are not using the same seed.
sample(x = 1:10, size = 3, replace = FALSE) # 2 4 5 was my result

# Now if I set (i.e. force) the seed, and run these two lines together, I get 9 4 7 and you should too
set.seed(0)
sample(x = 1:10, size = 3, replace = FALSE) # 9 4 7

# In fact, if I have not run any other random number generation and run the next line, I get 1 2 5 and you should too.
sample(x = 1:10, size = 3, replace = FALSE) # 1 2 5

# AND!!!, if I start over again and use the same set.seed(), I get the same results without having to run set.seed twice
# because the "steam" of random values picks up where it left off.
set.seed(0)
sample(x = 1:10, size = 3, replace = FALSE) # 9 4 7
sample(x = 1:10, size = 3, replace = FALSE) # 1 2 5

# If you are running things interactively, you may want to use set.seed() every time, but if you are running
# an entire script from top to bottom at one time, you only need to use set.seed() once at the very top,
# and all re-runs of the entire script should get all the same results every time (as long as you do not change the code).






###########################################
# Office hours scratchwork
###########################################



