#****************************************************************************************************
forbes <- read.csv("https://people.bu.edu/kalathur/datasets/forbes.csv")
#a)
#using table function to calculaate the frequency by country
freq_country <- table(forbes$country)
max_val <- max(freq_country)
max_val
par(mar=c(7,4,2,2))
barplot(freq_country,col = "lightpink",las =2,ylim = c(0,max_val))


#-------------------------------------------------------------------------
#b
freq_gender <- table(forbes$gender)
slices <- c(freq_gender[1]/sum(freq_gender),freq_gender[2]/sum(freq_gender))
lbls <- c("Female","Male")
pct <- round(slices*100,2)
lbls <- paste(lbls,pct,"%")
lbsl <- paste(lbls,"%", sep = "")

pie(slices,labels = lbls,col = rainbow(2))
#-----------------------------------------------------------------------------
#c)

top_categories <-sort(table(forbes$category), decreasing = TRUE)[1:5]
# Subset of the dataset for the top 5 categories
subset_forbes <- forbes[forbes$category %in% names(top_categories), ]
top_five <- table(subset_forbes$category,subset_forbes$gender)
top_five
bar_names <- rownames(top_five)
par(mar=c(3,3,2,0))

barplot(t(top_five),beside = TRUE,col = c("lightpink","lightblue"),names.arg = bar_names,ylim = c(0,350),legend.text = c("Female","Male"))


#-------------------------------------------------------------------------------
#d) following are inferences drqwn from above plots
#1Threre are around 88% of male and around 12% of female among the billionaire datasetst
#2. Most billionaires are from United State followed by China.
#3 most of the billionaires are from finance & Investments categories followed by Manufacturing.


#**********************************************************************************************
#Part2
us_quarters <- read.csv("https://people.bu.edu/kalathur/datasets/us_quarters.csv")
attach(us_quarters)
#-------------------------------------------------------------------------------
#a)
highest_denvermint_state <- subset(us_quarters,DenverMint==max(DenverMint))
highest_phyllymint_state <-  subset(us_quarters,PhillyMint==max(PhillyMint)) 
lowest_denvermint_state <- subset(us_quarters,DenverMint==min(DenverMint))
lowest_phyllymint_state <- subset(us_quarters,PhillyMint==min(PhillyMint))
paste("The highest number of quaters produced for DenverMint is by ",highest_denvermint_state$State,"State which is",
      highest_denvermint_state$DenverMint)
paste("The highest number of quaters produced for PhyllyMint is by ",highest_phyllymint_state$State,"State which is",
      highest_phyllymint_state$PhillyMint)
paste("The lowest number of quaters produced by DenverMint is by ",lowest_denvermint_state$State,"State which is",
     lowest_denvermint_state$DenverMint)

paste("The lowest number of quaters produced for PhyllyMint is by ",lowest_phyllymint_state$State,"State which is",
      lowest_phyllymint_state$PhillyMint)

#------------------------------------------------------------------------------------------
#b)
data_matrix_quaters <-rbind(DenverMint,PhillyMint)
data_matrix_quaters
state_names <-State
bar_colors <- c("blue", "grey")
bar_legend <- c("Denvermint","Phillymint")
options(scipen = 5)
par(mar=c(8,5,3,0))
barplot(data_matrix_quaters,beside = TRUE, col = bar_colors,legend.text = bar_legend,
        ylim = c(0,1000000), names.arg = state_names,las = 2)

#From above chart, 
#1 the PhillyMint produces high number of Quaters in Verginia state
#2 The DenverMint produces highe number of Quaters in Connecticut State
#------------------------------------------------------------------------------------

#c)

boxplot(DenverMint,PhillyMint,col = c("blue","lightpink"),pch=16,names = c("Denvermint","Phillymint"))

#For DenverMint:
#1 There are two outliers at the upper end of the data
#2 The upper whisker is longer than the lower whisker, suggesting that there is greater variability or
#spread in the upper part of the data distribution
#for Phillymint
#1 There are 8 outliers at the upper end of the data
# 2 lower whisker is short which means there is less variability/spread in data in the lower part of the data.


