forbes <- read.csv("https://people.bu.edu/kalathur/datasets/forbes.csv")
freq_country <- table(forbes$country)
par(mar=c(7,4,2,2))
barplot(freq_country,col = "lightpink",las =2 )
#----------------
gender_forbes <- table(forbes$gender)
gender_forbes
pie(c(gender_forbes[1]/sum(gender_forbes),gender_forbes[2]/sum(gender_forbes)),labels = c("Female","Male"))
#------------------------

top5_freq_category <- sort(table(forbes$category),decreasing = TRUE)[1:5]
names(top5_freq_category)


top5_subset <- subset(forbes,forbes$category%in% names(top5_freq_category) )
head(top5_subset
)
freq_subset <- table(top5_subset$category,top5_subset$gender)
freq_subset
plot(freq_subset,col = c("lightyellow","lightblue"))

#part2
us_quarters <- read.csv("https://people.bu.edu/kalathur/datasets/us_quarters.csv")
head(us_quarters)
attach(us_quarters)
highest_denvermint <- subset(us_quarters,DenverMint==max(DenverMint))
highest_denvermint["State"]
highest_phillymint <- subset(us_quarters,PhillyMint==max(PhillyMint))
highest_phillymint["State"]

lowest_denvermint <- subset(us_quarters,DenverMint==min(DenverMint))
lowest_denvermint["State"]

lowest_phillymint <- subset(us_quarters,PhillyMint==min(PhillyMint))
lowest_phillymint["State"]

head(us_quarters)
attach(us_quarters)
barplot(us_quarters$DenverMint,us_quarters$PhillyMint,col = c("blue","grey"))

denver <- DenverMint
philly <- PhillyMint
matrix_quat <- rbind(denver,philly)
matrix_quat
barplot(matrix_quat,beside = TRUE,names.arg = State,col = c("blue","grey"),las=2,legend.text =c("Denvermint","Phillymint"))
legend(c("Denvermint","Phillymint"))
#--------------------

boxplot(denver,philly,col = c("blue","lightpink"),pch=16,names = c("Denvermint","Phillymint"))

denver_five <- fivenum(DenverMint)
high_end <- denver_five[4]+1.5*(denver_five[4]-denver_five[2])
low_end <- denver_five[2]-(denver_five[4]-denver_five[2])
subset(us_quarters,DenverMint>high_end)
subset(us_quarters,DenverMint<low_end)

philyy_five <- fivenum(PhillyMint)
high_phi <- philyy_five[4]+1.5*(philyy_five[4]-philyy_five[2])
subset(us_quarters,PhillyMint>high_phi)
low_phi <- philyy_five[2]-1.5*(philyy_five[4]-philyy_five[2])
subset(us_quarters,PhillyMint<low_phi)


#-------------------

stocks <- read.csv("https://people.bu.edu/kalathur/datasets/stocks.csv")
nrow(stocks)
head(stocks)
stocks <- stocks[,colnames(stocks)!="Date"]
head(stocks)

 pairs_plot <- pairs(stocks[-1],pch=16)
 pairs_cm <- round(cor(stocks[-1]),2)
 

 val <- sort(pairs_cm[1,],decreasing = TRUE)[-1][1:3]
 val
 stock_name <- rownames(pairs_cm)
 stock_name

for (i in seq(1,6)) {
  pick_row <- pairs_cm[i,]
  top3_stocks <- sort(pick_row,decreasing = TRUE)[-1][1:3]
  top3_stocks_names <- names(top3_stocks)
  cat("Top 3 for Stock",stock_name[i],"\n",top3_stocks_names,"\n",top3_stocks,"\n","\n")

  }

  
#-----------------
 
 scores1 <- read.csv("https://people.bu.edu/kalathur/datasets/scores.csv")
scores1

fivenum(scores1$Score)


























