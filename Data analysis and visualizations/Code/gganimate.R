library(gganimate)
library(ggplot2)
library(tidyverse)
library(gganimate)

disease_data <- read.csv("/Users/kokildhakal/Desktop/STUDY/BU/7.CS544/Final Project/cause_of_deaths.csv")

disease_data_usa <- subset(disease_data,disease_data$Country.Territory=="United States")

disease_data_nepal <- subset(disease_data,disease_data$Country.Territory=="Nepal")

south.asia <- c("Afghanistan","India","Nepal","Bangladesh","Bhutan","Sri Lanka","Pakistan")
south.asia.data <- subset(disease_data,disease_data$Country.Territory %in% south.asia)


head(south.asia.data)[1:5]
hiv.tb <- south.asia.data %>% select(Year,HIV.AIDS,Tuberculosis) %>% group_by(Country=south.asia.data$Country.Territory) %>% 
  summarise(hiv=sum(HIV.AIDS),tb=sum(Tuberculosis))
head(hiv.tb)
ggplot(hiv.tb,aes(Country,hiv,color="green"))+
  geom_point()+
  geom_point(aes(x=Country,y=tb,color="pink"))


hiv.tb.year <- disease_data %>% select(Year,Country.Territory,HIV.AIDS,Tuberculosis,Drug.Use.Disorders,Neoplasms) %>% 
  group_by(Year) %>% summarise(hiv=sum(HIV.AIDS),tb=sum(Tuberculosis),drug=sum(Drug.Use.Disorders),cancer=sum(Neoplasms))
head(hiv.tb.year)                                                                
               

g.plot <- ggplot(hiv.tb.year,aes(Year,cancer))+
  geom_point(show.legend=FALSE)+
  geom_point(aes(x=Year,y=tb))+
  geom_point(aes(x=Year,y=hiv))

g.plot


g.plot+
  transition_time(Year)+
  enter_fade()+
  exit_fade()+
  ease_aes(default = "circular-in-out")+
  shadow_mark(colour="red",size=1,past = TRUE,future =FALSE)+
  shadow_trail(distance = 0.05)+
  transition_reveal(Year)+
  view_follow(fixed_y = TRUE)




south.plot <- ggplot(south.asia.data,aes(Year,Tuberculosis/1000))+
  geom_point(alpha=.9,aes(colour=Country.Territory,size=4))+
  theme_light()+
  labs(title = "Deaths by Tuberculosis in South East Asia(in thousands)",
       y="Tuberculosis Deaths")
#south.plot
south.anim <- south.plot+
  transition_time(Year)+
  enter_fade(alpha = 0.2)+
  exit_fade(alpha = 0.2)+
  ease_aes(default = "linear")+
  shadow_mark(size=3,past = TRUE,future =FALSE)+
  view_follow()

final.south <- gganimate::animate(south.anim,height=5,width=8,units="in",res=100,fps = 7,
                   start_pause = 4)
#anim_save("Tb.south.gif",animation = final.south,path ="/Users/kokildhakal/Desktop/Plots/Plots")


hiv.plot <- ggplot(south.asia.data,aes(Year,HIV.AIDS/1000))+
  geom_point(alpha=.9,aes(colour=Country.Territory,size=3))+
  theme_classic()+
  labs(title = "Deaths by HIV/AIDS in South East Asia(in thousands)",
       y="HIV/AIDS Deaths")

hiv.anim <- hiv.plot+
  transition_time(Year)+
  shadow_mark(size=3,past = TRUE,future = FALSE)+
  shadow_trail(distance = 0.05)
  enter_fade(alpha = 0.4)+
  exit_fade(0.4)+
  ease_aes(default = "linear")+
  view_follow(exclude_layer = 2)



gganimate::animate(hiv.anim,height=5,width=7.3,units="in",res=100,fps = 7)


#------------------------------------------------------------------------------

world.data <- read.csv("/Users/kokildhakal/Desktop/Plots/datasets/world-data-2023.csv")
head(world.data)
health <- world.data %>% select(Country,Out.of.pocket.health.expenditure) %>% arrange(Out.of.pocket.health.expenditure)
health
health.expend <- str_replace_all(health$Out.of.pocket.health.expenditure,"%","")
health.data <- cbind(health$Country,health.expend)
health.data["health.expend"] <- as.double(health.data["health.expend"])
health.data

%>% tail(10) %>% 
  ggplot(aes(Country,Out.of.pocket.health.expenditure))+
  geom_point()
