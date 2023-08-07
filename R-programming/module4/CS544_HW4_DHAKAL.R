#Part1) Binomial distribution
#a)
#-------------------------------------------------------------------------------
p <- 40/100
n <- 5

pmf <- dbinom(0:n,size = n,prob = p)
pmf
cdf <- pbinom(0:n,size = n,prob = p)
cdf

#for plotting pmf
heights <- dbinom(0:n,size = n,prob = p)
plot(0:n,heights,type = "h",main ="Probablity distribution for perfect score",
     xlab = "Number of attempts for a perfect score",ylab  = "PMF" )
points(0:n, heights,pch=16)

#for plotting pmf
#inserting first values of 0 for corresponding F(x), x<0
cdf <- c(0,cdf)
cdf

cdfplot <- stepfun(0:n,cdf)
plot(cdfplot,verticals = FALSE,pch = 16, main = "CDF plot",
     xlab = "Number of attemts for a perfect scores",ylab = "CDF" )
#--------------------------------------------------------------------------------
#b)
#finding perfect scores in exactly 2 out of 5 attempts
#USING R FUNCTION
dbinom(2,size = n,prob = p)
#using bionomial coeficients
choose(5,2)*p^2*(1-p)^3
#----------------------------------------------------------------------------------------------
#c)
#finding probability for perfect scores in at least 2 attempts out of 5
# finding values fx(2)+fx(3)+fx(4) +fx(5) which denotes at least two perfect scores out of 5 attempts.

atleast_two <- sum(dbinom(2:n,size = n,prob = p))
atleast_two
#alternatively 1-P(X<2)
pbinom(1,size = n,prob = p,lower.tail = FALSE)
#----------------------------------------------------------------------------------------------

#d)
#using same distribution for 1000 students
rdistibution <- rbinom(1000,size = n,prob = p)
#plotting barplot
barplot(table(rdistibution),xlab = "Number of attempts",ylab = "Frequency",
        col = rainbow(6),main = "Distribution of frequency of attempts for a perfect scores over 1000 students"
        ,ylim = c(0,350))
#-------------------------------------------------------------------------------
#*******************************************************************************

#Part2) Negative Binomial distribution

#probablity of perferct scores
p2 <- 60/100
# number of peferct scores 
r2 <- 3
#-------------------------------------------------------------------------------
#a)
#probability of geeting n not perfect scores before 3 perfect scores can be calculated by
# 0 not perfect before 3 perfect
#1 not perfect before 3 perfect
# 2 not perfect before 3 perfect 
# 3 not perfect before 3 perfect
# so on ...  upto 10 not perfect before 3 perfect scores.
pmf2 <- dnbinom(0:10,size = r2,prob = p2)

# Plotting pmf
plot(0:10,pmf2,type = "h", xlab = "Number of failures before 3 perfect scores",
     ylab = "Probablity of not perfect", 
     main ="PMF for negative bionomial ditribution",ylim = c(0,0.3))
abline(h=0)
cdf2 <- pnbinom(0:10,size = r2,prob = p2)
cdf2
#inserting 0 in cdf2
cdf2 <- c(0,cdf2)
cdf2
cdfplot <- stepfun(0:10,cdf2)
plot(cdfplot,verticals = FALSE,pch=16,main = "CDF plot",
     xlab = "Number of failures before 3 perfect scores",ylab = "CDF")

#-------------------------------------------------------------------------------
#b)
#finding probablity that student will have the 3 perfect scores
#with exactly 4 failures.
#i.e.P(X=4) ?

# using R function
failures4 <- dnbinom(4,size = r2,prob = p2)
failures4
# this can be also calculated as follow
#7th attempt is always perfect according to question
#first 6 attempts should have  2 perfect and and 4 failure attempts.
# probablity of geeting 4 exact failures before 3 perfect attempts is 
alt_failures4 <- choose(6,2)*p2^2*(1-p2)^4*p2
alt_failures4
#-------------------------------------------------------------------------------
#c)
# 3 perfet scores with at most 4 failures
#This includes following probablity.
#P(X=0)+P(X=1)+P(X=2)+P(X=3)+P(X=4)

