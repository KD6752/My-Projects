#*******************************************************************************
library(tidyverse)
library(plotly)

file <- "https://people.bu.edu/kalathur/datasets/mlk.txt"
words <- scan(file,what = character())
#-------------------------------------------------------------------------------

#a)
#using str_subset method with special expression
str_subset(words,"[:punct:]")


#Alternatively
#1
#using str_detect functions from stringr
# words[str_detect(words,"[:punct:]")==TRUE]
#2
#using general expression method
# grep("[[:punct:]]",words,value = TRUE)

#------------------------------------------------------------------------------

#b)
#using str_replace method
replace_punct <- str_replace_all(words,"[:punct:]","")
replace_punct

#Alternatively, we can use gsub method 
# gsub("[[:punct:][:blank:]]+", " ",words)


#now converting all words to lower case
new_words <- str_to_lower(replace_punct)

#alternatively we can use tolower method as well
# tolower(replace_punct)


#------------------------------------------------------------------------------
#c)
# getting top 5 numbers of words involves 3 steps
#1. table functions count the number of each words present
#2. sort function sort he words based on their frequency in increasing order
#3  decreasing()  method arrage the words based decreasing order of their
#frequencies and finally seling top 5 words.
top5.words <- sort(table(new_words),decreasing = TRUE)[1:5]
top5.words

#-----------------------------------------------------------------------------
#d)
# in this solution, I am going to find the lengths of each word and then find 
#  the frequency of each length types.
length.of.words <- str_length(new_words)
frequency.of.word.length <- table(length.of.words)

#alternatively we can also use nchar() method to check the frequencies.
 #table(nchar(new_words))
 
#now showing frequencies using bar plot.
par(mar=c(5,5,2,2))
barplot(frequency.of.word.length,xlab = "Length of words",ylab = "Frequency",
        main = "Frequency of length of words",col = rainbow(14),ylim = c(0,60))
#-----------------------------------------------------------------------------
#e)
#for this,I will calculate the length of each words and then find the maximum value
# i.e and find the word/s which have that maximum length.
longest.words <- new_words[str_length(new_words)==max(str_length(new_words))]
longest.words

#Aternatively
#subset(new_words,str_length(new_words)==max(str_length(new_words)))

#-----------------------------------------------------------------------------

#f)
#for this I will be suing str_detect method as follows
str_subset(new_words,"^c")

#alternatively
#new_words[str_detect(new_words,"^c")]

#-----------------------------------------------------------------------------

#g)
# again for this, i will be using str_detect method as follows
str_subset(new_words,"r$")

# there are words that ends with r and occurs more than one time.We can take one 
# words using unique method

#Alternatively
#new_words[str_detect(new_words,"r$")]

#-------------------------------------------------------------------------------

#h)
#for this we can combine  solution in f and g.
# using str_subset method.

str_subset(new_words,"^c(.)*r$")
#alternatively
# \\b word boundry \\w* represent any words with zero or more characters.
# matches.br <- str_detect(new_words, "\\bc\\w*r\\b")
# new_words[matches.br]
#---------------------------------------------------------------------------
#last part of Part 1
stopfile <- "https://people.bu.edu/kalathur/datasets/stopwords.txt"
stopwords <- scan(stopfile, what=character())
# removing the stop words 
new.words <- subset(new_words,!new_words %in% stopwords)
length(new.words)

#now finding the top 5 frequent words
# using same steps as answer in c.
new.top5.words <- sort(table(new.words),decreasing = TRUE)[1:5]
new.top5.words

# finding frequency of word lengths
frequency.word.length.2 <- table(nchar(new.words))
par(mar=c(5,5,5,2))
barplot(frequency.word.length.2,xlab = "Length of word",ylab = "Frequency",
        main = " Frequency of different word lengths", col = rainbow(12),
        ylim = c(0,50))

#------------------------------------------------------------------------------

# Part2) Data Wrangling 


temp.data <- read.csv("/Users/kokildhakal/Desktop/STUDY/BU/7.CS544/Module6/usa_daily_avg_temps.csv")


#a)
usaDailyTemps <- as_tibble(temp.data)
head(usaDailyTemps)

#b)
max.temp <- usaDailyTemps|>
  group_by(year) |>
  summarise(maximum_Temp=max(avgtemp))
#maximu temperature by Year
max.temp


#plotting
plot_ly(y=max.temp$maximum_Temp,x=max.temp$year,type = "scatter",
        color = max.temp$maximum_Temp,colors = "Paired",mode ="markers") |>
  layout(title = "Maximum Temperature in each from 1995 to 2015",
         xaxis=list(title="Year"),
         yaxis=list(title="Temperature"))
#-----------------------------------------------------------------------------

#c)
#finding maximum temperature by states
max.temp.by.states <- usaDailyTemps |>
  group_by(state)|>
  summarise(Maximum_Temp=max(avgtemp))
#maximum temperature by states
max.temp.by.states

plot_ly(y=max.temp.by.states$Maximum_Temp,x=max.temp.by.states$state,type = "scatter",
        color =max.temp.by.states$state,mode ="markers",colors = "Paired") |>
  layout(title = "Maximum Temperature in each State",yaxis=list(title="Temperature"))


#------------------------------------------------------------------------------
#d)
#filtering data for Boston Only
bostonDailyTemps <- usaDailyTemps |>
  filter(city=="Boston")
head(bostonDailyTemps)
#------------------------------------------------------------------------------
#e)
#finding average monthly temperatures of Boston
montly.avg.temp.boston <- bostonDailyTemps|>
  group_by(month)|>
  summarise(avg_temp=mean(avgtemp))

#average montly temperature in Boston
montly.avg.temp.boston

plot_ly(y=montly.avg.temp.boston$avg_temp,x=montly.avg.temp.boston$month,
        type = "scatter",color = montly.avg.temp.boston$month,colors = rainbow(12))|>
  layout(title="Average Montly Temperatures in Boston",
         yaxis=list(title="Temperature"),
         xaxis=list(title="Month"))


#------------------------------------------------------------------------------

#*******************************************************************************


