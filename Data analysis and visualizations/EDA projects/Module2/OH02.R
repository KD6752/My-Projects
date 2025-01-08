#****************************************
#                                       #
#            OH - Week 2                #
#                                       #
#****************************************

# rm(list = ls())
# cat("\014")

# Setup instructions (Only Once)
# If prompted for Compile from sources, type no option

# install.packages("combinat") # Available on CRAN as of 2023/05/20
# install.packages("https://cran.r-project.org/src/contrib/Archive/prob/prob_0.9-2.tar.gz", repos = NULL, dependencies = TRUE) # Archived on CRAN

# After the above setup, do the following two steps
# The following two steps needs to be run everytime the functionality is needed

library(combinat)
library(prob)
Prob <- prob::prob


#=================================
#   PART 1) Bayes Rule Example   #
#=================================

# For my group only (check with your facilitator how they want it done), since you have to write code in R
# and do the Bayes problems by hand, it is perfectly fine for me to grade formulas typed out in R as comments.
# It would be fine to start with something like this as a template instead of doing things on paper and 
# scanning it in.

# A = some event description
# B = some other event description
# P(B | A)
#   = P(B intersect A) / P(A)
#   = P(A intersect B) / P(A)
#   = P(A|B)P(B) / [ P(A|B)P(B) + P(A|B^c)P(B^c) ]
#   = ##### / (#### + ###)



# Let A be the event that a person has lung cancer.
# The overall probability of having lung cancer is 7%, i.e. P(A) = 0.07.
# So the probability of not having lung cancer using the complement rule is P(~A) = 1 − P(A) = 0.93.

# Let B be the event that a person is a smoker.
# Suppose that among people with lung cancer, 90% are smokers, i.e P(B|A) = 0.90.  
# By complement rule, among people with lung cancer, 10% are not smokers, i.e 1-P(B|A) = P(~B|A) = 0.10.
# Suppose that among people without lung cancer, 25% are smokers, i.e. P(B|~A) = 0.25.
# By complement rule, among people without lung cancer, 75% are not smokers, i.e P(~B|~A) = 0.75.

# We want to know the probability that a randomly selected person who smokes will get lung cancer.

bayes <- function (prior, likelihood) {
  numerators <- prior * likelihood
  return (numerators / sum(numerators))   # The order here is ( P(A | B), P(~A | B) )
}


prior <- c(0.07, 0.93)                  # The order here is ( P(A), P(~A) )
likelihood <- c(0.90, 0.25)             # The order here is ( P(B | A), P(B | ~A) )

posterior = bayes(prior, likelihood)    # The order here is ( P(A | B), P(~A | B) )
posterior

# So our result is P(A | B) = 0.21
# and P(~A | B) = 0.79.

# What is this really saying?
# Notice that the probability that a smoker has cancer is P(A | B) = 0.21 and that this is *much* higher
# than the overall probability of getting lung cancer P(A) = 0.07, 3 times higher in fact.  You decide what this result suggests.




#===============================
#   PART 2) Random Variables   # 
#===============================

S <- rolldie(times = 2, makespace = TRUE)

# Prob sum of two dice is greater than 8
subset(x = S, subset = (X1 + X2 > 8))
Prob(x = S, event = (X1 + X2 > 8))

# Prob sum of two dice is greater than 8 given that the first die is even P(B | A)
# Naturally the given part comes first so let A = first die is even, i.e. (X1 %% 2 == 0)
# Then B = the sum of the two dice is greater than 8, i.e. (X1 + X2 > 8)
# We want P(B | A) = P( (X1 + X2 > 8) | (X1 %% 2 == 0) ) 
# So let's first subset to A.
# Then subset A to see the subset of B given A.

# Notice we subset S first to get A
A = subset(x = S, subset = (X1 %% 2 == 0))  
A

# Notice that we subset A further down to get B.
BintersectA = subset(x = A, subset = (X1 + X2 > 8))
BintersectA

# This is the same and could done directly, but would be a subset of S, not A.
BintersectA = subset(x = S, subset = (X1 + X2 > 8) & (X1 %% 2 == 0) )
BintersectA

# P(B|A) = P(B intersect A) / P(A)
# Notice that we go back to S here, B is the event, and A is the given.
Prob(x = S, event = (X1 + X2 > 8), given = (X1 %% 2 == 0))


