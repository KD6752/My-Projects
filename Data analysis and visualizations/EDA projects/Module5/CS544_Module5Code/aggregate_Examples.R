
# tapply

# Given voter's data
# 
# ages <- c(25,26,55,37,21,42)
# 
# affils <- c("R","D","D","R","U","D")
# 
# show the average age of the voters for each affiliation.


ages <- c(25,26,55,37,21,42)
ages

affils <- c("R","D","D","R","U","D")
affils

tapply(ages, affils, mean)

barplot(tapply(ages, affils, mean), 
        col = c("blue", "red", "green"))

# Without tapply, you can do something like this

for (party in sort(unique(affils))) {
  cat(party, mean(ages[affils == party]), "\n")
}

# Using aggregate 

aggregate(ages, by=list(Party = affils), FUN="mean")


# Given the following data frame
# 
# df <- data.frame(
#   gender=c("M","M","F","M","F","F"),        
#   age=c(47,59,21,32,33,24),
#   income=c(55000,88000,32450,76500,123000,45650))
# 
# what is the average income by gender?


df <- data.frame( 
  gender=c("M","M","F","M","F","F"), 
  age=c(47,59,21,32,33,24),
  income=c(55000,88000,32450,76500,123000,45650))

df

# average income by gender using tapply
tapply(df$income, df$gender, mean)

# average income by gender using aggregate
aggregate(df$income, by = list(Sex = df$gender), FUN = mean)

# or
aggregate(income ~ gender, data = df, FUN = mean)

# For number of values in each group
tapply(df$income, df$gender, length)
aggregate(df$income, by = list(Sex = df$gender), FUN = length)
aggregate(income ~ gender, data = df, FUN = length)


# average age by gender using tapply
tapply(df$age, df$gender, mean)

# average age by gender using aggregate
aggregate(df$age, by = list(Sex = df$gender), FUN = mean)

# or
aggregate(age ~ gender, data = df, FUN = mean)


# For the above data, what is the average income for people 
# whose age is over 25 versus people whose age is 25 or below?

df$over25 <- ifelse(df$age > 25,TRUE,FALSE)
df

tapply(df$income, df$over25, mean)

# using aggregate
aggregate(df$income, by = list(Group = df$over25), FUN = mean)

aggregate(income ~ over25, data = df, FUN = mean)


# For the above data, explore the average income by 
# both the gender and over 25.

tapply(df$income,list(df$gender,df$over25),mean)


# Using aggregate

aggregate(df$income, by = list(Sex = df$gender, Group = df$over25), 
          FUN = mean)

aggregate(income ~ gender + over25, data = df, FUN = mean)

# Number of values in each group

tapply(df$income,list(df$gender,df$over25),length)

aggregate(income ~ gender + over25, data = df, FUN = length)



## 

View(mtcars)

colnames(mtcars)

mtcars[c(2,10)]

aggdata <-aggregate(mtcars, 
                    by=list(mtcars$cyl,mtcars$gear), 
                    FUN=mean, na.rm=TRUE)
aggdata

aggdata <-aggregate(mtcars[-c(2, 10)], 
                    by=list(Cylinders=mtcars$cyl, Gears=mtcars$gear), 
                    FUN=mean, na.rm=TRUE)
aggdata