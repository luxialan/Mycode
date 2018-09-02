#1Data
# Data Exploration
# Data preprocessing

#2Model
# Model Selection/evaluation
#   Cross validation
# Inference
#   Jackknife and Bootstrap

#import data
library('gclus')
library('ggplot2')
library('dplyr')
library('randomForest')
df <- read.table('C:/Users/luxia/Desktop/final/recoded_data.txt')
year = 1:length(df$V1)

#Data preprocessing
#数据统计描述
summary(df)

#发现中位数和中值差别不大，数据没有偏离太多

#miss data
miss_num<-21
miss_rate<-miss_num/length(df[,1]) #miss rate 11.4%>5%
library(VIM)
aggr_plot <- aggr(df[-1], col = c('navyblue', 'red'), numbers=TRUE, sortVars=TRUE, 
                  labels=names(df[-1]), cex.axis=.7, gap=3, 
                  ylab=c("Histogram of missing data", "Pattern"))

len<-1:length(df[,1])
#imputated_data，服从二项分布，用已有数据估计二项分布并从中抽样填补
num_1<-length(which(df[4]==1))
num_0<-length(which(df[4]==0))
prob<-num_1/(num_1+num_0)
imputated_data<-rbinom(miss_num,1,prob)
data_index<-which(df[4]!='Na')
Na_index<-len[-data_index]
df[Na_index,4]<-imputated_data

#distribution of V2 V3 V5
d2<-ggplot(df, aes(x = df$V2, y = ..density..)) + geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) + geom_density()
d3<-ggplot(df, aes(x = df$V3, y = ..density..)) + geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) + geom_density()
d5<-ggplot(df, aes(x = df$V5, y = ..density..)) + geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) + geom_density()   
d5<-ggplot(df, aes(x = log(df$V5), y = ..density..)) + geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) + geom_density()   

shapiro.test(df$V2)
shapiro.test(df$V3)
shapiro.test(df$V4)
shapiro.test(df$V5)

qqnorm(df$V2)
qqline(df$V2)
qqnorm(df$V3)
qqline(df$V3)
qqnorm(df$V5)
qqline(df$V5)

#correlation picture

mydata<-df[-1]
mydata.corr<-abs(cor(df[-1]))
mycolors<- dmat.color(mydata.corr)
myorder<-order.single(mydata.corr)
cpairs(mydata, myorder, panel.colors=mycolors, gap=.5, main="Variables Ordered and Colored by Correlation")

#分别观测V2和V3 V4 V5之间关系
p23<-ggplot(df) + geom_point(aes(x=len,y=df$V2,color=df$V3))
p24<-ggplot(df) + geom_point(aes(x=len,y=df$V2,color=df$V4))
p25<-ggplot(df) + geom_point(aes(x=len,y=df$V2,color=df$V5))
p34<-ggplot(df) + geom_point(aes(x=len,y=df$V3,color=df$V4))
p35<-ggplot(df) + geom_point(aes(x=len,y=df$V3,color=df$V5))

#model evaluation
#K fold cross validation
data<-df[-1]

K=5 #Folds
#sample from 1 to K
data$id<-sample(1:K,nrow(data),replace=TRUE)
list<-1:K

predict1 <- data.frame()
predict2 <- data.frame()
predict3 <- data.frame()
predict4 <- data.frame()
predict5 <- data.frame()
predict6 <- data.frame()
predict7 <- data.frame()
predict8 <- data.frame()
testsetCopy <- data.frame()
mse1<- data.frame()
mse2<- data.frame()
mse3<- data.frame()
mse4<- data.frame()
mse5<- data.frame()
mse6<- data.frame()
mse7<- data.frame()
mse8<- data.frame()

for(i in 1:K){
  # remove rows with id i from dataframe to create training set
  train_s<-subset(data,id %in% list[-i])
  test_s<-subset(data,id %in% list[i])
  
  #different model
  model1<-glm(formula=train_s$V2~train_s$V3, family="gaussian")
  model2<-glm(formula=train_s$V2~train_s$V4, family="gaussian")
  model3<-glm(formula=train_s$V2~train_s$V5, family="gaussian")
  model4<-glm(formula=train_s$V2~train_s$V3+train_s$V4, family="gaussian")
  model5<-glm(formula=train_s$V2~train_s$V4+train_s$V5, family="gaussian")
  model6<-glm(formula=train_s$V2~train_s$V3+train_s$V5, family="gaussian")
  model7<-glm(formula=train_s$V2~train_s$V3+train_s$V4+train_s$V5, family="gaussian")
  model8<-randomForest(train_s$V2~., data=train_s, ntree = 100)
  
  temp1<-as.data.frame(predict(model1, test_s[,-1]))
  temp2<-as.data.frame(predict(model2, test_s[,-1]))
  temp3<-as.data.frame(predict(model3, test_s[,-1]))
  temp4<-as.data.frame(predict(model4, test_s[,-1]))
  temp5<-as.data.frame(predict(model5, test_s[,-1]))
  temp6<-as.data.frame(predict(model6, test_s[,-1]))
  temp7<-as.data.frame(predict(model7, test_s[,-1]))
  temp8<-as.data.frame(predict(model8, test_s[,-1]))
  
  predict1<-rbind(predict1, temp1)
  predict2<-rbind(predict2, temp2)
  predict3<-rbind(predict3, temp3)
  predict4<-rbind(predict4, temp4)  
  predict5<-rbind(predict5, temp5)    
  predict6<-rbind(predict6, temp6)  
  predict7<-rbind(predict7, temp7)    
  predict8<-rbind(predict8, temp8)  
  
  testsetCopy<-rbind(testsetCopy, as.data.frame(test_s[,1]))
  mse1<-rbind(mse1,mean((test_s[,1]-temp1)^2))
  mse2<-rbind(mse1,mean((test_s[,1]-temp2)^2))
  mse3<-rbind(mse1,mean((test_s[,1]-temp3)^2))
  mse4<-rbind(mse1,mean((test_s[,1]-temp4)^2))
  mse5<-rbind(mse1,mean((test_s[,1]-temp5)^2))
  mse6<-rbind(mse1,mean((test_s[,1]-temp6)^2))
  mse7<-rbind(mse1,mean((test_s[,1]-temp7)^2))
  mse8<-rbind(mse1,mean((test_s[,1]-temp8)^2))
}






















