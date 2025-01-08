#****************************************
#                                       #
#            OH - Week 3                #
#                                       #
#****************************************

# rm(list=ls())  # clear all objects
# cat("\014") # clear the console

library(UsingR)
library(tidyverse)   
library(lattice)



# Different graphic paradigms
# Base R functions like hist(), barplot()
# lattice package functions like histogram(), barchart(), 
# ggplot package (part of tidyverse) functions like ggplot() + geom_bar()


# In Base R, you must first create a new plot object, something like:
# plot(x,y)
# hist()
# barplot()

# Then you can use auxiliary functions to add to and customize an existing plot object, something like:
# abline()
# lines()
# points()
# text()
# legend()

# In ggplot(), you create plot objects and aesthetics with ggplot(..., aes()) and then you 
# add customization all in one step (usually) by added graphic elements with "+" signs, i.e. layers.


# Cheatsheet for plots
# barchart() is for categorical/groups data like race, gender, etc. (not continuous) you want to plot the count or the proportion in each group
# hist() is for continuous data like BMI, weight, height, income, etc. 
# boxplot() is for continuous data like BMI, weight, height, income similar to hist() but summarizes the data with a 5 number summary
# scatterplot plot(x, y) for 2 continuous variables pairs of data (x,y) like (income, weight)
# mosaicplot() for 2 categorical variables like race and gender gives you the joint distribution at same time (count / proportion)
# side-by-side barplot() for two categorical like race and gender
# side-by-side boxplot() for one continuous variable like BMI, but grouped by a categorical variable like race



#//////////////////////
#   Part 1            #
#//////////////////////

#//////////////////////
#   Categorial Data   #
#//////////////////////

help(central.park.cloud)       # Type of day in Central Park, NY May 2003
central.park.cloud             # Look at the data

table(central.park.cloud)      # use table() for frequency
# Hint: For the coins question, check the class of coin values to see if you can calculate the total value of each kind of coin
# Or you can use aggregate() as I talked about it in the slides 

table(central.park.cloud) / length(central.park.cloud)     # These are Ratios -  *100 for %

prop.table(x = table(central.park.cloud))



#////////////////////////////////////////////////////
#   Graphical Representations of Categorical Data   #
#////////////////////////////////////////////////////

barplot(table(central.park.cloud),           # barplot is for categorical data, histogram is for numerical data
        ylim = c(0,15),                      # set range y-axis. Important to have consistent scales when comparing graphs
        xlab = "Weather", 
        ylab = "Frequency", 
        main = "Type of day in Central Park, NY May 2003",
        col = "blue")                         # color palette (stat.columbia.edu/~tzheng/files/Rcolor.pdf)


# Adding legend
barplot(table(central.park.cloud), 
        ylim = c(0,15),
        xlab = "Weather", 
        ylab = "Frequency", 
        legend.text = TRUE,                                    # You can add arguments for legend inside the function
        args.legend = list(x="topleft"),
        main = "Type of day in Central Park, NY May 2003",
        col = "slategray1")

barplot(table(central.park.cloud), 
        ylim = c(0,15),
        xlab = "Weather", 
        ylab = "Frequency", 
        # legend.text = TRUE,                                    # You can also add using the legend() function
        # args.legend = list(x="topleft"),
        main = "Type of day in Central Park, NY May 2003",
        col = "slategray1")

legend("topleft",                                                # More control this way than adding arguments inside barplot()
       legend = c("clear", "partly cloudy", "coludy"), 
       fill = "slategray1", 
       cex = 0.75)


#### Similar plots in ggplot()

tibble(central.park.cloud) %>% 
  group_by(central.park.cloud) %>% 
  count(central.park.cloud) %>% 
  ggplot(., aes(x = central.park.cloud, y = n)) + 
    geom_bar(stat = 'identity', fill = "slategray1") + 
    theme_bw() + 
    ylab('Count') + 
    xlab("Cloud Type") + 
    ggtitle("Barplot of Cloud Types")

# Change bar colors by the type of cloud
as.data.frame(central.park.cloud) %>% group_by(central.park.cloud) %>% count(central.park.cloud)  %>% 
  ggplot(., aes(x = central.park.cloud, y = n, fill = central.park.cloud)) + geom_bar(stat = 'identity') + 
  theme_bw() + 
  ylab('Count') + xlab("Cloud Type") + ggtitle("Barplot of Cloud Types")




#//////////////////////
#   Part 2            #
#//////////////////////

# Side-by-side barplots (counts of 2 categorical variables) 

m = rbind( c(3,8), c(4,3), c(12,2) )
colnames(m) = c("Automatic", "Manual")
rownames(m) = paste0(c(4,6,8), " Cyl")
dimnames(m) = list(Cylinders = rownames(m), Transmission = colnames(m))

barplot(m, beside = TRUE, legend.text = TRUE)

# Similar plot in ggplot()
m %>% 
  data.frame() %>% 
  mutate(Cylinders = row.names(.)) %>% 
  select(Automatic, Manual, Cylinders) %>% 
  gather("Transmission", "Count", -Cylinders) %>%
  ggplot(., aes(x = Transmission, y = Count, fill = Cylinders)) + 
    geom_bar(stat = 'identity', position = position_dodge2()) +
    theme_bw()