#-----------------------------------------------------------------------------------------
#d
#For DenverMint
#finding five number in Denvermint column
fivnum_denv <- fivenum(DenverMint)
#finding outliers towards upper end
denv_out_high <- fivnum_denv[4]+1.5*(fivnum_denv[4]-fivnum_denv[2])
denver_outlier_high <- subset(us_quarters,DenverMint > denv_out_high)
denver_outlier_high$State
#finding outliers towars lower end
denv_out_low <- fivnum_denv[2]-1.5*(fivnum_denv[4]-fivnum_denv[2])
denver_outlier_low <- subset(us_quarters,DenverMint < denv_out_low)
denver_outlier_low
#so there is no outliers in lower ends


#for Phillymint
fivnum_philly <- fivenum(PhillyMint)
#finding outliers towards upper end
philly_out <- fivnum_philly[4]+1.5* (fivnum_philly[4]-fivnum_philly[2])
philly_outlier <- subset(us_quarters,PhillyMint>philly_out)
#outlier states are
philly_outlier$State

#finding outliers towards lower end.
philly_out_low <- fivnum_philly[2]-1.5*(fivnum_philly[4]-fivnum_philly[2])
philly_outlier_low <- subset(us_quarters,PhillyMint< philly_out_low)
philly_outlier_low
#so there is no outliers in lower ends

detach(us_quarters)
#------------------------------------------------------------------------------------

#******************************************************************************
#Part 3
#------------------------------------------------------------------------------

stocks <- read.csv("https://people.bu.edu/kalathur/datasets/stocks.csv")
#a)
#removing date column from data set 
stocks <- stocks[,colnames(stocks)!="Date"]
# drawing pair plot between different pairs among six stocks. 
pairs(stocks,pch=16)
#-------------------------------------------------------------------------------
#b)
#Correlation matrix among the six stocks in the data set
round(cor(stocks),digits = 2)
#-------------------------------------------------------------------------------
#c)
#1. Google and Microsoft stocks has the strongest positive correlations(0.95)
#2.Tesla and Facebook has weakest positive correlations(0.05)
#3 there is no negative correlation among all six stocks which tells there is no
#such stock which increases its value while other decrease
#4 There is also strongest relationships between Microsoft and apple(0.90) which
# means increase or decrease in value of one stock also increase or decreases 90% 
# of time respectively.
#--------------------------------------------------------------------------------
#d)
cm <- round(cor(stocks),digits = 2)
#names of stocks
stock_names <- rownames(cm)
stock_names
cm[1,]

for (i in seq(1,ncol(cm))) { #looping through each row of correlation matrix
  pick_row <- cm[i,] # in every loop, it pick one row
  #on each row it sorts the values, remove the first index value which is not important  and then finds top 3 values
  top3_stocks <- sort(pick_row,decreasing = TRUE)[-1][1:3]
  top3_stocks_names <- names(top3_stocks) #names for top 3 stocks in each row
  cat("Top 3 for Stock",stock_names[i],"\n",top3_stocks_names,"\n",top3_stocks,"\n","\n")
  
}

#----------------------------------------------------------------------------------------

#*********************************************************************
#Part 4

scores <- read.csv("https://people.bu.edu/kalathur/datasets/scores.csv")
attach(scores)

#a)
hist_scores <- hist(Score,col = "lightblue")
breaks_score <- hist_scores$breaks
l <- length(breaks_score)
count <- hist_scores$counts
i <- 1
while (i<l) {
  start_val <- breaks_score[i] #starting value in each interval
  end_val <- breaks_score[i+1] #ending value in  each interval
  interval_count <- count[i] #counts in each interval
  cat(interval_count,"students in range (",start_val,",",end_val,"]","\n")
  i <- i+1
}

#-------------------------------------------------------------------------------
#b)
#costomizing the above scores
hist_scores2 <- hist(Score,col = "lightpink",breaks = seq(30,90,length.out = 4))
len_breaks <- length(hist_scores2$breaks)
count_interval <- hist_scores2$counts 
letter_grade <-LETTERS[(len_breaks-1):1]#intervals is one less than number of breaks
letter_grade


j <- 1
while (j<len_breaks) {
  start_score_interval <- hist_scores2$breaks[j] #starting value in each interval
  end_score_interval<- hist_scores2$breaks[j+1] #ending value in  each interval
  count_in_interval <- count_interval[j] #counts in each interval
  cat(count_in_interval,"students in",letter_grade[j],"grade range (",
      start_score_interval,",",end_score_interval,"]","\n")
  j <- j+1
  
}
#---------------------------------------------------------------------------------
detach(scores)


