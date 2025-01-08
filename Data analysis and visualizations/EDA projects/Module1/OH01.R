
#####################################
# CS 544 Office Hours Week 1
#####################################

# rm(list=ls())  # clear all objects in the global environment
# cat("\014")    # clear the console

### Install R/RStudio
### Download R from: CRAN: https://cran.r-project.org/
### Download RStudio from: https://www.rstudio.com/products/rstudio/download/

  


# Assignment and coding hints:
# - Build up to your final answer in baby steps interactively, then just one line of code for final answer.
# - Most of the questions have earlier parts that build you up and you can use for the later parts.
# - Try not to reinvent the wheel.  If you have a task in R, chances are that somebody else has wanted to do 
#   the same task so there is probably a function that does exactly what you want to do.  You job is to find 
#   that function and figure out how to use it.
# - In general, R is a very flexible language so there are lots of different ways to accomplish the same task.
#   Obviously, if your homework assignment says to specifically use a certain function or do something in a 
#   particular way, then you must do it that way, but otherwise you have flexibility for how to do things.





### Some basic intro/refrech on data types in R

# Scalar (single number)
test = 27
test

# A scalar is really a 1x1 vector in the Linear/Matrix Algebra sense where 1x1 means (rows, columns)
test = c(27) # the c() is not need here since only a scalar.
test


# Vectors - 1-dimensional array.  Vectors are really *column* vectors in R when you operate on them but
# for convenience and display purposes in your console window, they will often *appear* as row vectors
# just to save some display space.
# Vectors can hold data elements of the same basic type. Only numbers, or only characters can be placed 
# inside a vector c() for "concatenate (stick together)"
nVector  <- c(3, 2, 6, 4, 5, 1, 7, 0, 8)   # Numeric
nVector

as.data.frame(nVector)


# Some EXTREMELY useful functions when debugging to make sure you know what type
# of object you have, only then can you figure out how to manipulate that object.
class(nVector)    
typeof(nVector)
length(nVector)
str(nVector)
dim(nVector)  # Why doesn't work  -->  ?dim


cVector <- c("a", "b", "monday")   # Charactor
cVector
class(cVector)    
typeof(cVector)


lVector = c(TRUE, FALSE, TRUE)   # Logical
lVector
typeof(lVector)
class(lVector)

# Notice that logical vectors can represented as 0=FALSE and 1=TRUE
as.numeric(lVector)


# Just like it is good practice to use fully named arguments, it is also good practice to use the
# fully Reserved Key Words TRUE and FALSE, not T and F.  Here is why, T could be a variable that
# you might have forgotten...  Notice how F comes back as 0, but T comes back as 7.
T = 7
test = c(T, F, T)
test



# Reserved Key Words cannot be overwritten, NA is the same
# TRUE = 27
# NA = 27


# Having a missing value of NA in a vector does not change the type of the vector since R
# knows how to treat NA within each data type
test = c(TRUE, FALSE, TRUE, NA)
test
typeof(test)


test = c("Todd", "Angele", "Chris", NA) 
test
typeof(test)


test = c(1, 2, 3, NA)
test
typeof(test)


typeof(NA)
typeof(TRUE)



# Be careful of NA values though and the effect that they may have on your results.
mean(x = test)
mean(x = test, na.rm = TRUE)





qVector  <- c("a", 2, 23, TRUE, NA)   # What do you think this returns?  Notice the double quotes on everything.  
qVector
class(qVector)    
typeof(qVector)

# Cannot mix and match data types in the same vector.  R will default to a hierarchy of types in that case 
# and the output type is determined from the highest type of the components in the hierarchy 
# NULL < raw < logical < integer < double < complex < character < list < expression. 




### Vector subsetting or selecting elements
# To subset or select elements of a vector, you can use the square brackets or subset operator [...]
first <- nVector[1]  
first

firstAndthird <- nVector[ c(1, 3) ]
firstAndthird

firstTothird <- nVector[ 1:3 ] # shortcut syntax for seq()
firstTothird

firstTothird <- nVector[ seq(from = 1, to = 3, by = 1) ]
firstTothird




# Look at 1st and last values w/o hard coding - use length(data) to be flexible
# Build up your answer in steps (but only show the final one-liner in your homework, no scratchwork).
nVector[1]
length(nVector)
c(1, length(nVector))
nVector[ c(1, length(nVector)) ]

firstLast <- nVector[ c(1, length(nVector)) ]
firstLast
nVector # double check


### Matrix - 2-dimensional data elements
# data elements must be of the same basic type (same as vector) and the same length.
nVector # refresh out memory

n1.matrix <- matrix(data = nVector, nrow = 3, ncol = 3)  # 3x3 matrix filling matrix by col
n1.matrix

# byrow = FALSE is the default so this is the same
n1.matrix <- matrix(data = nVector, nrow = 3, ncol = 3, byrow = FALSE)  # 3x3 matrix filling matrix by col
n1.matrix

