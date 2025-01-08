#****************************************
#                                       #
#            OH - Week 4                #
#                                       #
#****************************************

# rm(list=ls())  # clear all objects
# cat("\014") # clear the console


# General Hints:
# Be very careful of including or not including points, P(X<=x) vs P(X<x) for example.
# Be very careful whether you need to include 0 (depending on the distribution).


# Student question about when to use which probability distribution.  
# It really comes down to a checklist.  You must check that problem satisfies the assumptions or conditions
# of each probability distribution to decide which distribution is appropriate.
# For better or worse, this part requires repetition and memorization.
# http://www.math.wm.edu/~leemis/2008amstat.pdf


# Notice here that these 4 distributions (there are lots of others) all involve exactly two outcomes, but with just
# one or two assumptions changed each time, we get a different distribution and different probabilities.


# Binomial interested in the *total* number of successes out of n trials
# Exactly two outcomes (success or failure, TRUE/FALSE, +/-, dead/alive, etc.)
# Know the probability of success (or failure) p
# Probability of success (or failure) p is the same for each trial (constant)
# Know the number of trials n ahead of time 
# Each trial must be independent of each other trial (with replacement and p constant)


# Hypergeomtric - similar to Binomial but sampling without replacement
# Exactly two outcomes (success or failure)
# Know the probability of success (or failure) p
# Probability of success (or failure) p is the same for each trial (constant)
# Know the number of trials n ahead of time 
# Sample without replacement (i.e. not independent = probabilties change)


# Geometric waiting time until the *first* success, how many trials do you have to do until you get the first success
# Exactly two outcomes (success or failure)
# Know the probability of success (or failure) p
# Probability of success (or failure) p is the same for each trial (constant)
# Number of trials could infinite, i.e. 0, 1, ..., inf
# Each trial must be independent of each other trial


# Negative Binomial waiting time until the *rth* success, how many trials do you have to do until you get the first success
# Exactly two outcomes (success or failure)
# Know the probability of success (or failure) p
# Probability of success (or failure) p is the same for each trial (constant)
# Number of trials could infinite, i.e. 0, 1, ..., inf
# Each trial must be independent of each other trial




#//////////////////////////////////////////////////////////////////////////////////////
#   BINOMIAL Distribution:                                                            #
#   Probability of obtaining one of two outcomes under a given number of parameters   #
#   Success/Fail question                                                             #
#//////////////////////////////////////////////////////////////////////////////////////


# EXAMPLE: Suppose Christiano Ronaldo scores 85% of penalty kicks on average.  Supposed you are watching him
# at a training session and you bet with your friend on how many he will score in the next 10 attempts.
# There are 10 attempts (n = 10) total and each penalty kick has (p = 0.85).
# Suppose you want to bet that he will make all 10 penalites.

# p(X = x) = (n choose x ) * p^x * (1-p)^(n-x)

# This is the theoretical distribution assuming p is constant.
dbinom(x = 10, size = 10, prob = 0.85)           # dbinom = pmf = height (exact x)
                                                 # Help File: lower.tail logical; if TRUE (default), probabilities are P[X ≤ x], 
                                                 # otherwise, P[X > x].

# Compare that to a random sample repeating that set of 10 penalty kicks 1000 times.
# Try this with and without using the same random seed.
set.seed(64)
rbinom(n = 1000, size = 10, prob = 0.85)


# Plot the entire distribution
pmf <- dbinom(x = 0:10, size = 10, prob = 0.85)
names(pmf) = 0:10
plot(0:10, pmf, type = "h", xaxt ='n',      # xaxt ='n' turns off the x-axis when we don't want the default tickmarks
     main = "PMF for Penalty Kicks", xlab = "Number of Goals", ylab = "PMF")
points(0:10, pmf, pch = 16)
axis(side = 1, at = 0:10, labels = TRUE)    # side = 1 below 
abline(h = 0)





# Plot the CDF
cdf = c(0, cumsum(x = pmf))         # cumulative sums
cdfplot = stepfun(0:10, cdf)        # Step Functions
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "CDF for Penalty Kicks", xlab = "Number of Goals", ylab = "CDF")

