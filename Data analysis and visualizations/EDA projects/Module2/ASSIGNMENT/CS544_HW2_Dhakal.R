#******************************************************************************

#Question part 1
#using function to calculate the conditional probalities.
bayes <- function(prior,liklihood){
  numerators <- prior*liklihood
  return(numerators/sum(numerators))
}
prior<- c(4250/10000,2850/10000,1640/10000,1260/10000)
prior
likelihood<-c(1062/4250,1710/2850,656/1640,189/1260)
likelihood
bayes(prior,likelihood)
library(prob)
#*******************************************************************************
# Part 2 Random Variables
#a)
s <- rolldie(3,makespace = TRUE)
nrow(s)
#checking first 3 samples ouput
head(s,n=3) 
#sum of the rollls is greater than 3 but less than 8
a <- subset(s,X1+X2+X3 >3 & X1+X2+X3 < 8)
#first theree sample output
head(s,n=3)
prob(a)
#*****************************************************
#b)
#all rolls are identical
b <- subset(s,X1==X2 & X2==X3 & X1==X3) 
#first three samples output
head(b,n=3)
prob(b)
#******************************************************
#c)
#only two of the three rolls are identical.
c <- subset(s,X1==X2 & X1!=X3 | X2==X3 & X2!=X1| X1==X3 & X2!=X3)
#first three sample output
head(c,n=3)
prob(c)
#*****************************************************
#d)
# None of the three rolls are identical
d <- subset(s,X1!=X2 & X2!=X3 & X1!=X3)
#first three sample output
head(d,n=3)
nrow(d)
prob(d)
#*****************************************************
#e)
# probablity  that only two of three rolls are identical 
#given sum of the rolls are greater than 3 and less than 8
#using conditional R construct
prob(c,given = a)

#Alternatively 
#we can use P(C/A) = P(C intersection A)/P(A)
prob(intersect(c,a))/prob(a)
#***********************************************************************************
#Part 3 Functions 
sum_of_first_N_even_squares <- function(n){
  m<-0 # counter for counting the number of even numbers starts from 0
  sum1<-0 # to add squared number starts from 0
  num1<-0 # current even number and starts from value 0
  
  while (m<n) {
    num1<-num1+2  # in every loop, current even number is equall to 2 plus previous number
    sum1<-sum1+num1**2
    m<-m+1
    
  }
  return(sum1)
}

sum_of_first_N_even_squares(0)
sum_of_first_N_even_squares(2)
sum_of_first_N_even_squares(5)
sum_of_first_N_even_squares(10)
#*********************************************************************************
# Part 4 R
tesla <- read.csv("https://people.bu.edu/kalathur/datasets/TSLA2022.csv")
#to compute the probablity space for given data
tsla <- probspace(tesla)

#a)

sm<-summary(tsla$Close)
#changing names of the variables
names(sm)<- c("Min","Q1","Q2","Mean","Q3","Max")
sm
#**************************************************************************
#b)
min_close<- subset(tsla,tsla$Close==min(tsla$Close))
min_close
rownames(min_close)
min_close$Date
min_close$Close

paste("The minimum Tesla value of",min_close$Close, "is at row",rownames(min_close), "on", min_close$Date )
#*****************************************************************************
#c)
max_close <- subset(tsla,tsla$Close==max(tsla$Close))
max_close
rownames(max_close)
max_close$Date
max_close$Close
paste("The maximum Tesla value of",max_close$Close, "is at row",rownames(max_close),"on",max_close$Date)
#********************************************************************************
#d)
high_close_low_open <- subset(tsla,tsla$Close>tsla$Open)
#probability of tesla being its closing price greater than its opening price
# total number of rows that has higher closing price than opening price 
#divide by total number of days stock trade happens

probability_high_close_low_open<- prob(high_close_low_open)
probability_high_close_low_open

#Alternatively:
#probablity can be calculated using R 
nrow(high_close_low_open)/nrow(tsla)

#*******************************************************************************
#e)
high_vol_trade <- subset(tsla,tsla$Volume>100000000)
#probablity that on any given day, the tesla traidn volume 
#woube be greater than 100 millin shares is
probablility_high_vol_trade <- prob(high_vol_trade)
probablility_high_vol_trade
#alternatively
#probablity can be calculated by using R command
nrow(high_vol_trade)/nrow(tsla)

#*******************************************************************************
#f)
#for conditional probablity
#probablity that on any given day,tesla closing price is greater than opening price
#given tesla trade volume is greater than 100 mil 
#using R command
prob(high_close_low_open, given = high_vol_trade)

#Alternatively,
#P(A/B) = P(A intersect B)/P(B)
conditional_probablity <- prob(intersect(high_close_low_open,high_vol_trade))/prob(high_vol_trade) 
conditional_probablity



#*******************************************************************************
#g)
# there are 251 days trading happenned = nrow(tsla)
Total_number_of_Shares <-  nrow(tsla)
# total money spent buying all 251 shares in its low price of respective day
buy_price<- sum(tesla$Low)
buy_price
# sell price would be closing  price of last day 251 st day
#finding last day of year 
last_day_trade<- subset(tesla,rownames(tesla)==nrow(tesla))
last_day_trade
sell_price<- nrow(tesla)* last_day_trade$Close
sell_price
#finding loss or gain selling all shares
loss_gain<- sell_price - buy_price
loss_gain
# as selling 251 shares get $30873 while $64873 was spent buying those shares.
#that is why there will be loss in this trading
#loss_amount 33516
paste("there will be ",loss_gain,"gain after selling all the shares ")



#*****************************************************************************