# A student in office hours asked why this first one gives a different answer above
# Notice that these two are not the same.  The first is just the numerator in the conditional probability
# formula above, which does not divide by the denominator P(A).  In other words, this is the just the
# intersection.
Prob(x = S, ((X1 + X2 > 8) & (X1 %% 2 == 0)))

# Here if we continue to use the same intersection but divide by P(A) which we
# specifiy in the Prob() function as the "given" argument, then we get the same answer as above.

Prob(x = S, event = ((X1 + X2 > 8) & (X1 %% 2 == 0)), given = (X1 %% 2 == 0))

# But how can we get the same answer with brute force?  Notice that we have the subset A above and we have the
# subset BintersectA.  Now we can use those directly, each with a Prob() function call and get the same answer.
# P(B|A) = BintsectA / P(A)
Prob(x = BintersectA) / Prob(x = A)

# This is equivalent to this:
Prob(x = S, ((X1 + X2 > 8) & (X1 %% 2 == 0))) / Prob(x = S, event = (X1 %% 2 == 0))








#===============================
#   PART 3) Functions          # 
#===============================

# See tutorial_writing_functions.R








#===============================
#   PART 4) Dow data           # 
#===============================

dow <- read.csv('http://people.bu.edu/kalathur/datasets/DJI_2020.csv')

head(dow)
names(dow) # This returns only the column names
dimnames(dow) # This returns all the dimension names, i.e. row names and column names.
rownames(dow)
colnames(dow)

# Make up a vector of data and assign some names (letters) to it.
x = 1:20
names(x) = LETTERS[1:20]

names(x) # Works for vectors, but for data.frames, it returns column names.
dimnames(x) # Does not work for vectors since not multiple dimensions.

length(x) # Works for vectors.
dim(x) # Does not work for vectors since not multiple dimensions.

# This works for data.frames, but notice that it gives a strange result of 2.  Why is that?
# data.frames are secretly list objects where each column of the data.frame is an element in
# the list object.  Therefore, this data.frame has 2 columns, so it is a list with 2 elements, 
# so the length of dow is 2, i.e. a list of 2 columns.
length(dow) 









##############################################
# Scratchwork on the fly in office hours (some is old leftovers, but may be useful.)
##############################################



# rename columns
# Min Q1 Q2 Mean Q3 Max
sm = summary(dow$Close)
class(sm)
typeof(sm)
mode(sm)
dim(sm)

length(names(sm))

names(sm) = c("Min", "Q1", "Q2", "Mean", "Q3", "Max")



# use paste() or sprintf() to put output together
paste("This is ", names(sm)[c(2,3,4,5)], " which has value of", sm[ c(2,3,4,5) ])

as.vector(sprintf("This is %s which has value of %s", names(sm)[c(2,3,4,5)], sm[ c(2,3,4,5) ]))

paste0("This is ", names(sm)[c(2,3,4,5)], " which has value of ", sm[ c(2,3,4,5) ], sep="")

for(i in 2:5){
  print(paste0("This is ", names(sm)[ i ], " which has value of ", round(sm[ i ])))
}

sm

as.data.frame(1:5)



# question about list objects (can hold elements of different types and different dimensions)
as.list(7:11)

list(7:11, LETTERS, matrix(data = c(3,5,7,1), nrow = 2, ncol = 2, byrow = FALSE))
list(vec = 7:11, alphabet = LETTERS, matrix = matrix(data = c(3,5,7,1), nrow = 2, ncol = 2, byrow = FALSE),
     list = list(7:11, matrix(data = c(3,5,7,1), nrow = 2, ncol = 2, byrow = FALSE)))



# function example (need to store the results of a loop and return them from the function
# since functions and loops work on their own environments which is called scoping)
cumul_sum = 0
test_fun = function(n){
  for(i in 1:n){
    result = sum(1:n)
  } 
  return(result)
}

test_fun(4)




# questions about sequences, benefits of named arguments, and argument order
7:11
seq(from = 7, to = 11, by = 1)
seq(from = 7, to = 11)
seq(7, 11, 1)

seq(7, 11, 1)



seq(from = 7, to = 11, length.out = 10)
seq(7, 11, 10)
seq(7, 11, 10)



seq(from = 7, to = 11, length.out = 10)

seq(length.out = 10, to = 11, from = 7)

seq(10, 11, 7)


seq()