# Side-by-side boxplots (continuous data grouped by a categorical variable)
# Create some fake data
set.seed(1234)
df.heights = data.frame(gender = rep(x = c("Male", "Female"), times = c(40, 60) ),  
                        height = c( rnorm(n = 40, mean = 68, sd = 3), rnorm(n = 60, mean = 63, sd = 2.5) ), 
                        weight = c( rnorm(n = 40, mean = 200, sd = 15), rnorm(n = 60, mean = 160, sd = 12) ))

boxplot(height ~ gender, data = df.heights)
boxplot(height ~ gender, data = df.heights, horizontal = TRUE)

df.heights %>%
  ggplot(., aes(x = gender, y = height)) + 
  geom_boxplot(position = position_dodge2())

# scatter plot
plot(x = df.heights$height, y = df.heights$weight)
plot(x = df.heights$height, y = df.heights$weight, xlab = "Height", ylab = "Weight", main = "Weight vs Height")

df.heights %>%
  ggplot(., aes(x = height, y = weight)) + geom_point()



#/////////////////////  
#   Numeric Data     #
#/////////////////////

# Make up some data
x <- c(71,72,73,73,74,75,77,81,83,87,91)
x

mean(x)
mean(x, trim=0.1)    # trim=: the fraction (0 to 0.5) of observations to be trimmed from each end of x before the mean is computed.
                     # trim=0.1 means get rid of bottom 10% and top 10%. Kind of a lazy way to get rid of outlier.
median(x)

# Mode = most frequently occurring number
table(x)                                    # mode = 73 since it appears twice
max(table(x))                               # The maximumu count is 2, the most freqent number appears only twice
which(table(x) == max(table(x)))            # If you run this, the output shows as:
# 73 
# 3                                         This 3 means '3rd index' (which is 73) not 73 shows up 3 times.
names(which(table(x) == max(table(x))))     # 73 is the mode (seems like there should be a built-in function...)

range(x)
diff(range(x)) # max - min

var(x)
sd(x)

fivenum(x)           # does not give mean
quantile(x, c(0, 0.25, 0.5, 0.75, 1))       # Same as Five Number Summary
summary(x)           # Five Number Summary and mean
IQR(x)       # Q3-Q1

# Manually calculate the lower and upper ends of the outlier ranges:
f <- fivenum(x)
f

c(f[2] - 1.5*(f[4] - f[2]),
  f[4] + 1.5*(f[4] - f[2]))
# How do we interpret this?


# Some built in functions to detect outliers:
# outlierTest() function from car package gives the most extreme observation based on the given model.
# outlier() and scores() functions from the outliers package. 







#////////////////////////
#   Titanic Data Set    #
#////////////////////////
Titanic
dimnames(Titanic)          # to look at dimention names (i.e. the margins)
                            # dimensions (margins) are Class, Sex, Age, Survived (in that order)

# Sex, Survived
t2 <- margin.table(Titanic, c(2,4))
t2

mosaicplot(t2, col=c("darkred", "darkgreen"), main = "Titanic Survival by Sex")




#//////////////////////////////
#   Pairs plots               #
#//////////////////////////////

head(mtcars)

pairs(mtcars[ , c("hp", "drat", "wt", "qsec")])
plot(mtcars[ , c("hp", "drat", "wt", "qsec")])

plot(df.heights[ , -1])
pairs(df.heights[ , -1])

cor(df.heights[ , -1])
cor(mtcars[ , c("hp", "drat", "wt", "qsec")])

cor(mtcars[ , c("hp", "drat")])
cor(mtcars[ , c("drat", "hp")])



#//////////////////////////////
#   Histograms                #
#//////////////////////////////

table(pi2000)
hist(pi2000)                           # Notice the # of bins (9) vs # of frequency (10)
# intervals closed on the left - bins for the count of 0's and 1's are together (181+213)
hist(pi2000, right=TRUE)               # right=TRUE is default. Same thing for the 1st bin (same as the previous plot)
hist(pi2000, right=FALSE)              # Same thing for the last bin - last 2 bins get combined

# Ways to fix this:
# Use the breaks argument after looking that the ?hist help file and/or use the "l" argument.

data.frame(pi2000 = pi2000) %>% 
  ggplot(., aes(x = pi2000)) + geom_bar()





# Question from student about when to use which plot type, what is the difference.
# Answer is barplots are for counts (or proportions/percentages) of categorical variables such as cloud types.
# histograms are for counts (or proportions/percentages) of continuous variables such as heights.
# boxplots are also for counts (or proportions/percentages) of continuous variables such as heights, but
# they just present the same information as the histogram in a different and summarized way.


hist(df.heights$height)
hist(df.heights$weight)

boxplot(df.heights$height)
boxplot(df.heights$weight, horizontal = TRUE)

boxplot(df.heights$height ~ df.heights$gender)

# Also note that just because R code or a formula gives you some result, it does not mean the result is correct
# or meaningful.  For example, we can (mistakenly) do a barplot of heights which is continuous (not categorical)
# and it does generate a plot, but here each bar represents a unique height (instead of unique category)
# and this plot is *almost* meaningless (there is a tiny bit of information in the fact that that you can still
# relate the range of values on the y axix in the barplot to the range of values on the x axis in the correct
# histogram or barplot).
barplot(df.heights$height)
length(df.heights$height)







#######################################
# Scratchwork from Office Hours
#######################################