# Calculate the probability of getting exactly 8 goals.
dbinom(x = 8, size = 10, prob = 0.85)

# Calculate the probability of less than half or his goals.
pbinom(q = 4, size = 10, prob = 0.85) # Notice this is 4, i.e. strictly less than half, not including 5.
# OR
sum(dbinom(x = 0:4, size = 10, prob = 0.85))
sum(pmf[1:5]) # Notice this is 1:5 since want x=0:4, but are subsetting pmf *positions* 1:5. 
              # R starts indexing at 1, there is no such thing as position 0.

# Calculate the probability of getting between 2 and 6 correct (inclusive)
pbinom(q = 6, size =10, prob = 0.85) - pbinom(q = 1, size = 10, prob = 0.85)




#//////////////////////////////////////////////////////////////////////////
#   POISSON Distribution:                                                 #
#   Event “A” happens, on average, “x” times in the specific time frame   #
#//////////////////////////////////////////////////////////////////////////

# EXAMPLE: Suppose that on average 7 customers call your customer service help line during regular business hours (9am-5pm). 

# Calculate the pmf for the first 15 customers during that time.
pmf <- dpois(0:15, lambda=7)
names(pmf) = 0:15  # useful to name the probabilities like a "table"
pmf

plot(0:15,pmf,type="h",
     xlab="x",ylab="PMF", ylim = c(0, 0.15), main = "PMF for Calls per Day")
points(0:15, pmf, pch = 16)
axis(side = 1, at = c(0,5,10,15), labels = TRUE)
abline(h=0)

# What is the CDF?
cdf = c(0, cumsum(pmf))
cdfplot = stepfun(0:15, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "CDF for Calls per Day", xlab = "x", ylab = "CDF")


# What is the probability of having exactly 6 customers call in?
dpois(x = 6, lambda=7)

# What is the probability of serving at least 4 customers?
1-ppois(q = 3, lambda=7)

# OR
ppois(q = 3, lambda=7, lower.tail = FALSE) 
# Notice ppois(3 not 4, since lower.tail = FALSE), i.e. P(X>x) does not include 3, i.e. do include 4

# this is not entirely correct, so you shouldn't do this.
sum(pmf[5:16])  # Why?  Poisson is x = 0, 1, ... , Inf so 0:15 is just an estimate where most of the probability is located



#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   UNIFORM Distribution: 
#   The probabilities for all outcomes are the same.
#   There are Uniform Distributions for Discrete Random Variables and Continuous Random Variables.
#   
#   Discrete: rolling a die. There are a total of six sides of the die, and each side has the same probability of being rolled 
#   face up so this should be a barplot (discrete) with six bars that each have a height of 1/6.
#
#   Continuous: amount of time waiting for a bus.  Time is continuous so the probability distribution is rectangule with each height.
#   
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

# Problem: Let's say you are waiting for a bus at the bus stop. Your bus app says that the bus is expected to 
# arrive between 10 and 20 minutes (inclusive) from now.  Really says, is that PMF looks like a rectangle.

# Time is continuous, but let's first assume we are only counting whole minutes (i.e. from 10 to 20) so that we are using 
# a discrete distribution.

# Assuming a uniform distribution, what is the probability of the bus arriving in exactly 15 minutes?
1/11                                    # f(x) = 1 / (b-a+1) = 1 / (20-10+1)  
                                        # There is a +1 because there are 11 points from 10 to 20 including end points        

pmf = rep(x = 1/11, times = 11)
plot(10:20, pmf, type="h",
     xlab="x", ylab="PMF", ylim = c(0, 0.15), main = "PMF for Discrete Uniform Wait times")
points(10:20, pmf, pch = 16)
axis(side = 1, at = 10:20, labels = TRUE)
abline(h=0)


