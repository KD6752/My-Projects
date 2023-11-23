df <- read.csv("/Users/kokildhakal/Desktop/STUDY/finalproject/House_Prediction_Data.csv")
df
library(sampling)
library(Metrics)
library(caTools)
set.seed(1234)

df <-select(df,LotArea,OverallQual,YearBuilt,GrLivArea,SalePrice)
head(df)
df <- na.omit(df)
nrow(df)
#splitting the datasets


split <- sample.split(df,SplitRatio = 0.7)

train <- subset(df,split=="TRUE")
test <- subset(df,split=="FALSE")

model <- lm(SalePrice ~.,data=train)
summary(model)
pred <- predict(model,test)
pred
plot(test$SalePrice,type = "l",lty=1.8,col="red")
lines(pred,type = "l",lty=1.8,col="blue")

mse <- mse(test$SalePrice,pred)
r_squared <- R2(test$SalePrice,pred)

??Metrics
rmse <- sqrt(mean(pred-))
#------------------------------------------------------------
library(ggplot2)
library(tidyverse)

data <-read.csv("/Users/kokildhakal/Downloads/archive/Global cancer incidence both sexes.csv") 

colnames(data)
data1 <- data[-1,]
data1
data <- as_tibble(data1)
data


#par(mar=c(14,8,4,4))
#barplt <- barplot(height = data$`New cases in 2020`,width = 1,space = 0.4,names.arg = data$Cancer,beside = TRUE,col = data$`New cases in 2020`,
                  main ="Most afected body part by Cancer",las=2)




numin_th <- round(data$`New cases in 2020`/1000)
numin_th


plot_ly(x=data$Cancer,y=data$`New cases in 2020`,type = "bar",color = data$Cancer,sizes = 5) %>% 
  add_text(x=data$Cancer,y=data$`New cases in 2020`,text = round(data$`New cases in 2020`/1000),textpotition="top",color="black")







ggplot(data = data,mapping = aes(x=reorder(Cancer, -New.cases.in.2020),y=`New.cases.in.2020`,col=Cancer,fill=Cancer,size=2),hjust=5)+
  geom_bar(stat = "identity")+
  geom_text(aes(label=paste(round(New.cases.in.2020/1000),"K")),vjust=0.5,size=3.5,color="black",angle=90,check_overlap = TRUE)+
  theme(axis.text.x = element_text(angle=90,size = 11,hjust = 0.5,vjust = 1,lineheight = 5,face = "bold"))+
  theme(legend.position = "none")+
  ggtitle("Number of different types of Cancer in thousands")+
  labs(x="Types of Cancer",y="Number of Cancer")




#---------------------------------------
#prediting cancer
set.seed(1234)
cardio <- read.csv("/Users/kokildhakal/Desktop/Plots/datasets/cardio datasets/medical_examination.csv",header = TRUE)
cardio <- cardio[-1]
cardio
split1 <- sample.split(cardio,0.8)
split1
train1 <- subset(cardio,split1=="TRUE")
train1$cardio <- factor(train1$cardio)
train1
test1 <- subset(cardio,split1=="FALSE")
head(test1)
nrow(test1)
head(train1)
nrow(train1)
nrow(cardio)

model1 <- glm(cardio ~.,family = "binomial",data = train1)
pred1 <- predict(model1,test1,type = "response")
pred1

#validation
convmatrix <- table(actual_value=test1$cardio,predicted_value=pred1 >0.5)
convmatrix
# accuracy
(convmatrix[[1,1]]+convmatrix[2,2])/sum(convmatrix)

#------------------------------------------------------
library(caret)
train_control <- trainControl(method = "cv",number = 10)
hyperparameters <- data.frame(.pentaly=c("l1","l2"),.c=c(0.1,1,10,10))
hyperparameters
model_tuned <- train(cardio ~.,data = train1,method="glm",
                     trControl=train_control)
print(model_tuned)


#decision Tree
library(data.tree)
library(rpart.plot)


cardio["bmi"] <- round(cardio$weight/(cardio$height/100)**2,2)


cardio
cardio$sex <- factor(cardio$sex)
cardio$cholesterol <- factor(cardio$cholesterol)
cardio$gluc <- factor(cardio$gluc)
cardio$smoke <- factor(cardio$smoke)
cardio$alco <- factor(cardio$alco)
cardio$active <- factor(cardio$active)
cardio$cardio <- factor(cardio$cardio)
cardio <- cardio[c(-3,-4)]
head(cardio)

#split the data
set.seed(1234)


sample <- sample.split(cardio,SplitRatio = 0.8)
train2 <- subset(cardio,sample==TRUE)
test2 <- subset(cardio,sample==FALSE)
tree <-rpart::rpart(cardio~.,data=train2)
predict2 <- predict(tree,test2,type = "class")

#confustion matrix
confusionMatrix(predict2,test2$cardio)
#visualize
prp(tree)

#random forest
library(randomForest)

#-----------------------------------------------------------------------------
cardio <- cardio[-1]
cardio["bmi"] <- round(cardio$weight/(cardio$height/100)**2,2)
cardio <- cardio[c(-3,-4)]
cardio$sex <- factor(cardio$sex)
cardio$cholesterol <- factor(cardio$cholesterol)
cardio$gluc <- factor(cardio$gluc)
cardio$smoke <- factor(cardio$smoke)
cardio$alco <- factor(cardio$alco)
cardio$active <- factor(cardio$active)
cardio$cardio <- factor(cardio$cardio)
cardio.df <- cardio
head(cardio)
nrow(cardio)

train_cont <- trainControl(method = "cv",number = 10)
train
model1 <- train(cardio~.,data = cardio.df,method ="glm",trControl=train_cont)

model2 <- train(cardio~.,data = cardio.df,method ="rpart",trControl=train_cont)
model3 <- train(cardio~.,data = cardio.df,method ="svmRadial",trControl=train_cont)
print(model1)
print(model2)
print(model3)
install.packages('devtools')
devtools::install_github('thomasp85/gganimate')
library(gganimat)