prob_atmost4 <- pnbinom(4,size = r2,prob = p2)
prob_atmost4

#-----------------------------------------------------------------------------------
#d)
#using R function
neg_bionomia_ditribution100 <- rnbinom(1000,size = r2,prob = p2)
barplot(table(neg_bionomia_ditribution100),col = rainbow(12),
        xlab = "Number of failures before 3 success",
        ylab = "Frequency",main = "Frequency distribution among 100 students",
        ylim = c(0,300))
#********************************************************************************
#Part3) Hypergeometric distribution
#-------------------------------------------------------------------------------
#a)
# Probability distribution of this question looks like
#Pm(X=0)and Pp(X=20) -.multiple 0 and programming 20 questions
#Pm(X=1) and Pp(X=19)->multiple 1 and programming 19 
#so on.....
#Pm(X=20) and Pp(X=0)-> multiple 20 and programming 0


#using R function
Multi_quest <- 60
program_quest <- 40
k_chose <- 20
pmf_hyper <- dhyper(0:k_chose,m=Multi_quest,n=program_quest,k=k_chose)
cdf_hyper <- phyper(0:k_chose,m=Multi_quest,n=program_quest,k=k_chose)

# Plotting pmf
heights_hyper <- dhyper(0:k_chose,m=Multi_quest,n=program_quest,k=k_chose)
plot(0:k_chose,pmf_hyper,type = "h", 
     xlab = "Number of multiple choice question choosen out of 20",
     ylab = "probablity of multiple question choosen",
     main ="PMF when 20 qeustions are choosen ")
points(0:k_chose, heights_hyper,pch=16)
#plotting cdf
#inserting 0 in cdf2_hyper
cdf_hyper <- c(0,cdf_hyper)
cdfplot_hyper <- stepfun(0:k_chose,cdf_hyper)
plot(cdfplot_hyper,verticals = FALSE,pch=16,main = "CDF_hyper plot",
     xlab = "Number of multiple choice questions choosen out of 20",
     ylab = "CDF",col = rainbow(20))
#-------------------------------------------------------------------------------------
#b
#Pm(X=10)?
# This means P(10 multiple choice questions,10 programming questions)
#using combinations method
prob_10multiple_quest <- choose(60,10)*choose(40,10)/choose(100,20)
prob_10multiple_quest
#using R explicit method
#from questions, m=60,n=40,k=20
dhyper(10,m=60,n=40,k=20)
#-------------------------------------------------------------------
#c)P(X>=10)?
#Using R function
phyper(9,m=Multi_quest,n=program_quest,k=k_chose,lower.tail = FALSE)
#alliteratively,
sum(dhyper(10:20,m=Multi_quest,n=program_quest,k=k_chose))

#-------------------------------------------------------------------
#d)
#using r function to find random distribution 
multiple_choice_distrib <- rhyper(1000,m=Multi_quest,n=program_quest,k=k_chose)
barplot(table(multiple_choice_distrib),ylim = c(0,250),
        xlab = "Number of multiple choices questions",
        ylab = "Frequency",
        main = "Frequency Distribution of multiple choice questions for 1000 students ")


#*******************************************************************************
#Part4) Poisson distribution 

#a)
lamda <- 10
#using R function
#probablity of getting exactly 8 question per day is 
#P(X=8)
dpois(8,lambda = lamda)
#---------------------------------------------------------------------------
#b)getting at most 8 questions is
#P(X<=8)
ppois(8,lambda = lamda)
#alternatively,
sum(dpois(0:8,lambda = lamda))
#-------------------------------------------------------------------------
#c)
sum(dpois(6:12,lambda = lamda))
#alternative1
ppois(12,lambda = lamda)-ppois(5,lambda = lamda)
#alternative2
diff(ppois(c(5,12),lambda = lamda))
#--------------------------------------------------------------------------
#d)
pmf_pois <- dpois(0:20,lambda = lamda)
plot(0:20,pmf_pois,type = "h",xlab = "Number of questions",
     ylab = "PMF",ylim = c(0,0.16))