n2.matrix <- matrix(data = nVector, nrow = 3, ncol = 3, byrow = TRUE)   # 3x3 matrix filling matrix by row
n2.matrix 


# Subsetting a matrix is always matrix.name[ row(s), column(s) ] using "matrix notation" from 
# Matrix Algebra or Linear Algebra.  (BTW, R is built to do Matrix/Linear Algebra at its core.)
n1.matrix[1, 2]      # element at 1st row, 2nd column 

n1.matrix[2, ]       # the entire 2nd row, a blank is shorthand for all elements. 

n1.matrix[ , 3]       # the entire 3rd column, a blank is shorthand for all elements. 

# n1.matrix has 3 cols. Want to slice (subset) to 1st and last cols
n1.matrix[ , c(1, ncol(n1.matrix)) ]   # 1st and last columns of the matrix - Hard coding would be c(1,3)
subset(x = n1.matrix, select = c(1, ncol(n1.matrix)))   # this does the same thing


n1.matrix[ , -2 ]   # use negative indexing to "drop" a column



# df can actually mix different types of *vectors*, but *within* each vector, the type has to be same *and*
# the length (number of elements) of the vectors must be identical:
df = data.frame(nVector[1:7], c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE), c("A", "B", "C", "D", "E", "F", "G"))
df

# Notice the naming of the vectors above is very ugly, so name your vectors in the data.frame
df = data.frame(var1 = nVector[1:7], logical = c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE), alphabet = c("A", "B", "C", "D", "E", "F", "G"))
df


# Number of elements using length()
length(c("A", "B", "C", "D", "E", "F", "G"))
length(c("A", "B", "C", "D", "E", "F", NA))
length(c("A", "B", "C", "D", "E", "F", NULL))

length(c("A", "B", "C", "D", "E", "F", NULL))




# That is all hard to read as one long line of code in R.  Might be better coding practice for readability
# to build up things in steps for clarity
var1 = nVector[1:7]
logical = c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE)
alphabet = c("A", "B", "C", "D", "E", "F", "G")
# LETTERS[1:7]   letters[1:7]  Pretty much anything you want to do in R has already been done... :)
df = data.frame(var1, logical, alphabet)
df



# List objects are very generalized objects in R and you can think of a list as a bucket that can hold
# many different types of other objects inside of it, in particular objects of different dimensions can be stored
# as different list elements, but they do not have to be different objects or different dimensions.
My.list = list(df, n1.matrix, 27)
My.list

length(My.list)


# Return an element from the list, and that result is a list object itself and the contents of that
# object is a 3x7 matrix
My.list[ 2 ]

# Returns the contents directly, i.e. a 3x3 matrix
My.list[[ 2 ]]


typeof(My.list[ 2 ])
typeof(My.list[[ 2 ]])
is.matrix(My.list[[ 2 ]])
class(My.list[[ 2 ]])



# Access the 2nd and 3rd elements of the list using indexing
My.list[ 2:3 ]


# Get the number 1 from the matrix by building up the subsetting. Get the "contents" of the 
# 2nd element in the list using double square brackets first, to get the "contents", i.e. the matrix
# itself.  Then subset that result with another single square brackets subset
# operator to get the element in the 3rd row, 2nd column
My.list[[ 2 ]]
My.list[[ 2 ]][3, 2]

# Similarly, get the contents of the data.frame in the first element.  Then subset that result to get just
# the third column (notice the "blank comma 3" means all rows for the blank and then 3rd column).  Then
# subset that vector to get just the first 3 elements.
My.list[ 1 ]
My.list[[ 1 ]]
My.list[[ 1 ]][ , 3]
My.list[[ 1 ]][ , 3][1:3]


names(My.list) = c("Heather", "Chris", "David")
My.list

# Now we can call those list elements by names using the $ sign operator.
My.list$Heather[ , 3][1:3]
My.list[[1]][ , 3][1:3]

unlist(x = My.list)






### Mean & comparison operator (nVector  <- c(3,2,6,4,5,1,7,0,8))
# Build up things in baby steps
nVectorMean <- mean(nVector)
nVectorMean

# Element less than 4
lowNum <- nVector < 4   # Returns as boolean (TRUE/FALSE)
lowNum

lowNum <- (nVector < 4) # Same, might just be easier to read this code
lowNum

nVector[ lowNum ]   # To get the actual values instead of boolean

lowNum <- which(nVector < 4)   # which() function returns 'position' numbers of the elements (not actual values)
lowNum

nVector[which(nVector < 4)]  # actual values using subsetting




### Some functions you might use in Assignment 1 or the Quiz
# Help files are avilable in R - here are a couple of different ways to call help files:
# help(function name) or ?function name
# help.search('some keyword')  search the help files for a word/phrase
# help(package = 'package name')
# ?function.name

### rep() function -  repeating (replicate) a vector  - HW 1e
 