# Another method is to "trick" the R continuous uniform function into working for discrete uniform.
# Probability bus arrives in 15 minutes?  1/11 = 0.09091
# Probability bus arrives in 17 minutes?  1/11 = 0.09091
dunif(x = 15, min = 10, max = 21)      # max=21 to adjust for discrete
dunif(x = 17, min = 10, max = 21)      # max=21 to adjust for discrete

# What is the probability of the bus arriving in at most 18 minutes
9/11                                   # count 10 to 18 notice "at most" includes 18

# What is the probability of the bus arriving between 12 and 18 minutes (inclusive)?
7/11                                   # count 12 to 18


### Now let's assume a CONTINUOUS uniform distribution where can arrive in any fraction of a minute.

# Assuming a uniform distribution, what is the density of the bus arriving in exactly 15 minutes?
dunif(15, min = 10, max = 20)

# What is the probability of the bus arriving in at most 18 minutes
punif(18, min = 10, max = 20)


# What is the probability of the bus arriving between 12 and 18 minutes? 
punif(18, min = 10, max = 20)- punif(12, min = 10, max = 20)
# Notice for similar binomial problems we had to subtract pbinom(18)-pbinom(11), i.e. one less, but this is continuous uniform 

# Plot the pdf
x<-seq(8,22, by=.00001) # Notice rectangular shape and we show what happens outside the [10,20] interval, i.e. P(X=x)=0.
pdf<-dunif(x, min = 10, max = 20)
plot(x,pdf, type="l", col="red", main="PDF")

# Plot the cdf
x<-seq(8,22, by=.00001)
cdf<-punif(x, min = 10, max = 20)
plot(x,cdf, type="l", col="red", main="CDF")




#//////////////////////////////////////////////////////////////////////////////
#   NORMAL Distribution:                                                      #
#   CONTINUOUS, bell curve, symmetric, fully described by mean and variance   # 
#//////////////////////////////////////////////////////////////////////////////

# Continuous variable
# -Inf to +Inf
# Symmetric

# This is a random sample of data, not the theoretical distribution of all (infinite) possible values.
x = rnorm(n = 1000, mean = 10, sd = 2)
hist(x)



# Problem: Suppose the average starting salary for a data scientist is 150 (in thousands) 
# with a standard deviation of 20 (in thousands).

# Show the PDF of this distribution.
x <- 50:250
pdf <- dnorm(x = 50:250, mean = 150, sd = 20)
plot(x, pdf, type="l", col="red",
     xaxt="n", yaxt="n",
     main="Data Science Salaries", xlab="Salary", ylab="PDF")
axis(side = 1, at = seq(50, 250, by = 10),              # side=1: below.  Tickmarks from 50 to 200 by 10
     labels = TRUE)
axis(side = 2, at = c(0, 0.005, 0.01, 0.015, 0.02),     # side=2: left
     labels = TRUE)


# What is the probability a randomly selected person will receive a starting salary less than 120?
mu = 150
sigma = 20
pnorm(q = 120, mean = mu, sd = sigma)

# More than 120?
pnorm(q = 120, mean = mu, sd = sigma, lower.tail = FALSE)        # lower.tail=FALSE: area under the curve X>x
1- pnorm(q = 120, mean = mu, sd = sigma, lower.tail = TRUE)      # same result as above.  

# Between 100 and 120?
pnorm(q = 120, mean = mu, sd = sigma) - pnorm(100, mean = mu, sd = sigma)

# What is the top 5% of salaries?
qnorm(p = 0.95, mean = mu, sd = sigma)                          # we are looking at x (point on x-axis) based on area under the curve

# Simulate data from this distribution for 10000 people.
y <- rnorm(n = 10000, mean = mu, sd = sigma)

hist(y, breaks = 25, xaxt = "n")
axis(side = 1, at = seq(from = 50, to = 250, by = 10), labels = TRUE)



#//////////////////////////////////////////////////////
#   EXPONENTIAL Distribution:                         #
#   Amount of time until some specific event occurs   #
#//////////////////////////////////////////////////////

# Continuous variable
# 0 to +Inf
# Symmetric

# Problem: Suppose that I get 10 robocalls on average per day.