abline(h=0,col="red")
#--------------------------------------------------------------------------
#e)
#distribution of number of question a professor gets during 50 days periods

frequency_distrib <- rpois(50,lambda = lamda)
barplot(table(frequency_distrib),ylim = c(0,14),
        main = "Number of days vs number of questions receive",
        xlab = "Number of questions receive",ylab = "Frequency(in day/s)")

#plotting box plot of the number of questions
boxplot(frequency_distrib,horizontal = TRUE,pch=16)

#1.since these values are randomly generated, each time I run, the shape of the
#plot changes.
#2.bar plot looks like somewhat bell shape which means there is higher frequency
# of question near the mean number
# of questions.
#3.from box plot median number of questions are around 10 questions.
#4. around 50% of total questions spread between 8-14 questions each day(i.e.middle 50%).

#------------------------------------------------------------------------------
#Part5) Normal distribution
#a)
mu <- 100
sigma_sd <- 10
lower_end <- mu-3*sigma_sd
higher_end <- mu+3*sigma_sd
#probablity distribution
pdf <- dnorm(lower_end:higher_end,mean = mu,sd= sigma_sd)
plot(lower_end:higher_end,pdf,type = "l",col="green",main = "$ Spent in Souvenirs",
     xlab = "$",ylab = "PDF")
#--------------------------------------------------------------------------------
#b)
#above 120 means beyound 2sd toeards upper ends
above120 <- pnorm(120,mean = mu,sd=sigma_sd,lower.tail = FALSE)
above120
# alternatively
1-pnorm(120,100,10)
#2.27% of chance sthat visitor will spend above $120


#-----------------------------------------------------------------------------
#c)
pnorm(90,mean = mu,sd=sigma_sd)-pnorm(80,mean = mu,sd=sigma_sd)
#alternatively
sum(dnorm(80:90,mean = mu,sd=sigma_sd))
#That is 13.59% chance.
#----------------------------------------------------------------------------
#d)
#with in 1sd
pnorm(mu+1*sigma_sd,mean = mu,sd=sigma_sd)-pnorm(mu-1*sigma_sd,mean = mu,sd=sigma_sd)
#that is 68.26% chances

#with in 2sd
pnorm(mu+2*sigma_sd,mean = mu,sd=sigma_sd)-pnorm(mu-2*sigma_sd,mean = mu,sd=sigma_sd)
#that is 95.44% chances

#with in 3sd
pnorm(mu+3*sigma_sd,mean = mu,sd=sigma_sd)-pnorm(mu-3*sigma_sd,mean = mu,sd=sigma_sd)
#That is 99.73% chance.
#--------------------------------------------------------------------------------------
#e)
#Middle 80% values.since distribution is symmetrical,its is distributed 40 % on 
#each side of the mean
# this means lower 10% upper 90% covers middle 80%
#so two values can be calculated by using qnorm method.
c(qnorm(0.1,mean = mu,sd=sigma_sd),qnorm(0.9,mean = mu,sd=sigma_sd))

#--------------------------------------------------------------------------------
#f)
#top 2 of the spenders means finding values for 98th percentale
top_2val <- qnorm(0.98,mean = mu,sd=sigma_sd)
top_2val
paste("Spending ",top_2val,"or more will be in top 2% group and gets free T-shirt")
#-------------------------------------------------------------------------------
#g
# with above mean and sd, plot of distribution of 10000 visitors can be done by 
#first using rnorm and then using appropriate ploting method.
random_10000 <- rnorm(10000,mean = mu,sd=sigma_sd)
random_10000_hist <- hist(random_10000,xlab = "Money Spent",ylab = "Frequency",
     main = "Money spent vs visitors' Frequency")


#-------------------------------------------------------------------------------
                              #The End
#*******************************************************************************





















