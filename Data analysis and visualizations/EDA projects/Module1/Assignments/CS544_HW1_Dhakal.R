#***********************************************************
#Q1
#a)
scores<- c(40, 88, 60, 23, 76, 51, 59, 99, 96, 34)
#b)
n <- length(scores)
n
#c)
first_and_second<-scores[c(1,2)]
first_and_second
#d)
# first and last elements in vector.
first_nad_last<- scores[c(1,n)]
first_and_last
#e)
#finding middle two elements in any even number vector.
middle_two <- scores[c(n/2,n/2+1)]
middle_two

#***********************************************************
#Q2

#a)
avg_score <- mean(scores)
avg_score
#b)
below_avg <- scores <= avg_score
below_avg
#c)
above_avg <- scores > avg_score
above_avg
#d)
count_below_avg <- sum(below_avg)
count_below_avg
#e)
count_above_avg <- sum(above_avg)
count_above_avg

#**************************************************************
#Q3
#a)
scores_below_avg <- scores[scores <= avg_score]
scores_below_avg
#b)
scores_above_avg <- scores[scores > avg_score]
scores_above_avg

#***************************************************************
#Q4
#a)
odd_index_values <-scores[c(1:n)%%2 ==1]
odd_index_values
#b)
even_index_values<- scores[c(1:n)%%2 ==0]
even_index_values

#*****************************************************************
#Q5
#a)
format_scores_version1 <- paste(LETTERS[1:n],scores,sep = "=")
format_scores_version1
#b)
format_scores_version2<- paste(LETTERS[n:1],scores,sep = "=")
format_scores_version2

#********************************************************************
#Q6
#a)
score_matrix <- matrix(scores,nrow = 2,ncol = n/2,byrow = TRUE)
score_matrix

#b)
#first and last column will have all rows but first and last column. first
#column has index 1 and last column has index of total columns number.
first_and_last_version1 <-score_matrix[,c(1,ncol(score_matrix))]
first_and_last_version1

#**********************************************************************
#Q7
#a)
named_matrix <- score_matrix
colnames(named_matrix) <- paste("Student",1:ncol(named_matrix),sep = "_")
rownames(named_matrix)<- paste("Quiz",1:nrow(named_matrix),sep = "_")
named_matrix

#b)
first_and_last_version2 <- named_matrix[,c(1,ncol(named_matrix))]
first_and_last_version2  
#************************************************************************

  
  
  
  
  
  
  
  
