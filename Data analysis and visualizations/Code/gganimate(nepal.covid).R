library(gganimate)
library(ggplot2)
library(tidyverse)
library(gganimate)
library(lubridate)

df=read_csv("/Users/kokildhakal/Desktop/STUDY/IT training/More Machine Learning projects/datasets/Mall_Customers.csv.xls")
head(df)
str(df)
df$Gender <- factor(df$Gender)
df$Income <- df$`Annual Income (k$)`
df$score <- df$`Spending Score (1-100)`
df1 <- df %>% select(Gender,Age,Income,score)
str(df1)
# plot of age vs income
ggplot(data = df1,mapping = aes(x=Age,y=Income,colour=Gender))+
  geom_point()

#plot incove vs spending score
ggplot(data = df1,mapping = aes(x=Income,y=score,colour=Gender))+
  geom_point()

#
ggplot(data = df1,mapping = aes(x=Age,y=Income,colour=Gender))+
  geom_



vid_us <- read.csv("/Users/kokildhakal/Downloads/archive/USvideos.csv")
vid_us <- as_tibble(vid_us)
head(vid_us)
vid_us$trending_date <- as.Date(vid_us$trending_date)

str(vid_us)
views <- vid_us %>% group_by(trending_date) %>% summarise(vid=count())


disease <- read.csv("/Users/kokildhakal/Desktop/STUDY/BU/7.CS544/Final Project/cause_of_deaths.csv")
head(disease)[,1:5]
disease_nep <- disease %>% filter(Country.Territory=="Nepal")
colnames(disease_nep)
disease_nep$Protein.Energy.Malnutrition

south.asia <- c("Afghanistan","India","Nepal","Bangladesh","Bhutan","Sri Lanka","Pakistan","Afghanistan")
south.asia.data <- subset(disease,disease$Country.Territory %in% south.asia)
head(south.asia.data)
colnames(south.asia.data)
unique(south.asia.data$Country.Territory)

drug_use_disorder_sasia <- south.asia.data %>% select(Country.Territory,Year,Drug.Use.Disorders)
head(drug_use_disorder_sasia)
write.csv(df, file = "drug_use_disorder_sasia.csv")

malnutri_south_asia <- ggplot(data = south.asia.data,mapping = aes(x=Year,y=`Protein.Energy.Malnutrition`/1000,color=`Country.Territory`))+
  geom_point(size=3,alpha=0.9)+
  theme(legend.position =c(0.87,0.75),legend.direction = 'vertical',
        legend.background = element_rect(fill = "lightblue"))+
  labs(title = "Deaths from Protein/Energy/Malnutrition over the Period of 20 Years In South East Asian Region",
       y="Deaths from Malnutrition In Thousands")


south.anim <- malnutri_south_asia+
  transition_time(Year)+
  enter_fade(alpha = 0.2)+
  exit_fade(alpha = 0.2)+
  ease_aes(default = "cubic-in-out")+
  shadow_mark(size=3,past = TRUE,future =FALSE)+
  view_follow()

final.plot <- gganimate::animate(south.anim,height=5,
                                 width=7.3,units="in",res=100,fps = 7,
                                  start_pause = 4)

final.plot

