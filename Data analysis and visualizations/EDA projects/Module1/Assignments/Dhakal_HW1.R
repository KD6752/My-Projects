#Question 1(Q1)
# a)
scores <- c(40,88,60,23,76,51,59,99,96,34)

#b) lenth of itmes
n <- length(scores)
n
#c) first and second items
first_and_second <- scores[c(1,2)]
first_and_second

#d) first and last items 
first_and_last <- scores[c(1,n)]
first_and_last
#e) middle two items
middle_two <- scores[c(n/2,n/2+1)]
middle_two

#Question 2 (Q2)

#a)average scores
avg_score <- mean(scores)
avg_score

#b)comparision
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

#Q3
#a)
scores_below_avg <- scores[(scores)<(avg_score)]
scores_below_avg
#b)
scores_above_avg <- scores[scores > avg_score]
scores_above_avg

#Q4

#a)
odd_index_values <- scores[seq(1,n,2)]
odd_index_values
#b)
even_index_values <- scores[seq(2,n,2)]
even_index_values

#Q5
#a)
format_scores_version1 <- paste(LETTERS[1:n],scores,sep = "=")
format_scores_version1
#b)
format_scores_version2 <- paste(LETTERS[n:1],scores,sep = "=")
format_scores_version2

#Q6
#a)
score_matrix <- matrix(scores,nrow = 2,byrow = TRUE)

score_matrix

#b)
first_and_last_version1<- score_matrix[,c(1,ncol(score_matrix))]
first_and_last_version1

#Q7
#a)
named_matrix <-score_matrix
dimnames(named_matrix)<- list(paste("Quiz",c(1:nrow(score_matrix)),sep = "_"),
                              paste("Student",c(1:ncol(score_matrix)),sep = "_"))
named_matrix

#b)
first_and_last_version2 <- named_matrix[,c(1,ncol(named_matrix))]
first_and_last_version2