rep(x = 1:3, times = 5) # suppose you want 5 sets of 1 through 3

rep(x = 1:3, each = 5) # repeat every value by specifying the argument each. 5 of each 

rep(x = 1:3, length.out = 5)  # tell R how long you want it to be. R will repeat the vector until it reaches that length.  5 numbers total

rep(x = 1:3, length.out = 11)  # tell R how long you want it to be. R will repeat the vector until it reaches that length.  11 numbers total






### Hint for Quiz
# If you find yourself copying and pasting code to acheive a task, that is a red flag that there is some function that you
# need to find that will do it for you.  Everything you want to do has probably already be written as a function by somebody else.
# And always remember that there are many ways or functions to acheive the same result.
n1.matrix   

#Suppose you want get the total of each row in the n1.matrix.  How could you do that?

# You could do that by brute force subsetting and copy and pasting:
sum(n1.matrix[ 1, ])   
sum(n1.matrix[ 2, ])
sum(n1.matrix[ 3, ])


# You could loop over the rows and sum each row 
for (i in 1:nrow(n1.matrix)){
  print(sum(n1.matrix[ i, ]))
}


# In R you can "apply" functions to (data) objects like matrices or data.frames.  In particular, there is a function called apply()
# that is part of the "apply family of functions" such as sapply(), lapply(), apply(), tapply(), etc. that are extremely 
# important in R.
?apply
# applying a function to margins of an array or matrix. 
# MARGIN a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1 indicates rows, 2 indicates columns,

apply(X = n1.matrix, MARGIN = 1, FUN = sum)

# Can we do even better than that?  Simpler, more elegant using the power of R?
rowSums(x = n1.matrix)





# Some functions for checking/adding names to objects. Different objects (vector, matrix, data.frame, list, etc.)
# may (actually do) require slightly different approaches.
?names()
?dimnames()
?rownames()
?colnames()

# Some functions for checking the dimensions of objects.  Hint: use these to determine the dimension of
# objects dynamically, i.e. not hardcoded, since we know that dimensions are always positive in R
# and indexing begins at position 1 so you can use these functions, maybe along with some version of
# sequences and paste() or paste0() help you name columns and rows or find position numbers.
?length()
?dim()
?nrow()
?ncol()


# Hints: you don't have to do this all in one line, you can build up the solution in 2-3 lines for example.
# Use the functions above to find the dimensions of the object dynamically.
# Use the subsetting operator, i.e. square brackets [...].
# Double check your result, you can see if you got the correct positions.

nVector[ c(1, length(nVector))] 
length(nVector)

test = c(nVector, 10)

length(test)/2 # Finding a middle # - even




# Factors
# Factors are a special way of handling categorical variables in R that help R speed up operations on
#    strings of character variables in particular by finding the unique strings, coding them as numeric internally,
#    but allowing the them to display as character strings on the surface.
# Factors may be "nominal" such as race/ethnicity or gender where there is no inherent ordering.
# Factors may be "ordinal" such as low/medium/high risk.

race.vec = c("White",  "Black", "Black", "Asian", "Hispanic", "Asian", "White", "Hispanic")
levels(race.vec) # Null
race.fac = factor(race.vec)
levels(race.fac)  # Notice that they get sorted alphabetically by default and the first one, Asian in this case,
                  # is the reference level. This is important for things later on like logistic regression where
                  # you want to compare relative risk to a baseline or reference group.

# You can force the reference level when you intially factor() the data by using the levels argument where the
# levels must match the character strings that are in the actual data.
race.fac2 = factor(x = race.vec, levels = c("White", "Black", "Asian", "Hispanic"))
levels(race.fac2)

# You can also change how the levels display using the labels argument, but note that the labels must be specified 
# in the same order as the labels or else it can cause very confusing problems that are hard to track down.
race.fac3 = factor(race.vec, levels = c("White", "Black", "Asian", "Hispanic"), 
                   labels = c("1: White", "2: Black", "3: Asian", "4: Hispanic"))
levels(race.fac3)

# You can change the reference level using the relevel() function with the ref argument.
race.fac4 = relevel(x = race.fac3, ref = "2: Black")
levels(race.fac4)


# Ordered Factors allow you to do logical operations directly on the character string values by ranking them 
# internally but displaying them as usual character strings.
skills <- c("advanced", "novice", "novice", "intermediate", "advanced")
skills

o1 <- ordered(skills)
o1

o1 <- factor(skills, ordered = TRUE)
o1
levels(o1)

is.factor(o1)
is.ordered(o1)

o2 <- ordered(skills, 
              levels=c("novice", "intermediate", "advanced"))
o2
levels(o2)

o2
o2[1] > o2[2] # i.e element 1 which is advanced > element 2 which is novice.
o2[1] < o2[4] # i.e element 1 which is advanced !< element 2 which is intermediate.
sort(o2)
sort(o2, decreasing = TRUE)