# What is the probability that I get the next robocall within 3 hours?
pexp(q = 3/24, rate = 10)

# How about between 3 and 5 hours?
pexp(q = 5/24, rate = 10) - pexp(q = 3/24, rate = 10)

# Plot the pdf
x<-seq(from = 0, to = 1, by=1/24)
pdf<-dexp(x, rate=10)
plot(x, pdf, type="l", col="red")

# plot the cdf
x<-seq(from = 0, to = 1, by=1/24)
cdf<-pexp(x, rate=10)
plot(x, cdf, type="l", col="red")




#/////////////////////////////////////////////////////////////////
#   Extra                                                        #
#   GEOMETRIC Distribution:                                      #
#   # of failures before success                                 #
#/////////////////////////////////////////////////////////////////

# f(x) = (1-p)^x * p      x = 0, 1, 2, 3, ...   pmf for geometric dist'n
# Think of slots that you want to fill with either failures or successes. 
# FFFFFS			# 6 slots here
# ------
# Waiting until the first event so you know the last slot is a success, so the first x slots are failures

# Suppose you are watching Christiano Ronaldo take penalty kicks in soccer.  Assume that Ronaldo makes on average
# 85% of his penaly kicks and that each penalty kick he takes is independent of the others (maybe over different weeks).

# i.e. X ~ Geometric(p = 0.85)

# Plot the probability distribution and the cumulative probability distribution.
pmf = dgeom(x = 0:6, prob = 0.85)      # x goes 0 to infinity but cutting to 0 to 6 b/c prob when x=6 is almost 0 - see next plot

plot(0:6, pmf, type = "h", xaxt = "n", ylim = c(0,1),
     main = "PMF of Geometric(p=0.85)", xlab = "x", ylab = "PMF")
points(0:6, pmf, pch = 16)
axis(side = 1, at = 0:6, labels = TRUE)
abline(h = 0)

cdf_1 = c(0, cumsum(pmf))       # add 0 to just make plot look correct - see next plot

cdfplot_1 = stepfun(0:6, cdf_1)
plot(cdfplot_1, verticals = FALSE, pch = 16, ylim = c(0,1), xaxt = "n", yaxt = "n",
     main = "CDF of Geometric(p=0.85)", xlab = "x", ylab = "CDF")
axis(side = 1, at = 0:6, labels = TRUE)
axis(side = 2, at = seq(from = 0, to = 1, by = 0.2), labels = seq(from = 0, to = 1, by = 0.2))


# Same questions but phrased differently:
# What is the probability that you watch Ronaldo miss 3 penalty kicks in a row and then make one?
# What is the probability that Ronaldo misses until the 4th penalty?
# What is the probability that you have to wait until the 4th penalty kick to see him make one?
# P(X = 3)

# Use Geometric Distn
dgeom(x = 3, prob = 0.85)

# Brute force
0.3^3 * 0.85     # use pdf directly f(x) = (1-p)^x * p



# What is the probability that Ronaldo misses no more than 2 penalty kicks before he makes one?
# What is the probability that you wait until at most the 3 penalty kick to see Ronaldo makes one?  (3rd one is success)
# P(X <= 2)
pgeom(q = 2, prob = 0.85)  # 2 failures, then a success


# What is the probability that Ronaldo misses less than 2 penalty kicks to see Ronaldo make one?
# What is the probability that you wait until 3 penalty kick to see Ronaldo make one?
# P(X < 2) = P(X <= 1)
pgeom(q = 1, prob = 0.85)  # less than 2 failures means do not include 2, i.e. at most 1 failure, then a success


# What is the probability that Ronaldo misses 2 or more penalty kicks before you see Ronaldo make one?
# P(X >= 2) = 1-P(X < 2) = 1-P(X <= 1)       using a compliment rule
1-pgeom(q = 1, prob = 0.85)
pgeom(q = 1, prob = 0.85, lower.tail = FALSE)      # P(X > x)  so P(X >= 2) = P(X > 1)
?pgeom                                             # if lower.tail=FALSE, P[X>x] which does not include 2, so need to force to include 2

