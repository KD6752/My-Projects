
#******************************************************************************
#Dataset
boston <- read.csv(
  "https://people.bu.edu/kalathur/datasets/bostonCityEarnings.csv",
  colClasses = c("character", "character", "character", "integer", "character"))
#------------------------------------------------------------------------------
#a)histogram of earnings
breaks_hist <- seq(0,500000,by= 50000)
options(scipen = 4)
par(mar=c(5,5,2,2))
hist_plot <- hist(boston$Earnings, breaks = breaks_hist,xlab = "Earnings", 
     ylab ="Number of People(Frequency)")
#Mean Earnings
mean(boston$Earnings)
#Standard deviation of Earnings
sd(boston$Earnings)

boxplot(boston$Earnings)
#inferences
#1. The data set looks skewed(not normal).
#2. Most of the people belongs to 50k to 150k earnings.
#3. there is small number of people that has income beyond 300k.
# 4. when we do box plot we can find there are outlines towards the upper end.

#------------------------------------------------------------------------------
library(sampling)

#b)
set.seed(7356)

sample.1000 <- 1000
sample_size <- 10
xbar.10 <- numeric(sample.1000)
for (i in 1:sample.1000) {
  s10_rows <- sample(nrow(boston),10,replace = FALSE) #using sample() method
  s10_sample <- boston[s10_rows,] #mapping selected rows to Boston dataset
 
  xbar.10[i] <-mean(s10_sample$Earnings) # making 1000 samples of size 10
  
}

mean.1000_10 <- mean(xbar.10)
#mean of sample size 10 of 1000 samples
mean.1000_10
sd.1000_10 <- sd(xbar.10)
#Standard deviation of sample size 10 of 1000 samples.
sd.1000_10
par(mar=(c(5,5,2,2)))
hist(xbar.10,xlab = "Earnings", ylab = "Frequency", main = "Histogram of sample means of size 10",
     ylim = c(0,250))


#------------------------------------------------------------------------------
#c)
set.seed(7356)
sample_size_40 <- 40 #for sample size 40
xbar.40 <- numeric(sample.1000) #initializing list of 1000 0s
for (i in 1:sample.1000) {
  s40_rows <- sample(nrow(boston),40,replace = FALSE) #getting random 40 rows out of original dataset
  s40_sample <- boston[s40_rows,] # mapping those sample data to original data

  xbar.40[i] <-mean(s40_sample$Earnings) # replacing those
  
}
#mean of the sample size of 40 of 1000 samples
mean.1000_40 <- mean(xbar.40)
mean.1000_40
#SD of the sample size of 40 of 1000 samples
sd.1000_40 <- sd(xbar.40)
sd.1000_40
#histogram of sample means
par(mar=c(5,5,2,2))
hist(xbar.40,main = "Histogram of sample means of size 40",xlab = "Earnings",ylab = "Frequency")

#------------------------------------------------------------------------------
#d)
# means of three type of distribution
mean_combine <- c(Original=mean(boston$Earnings),Sample_10=mean.1000_10,
                  Sample_40=mean.1000_40)

mean_combine

# it can be seen that mean of the all three type of data are almost same
sd_combine <- c(Orignal=sd(boston$Earnings),Sample_10=sd.1000_10,
                Sample_40=sd.1000_40)
sd_combine
# however standard deviation of all three type of data are different. sd of the
# 1000  mean sample of size 10 is less diverse than original. while data with sample
# size 40 has SD way less than that of sample size of 10.

#theoretical values of sd can be calculated by using formula where sd of origincal 
# sd divided by square root of sample sizes

theoritical_sd <- sd_combine[1]/c(sqrt(10),sqrt(40))
theoritical_sd

# From above original and theoretical values of population data and samples data
#followed the central limit theorem.
#-------------------------------------------------------------------------------
#******************************************************************************

