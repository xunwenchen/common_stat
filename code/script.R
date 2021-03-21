# script for analysis ####
# load dummy data
library(readxl)
data<-read_excel('data/data.xlsx')
head(data)
str(data)
data$cd<-as.factor(data$cd)
data$as<-as.factor(data$as)
data$sp<-as.factor(data$sp)
head(data)
summary(data$cd)
summary(data$as)
summary(data$sp)
summary(data$rt_cd)