# What is the probability that Ronaldo misses between 1 and 2 penalty kicks (inclusive) before you see Ronaldo make one?
# What is the probability that Ronaldo misses 1 or 2 penalty kicks before you see Ronaldo make one?
# P(1 <= X <= 2) = P(X <= 2) - P(X < 1) = P(X <= 2) - P(X = 0) 
pgeom(q = 2, prob = 0.85) - pgeom(q = 0, prob = 0.85) 




# END OF EXAMPLES


#///////////
#   QUIZ   #
#///////////

# Know which probability distribution to use to model different situations.
#   You need to ask what type of data do you have: discrete, continuous, more than one variable
#   Discrete: binary -> Binomial, Hypergeometric, Geometric,  Binomial, etc.
#                       For each of those, check a cheatsheet of conditions it must satistfy
#                           Independent or not, sampling with / without replacement, n known in advance or waiting time?, etc.
#             counts -> Uniform (discrete uniform), Poisson, etc.
#   Continuous: Normal (mean, sd)? (there are others like Gamma, Beta, etc. that we do not learn in this course) 
#               Uniform (min, max)
#
# Two main types of probability problems: 
# 1) Given x, calculate the probability
#    pbinom(), pnorm(), pexp(), etc. given x, find probability to the *left*, i.e. P(X <= x) = CDF (cumulative to the left)
#
# 2) Probability is given, find x.
#    qbinom(), qnorm(), qexp(), etc. given probability, find x that corresponds to that probability to the *left*, 
#    i.e. you want to find x so that P(X <= x) = p is true.  Drawing a picture really helps here.
#
# Notes:
#    dbinom(), dnorm(), dexp(), etc. give you the height of the distribution at the point x.
#    For a discrete random variable, height = probability and is called the probability mass function PMF.
#    For a continuous random variable, height != probability because the area under one single point in a 
#          continuous distribution of an infinite number of points is zero. 
#          This is called the probability density function PDF.
#
#    rbinom(), rnorm(), rexp(), etc. give you random samples from the distribution.



# There usually 3 steps in probability problems: 
# 1) Get the problem in plain English words
# 2) Translate the problem to a mathematical formula
# 3) Get (sometimes "trick") the R function to calculate the value that you want always being very careful to
#    Check whether you want to include or exclude specific points for ***discrete*** random variables (See Events/Complements below).

# Plain English                                  Math           R Function calculates
# Prob that X less than x=3                  =   P(X < 3)       = P(X <= 2)   (using default is P(X<=x) i.e. lower.tail=TRUE)
# Prob that X greater than 7                 =   P(X > 7)       = P(X > 7, lower.tail = FALSE)
#                                            =   1-P(X <= 7)    = 1-P(X <= 7) 
# Prob that X less than or equal to 3        =   P(X <= 3)      = P(X <= 3)
# Prob that X greater than or equal to 7     =   P(X >= 7)      = P(X > 6, lower.tail = FALSE)
#                                            =   1-P(X < 7)     = 1-P(X <= 6)


# Event/Prob   Complement
# ---------------------------
# A            A^c
# A^c          (A^c)^c = A

# <=           >
# >=           <
# <            >=
# >            <=

# P(X <= x)    1-P(X > x)
# P(X >= x)    1-P(X < x)
# P(X <  x)    1-P(X >= x)
# P(X >  x)    1-P(X <= x)



# Cheatsheet for plots
# barchart() is for categorical/groups data like race (not continuous) you want to plot the count or the proportion in each group
# hist() is for continuous data like BMI, weight, height, income 
# boxplot() is for continuous data like BMI, weight, height, income similar to hist() but summarizes the data with the 5 number summary
# scatterplot plot(x, y) for 2 continuous variables pairs of data (x,y) like (income, weight)
# mosaicplot() for 2 categorical variables like say race and gender gives you the joint distribution at same time (count / proportion)
# side-by-side barplot() for two categorical like race and gender
# side-by-side boxplot() for one continous variable like BMI, but grouped by a categorical variable like race




# Scratchwork from office hours