#Part 2
set.seed(7356)
#a)
random.1000 <-rnbinom(1000,3,0.5)
#checking frequency of the number
Freq_1000 <- table(random.1000)
barplot(Freq_1000,xlab = "Numbers",ylab = "Frequency",main = "Frequency of 
        distinct values of distirbution")
#---------------------------------------------------------------------------
#b)
# four sample sizes
sample_sizes <- c(10,20,30,40)
# 5000 samples of each of sample size types
xbar.5000 <- numeric(5000)
list_mean <- c() # To store list of all four means
list_SD <- c() # to store list of all four SD

par(mfrow = c(2,2))

for (size in sample_sizes) {
  for (i in 1:5000) {
    xbar.5000[i] <- mean(sample(random.1000,size,replace = FALSE))
    
  }
  hist(t(xbar.5000),prob=TRUE,
       breaks = 15,main = paste("Sample Size =", size),xlab = "Numbers")
  
  cat("Sample Size = ",size, " Mean = ", mean(xbar.5000),
      " SD = ", sd(xbar.5000), "\n")
  list_mean <- c(list_mean,mean(xbar.5000))
  list_SD <- c(list_SD,sd(xbar.5000))
}

#---------------------------------------------------------------------------
#c)
#from above calculation
#mean from a
mean(random.1000)
#SD from a
sd(random.1000)

#means from b
list_mean
#SDs from b
list_SD


# from above, we can conclude that means of population and sample are almost similar
# while SD of sample means is lower than population. also, In sample means, the 
# data variability decreases as the size of the sample increases.

#Theoretical sample sd calculation can also be done

samples.SD <- sd(random.1000)/sqrt(sample_sizes)
samples.SD

# sample SD for different sizes are almost same as the theoretical SD we get from

#-----------------------------------------------------------------------------

#part 3
#number of employees working in each department can be done by using table
table.name <- table(boston$Department)
#now sorting the value and selecting top5 department.
top5_depart <- sort(table.name,decreasing = TRUE)[1:5]
top5_depart

#mapping with original data set
subset_top5 <- subset(boston,boston$Department %in% names(top5_depart))
#a)
library(sampling)
set.seed(7356)
sample.with.replace <- srswr(50,nrow(subset_top5)) # using R function
row.number <- (1:nrow(subset_top5))[sample.with.replace!=0] # mapping with top 5 dataset's rows
subset.with.replace <- subset_top5[row.number,] # getting subset from top5 data set
#frequencies
table(subset.with.replace$Department)
# percentage with respect to sample size
table(subset.with.replace$Department)/50 
#Alternatively
prop.depart.a <- prop.table(table(subset.with.replace$Department))
prop.depart.a

for (m in 1:length(prop.depart.a)) {
  
  cat(names(prop.depart.a)[m],"will have", prop.depart.a[m]*100,"%", "\n")
}


#------------------------------------------------------------------------------
#b)
set.seed(7356)
inclusion.prob <- inclusionprobabilities(subset_top5$Earnings,50)
length(inclusion.prob)
unequal.probab <- UPsystematic(inclusion.prob)
head(unequal.probab)
new.samples.50 <- getdata(subset_top5,unequal.probab)
head(new.samples.50)
#alternatively we can map the selected rows with subset_top5 as follows
new.samples <- (subset_top5)[unequal.probab !=0,]
#frequency of employee in each department can be calculated by
frequency_depart <- table(new.samples.50$Department)
#calculating proportion
prop.depart.b <-prop.table(frequency_depart)

for (i in 1:length(prop.depart.b)) {
  
  cat(names(prop.depart.b)[i],"will have", prop.depart.b[i]*100,"%", "\n")
}



#-----------------------------------------------------------------------------
#c)
set.seed(7356)
#ordering the data using Department variable
order.department <- order(subset_top5$Department)
#mapping to dataset according to ordered rows
ordered.top5 <- subset_top5[order.department,]
#finding relative frequency of employee in each deparment
frequency.top5 <- table(ordered.top5$Department)

#finding proportions in each department based on their employee numbers.
prop.50 <- round(50*frequency.top5/sum(frequency.top5))
sum(prop.50)
50*frequency.top5/sum(frequency.top5)
# while using sum, it adds up to 49 only but we are supposed to have sample of size
# 50.So I need to find the department that can be added one more. here in proportion
# table Boston police department have 23.495 which would have 24 if it had 0.005 more value.
# so this is the closest  department  that can be used to add one more values and make it 24 instead 23.
#changing second value to 24 from 23.
prop.50[2] <- 24
#now total number of sample becomes 50
sum(prop.50)

st.d <-strata(ordered.top5,stratanames = "Department",size = prop.50,
                        method = "srswor",description =TRUE )
#now retrieving those 50 samples as we get from strata() method using getdata() method.
sample.d <- getdata(subset_top5,st.d)
#checking the frequency
table(sample.d$Department)

#finding proportion of each department according to number of employee in each department
prop.table.c <- round(prop.table(prop.50),2)
prop.table.c

for (n in 1:length(prop.50)) {
  
  cat(names(prop.50)[n],"will have", prop.table.c[n]*100,"%", "\n")
}

#------------------------------------------------------------------------------
#d)
#list of mean of four samples
list.mean.4 <- c(mean(subset_top5$Earnings),mean(subset.with.replace$Earnings),
                 mean(new.samples$Earnings),mean(sample.d$Earnings))
list.mean.4
#mean of original
mean(boston$Earnings)

# Here mean of data is way lower than means 4  types of samples drawn from it. From this
#it can be concluded that the employees in top5 department,which is based on number of
# employees working,also have higher earnings than other department that is why 
# mean of the earnings from top 5 department higher. Also,in such scenario, mean of the sample
#drawn using simple random sampling with replacement are more closer to the mean 
# of the data. However, if we compare among three types of sampling techniques. stratified
#sampling using proportional sizes is more representative to the top 5 department
#subset as mean earning of top 5 subset is more close than with other.

#------------------------------------------------------------------------

#*****************************************************************************

