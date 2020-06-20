# kaggle competition 2 
## 加载和浏览数据集
加载包

library(e1071)
library(caTools)
library(ROCR)
library(pROC)


加载数据

Trainraw=read.csv("../../datas/kaggle_2_Train.csv")
Testraw=read.csv("../../datas/kaggle_2_Test.csv")
str(Trainraw)

League与Team变量应该是Factor变量而非chr变量，下面作数据类型转换

Trainraw$League = as.factor(Trainraw$League )
Trainraw$Team = as.factor(Trainraw$Team)
str(Trainraw)

## 对数据变量做可视化分析

par=(pin=c(20,10))
with(Trainraw,
     plot(RS,Team,
          main="季后赛与队伍RS关系图",
          xlab="RS",ylab="Team",
          pch=16,
          col=ifelse(Playoffs=="1","blue","red"),
          cex=0.20
          ))

par=(pin=c(20,10))
with(Trainraw,
     plot(RA,Team,
          main="季后赛与队伍RA关系图",
          xlab="RA",ylab="Team",
          pch=16,
          col=ifelse(Playoffs=="1","blue","red"),
          cex=0.20
          ))

par=(pin=c(20,10))
with(Trainraw,
     plot(W,Team,
          main="季后赛与队伍W关系图",
          xlab="W",ylab="Team",
          pch=16,
          col=ifelse(Playoffs=="1","blue","red"),
          cex=0.20
          ))


par=(pin=c(20,10))
with(Trainraw,
     plot(OBP,Team,
          main="季后赛与队伍OBP关系图",
          xlab="OBP",ylab="Team",
          pch=16,
          col=ifelse(Playoffs=="1","blue","red"),
          cex=0.20
          ))

par=(pin=c(20,10))
with(Trainraw,
     plot(SLG,Team,
          main="季后赛与队伍SLG关系图",
          xlab="SLG",ylab="Team",
          pch=16,
          col=ifelse(Playoffs=="1","blue","red"),
          cex=0.20
          ))

分割数据集

set.seed(221)
split = sample.split(Trainraw$Playoffs, SplitRatio = 0.70)

MyTrain = subset(Trainraw, split == TRUE)
MyTest = subset(Trainraw, split == FALSE)

## 逻辑回归
### 仅使用 OBP+SLG 双变量

logis_train <- function(threhold){
  QualityLog = glm(Playoffs ~ OBP+SLG, data = MyTrain, family = binomial)
  predictTest = predict(QualityLog, type = "response", newdata = MyTest)
  output=table(MyTest$Playoffs, predictTest > threhold)
  error=(output[1,2]+output[2,1])/sum(output)
  return(error)
  }

logis_train(0.43)

x= seq(from=0.2, to=0.63, by=0.001)
y=c()
k=1
for(i in x){
  y[k]=logis_train(i)
  k=k+1
  }
plot(x,y)

QualityLog = glm(Playoffs ~ OBP+SLG, data = MyTrain, family = binomial)
summary(QualityLog)

训练集验证及阈值筛选

PatoffTrain_1 = predict(QualityLog, type = "response")
summary(PatoffTrain_1)

tapply(PatoffTrain_1, MyTrain$Playoffs, mean)

conf05=table(MyTrain$Playoffs,PatoffTrain_1 > 0.5)
conf05

#### 画ROC

ROCRpred = prediction(PatoffTrain_1, MyTrain$Playoffs)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf, colorize = TRUE, print.cutoffs.at = seq(0,1,0.1), text.adj = c(-0.2,1.7))

计算AUC

ROCRauc = performance(ROCRpred, "auc")
ROCRauc@y.values

plot.roc(MyTrain$Playoffs, PatoffTrain_1, 
    auc.polygon = TRUE, 
    auc.polygon.col=rgb(.35,0.31,0.61, alpha = 0.4), 
    auc.polygon.border=rgb(.35,0.31,0.61, 0.4))

### 测试集验证

predictTest = predict(QualityLog, type = "response", newdata = MyTest)
conf03out = table(MyTest$Playoffs, predictTest > 0.5)
conf03out

ROCRpredTest = prediction(predictTest, MyTest$Playoffs)
ROCRperfTest = performance(ROCRpredTest, "tpr", "fpr")
plot(ROCRperfTest, colorize = TRUE, print.cutoffs.at = seq(0,1,0.2), text.adj = c(-0.2,1.7))

####  预测

predictTest = predict(QualityLog, type = "response", newdata = Testraw)

x <-data.frame(Id=Testraw$Id,Playoffs=predictTest)
x$Playoffs[which(x$Playoffs<0.43)]=0
x$Playoffs[which(x$Playoffs>0.43)]=1

输出数据

write.csv(x,"../../output/O_S_output.csv",row.names=FALSE)

## SVM

Trainraw

MyTrain$Playoffs[which(MyTrain$Playoffs==0)]=-1
MyTrain$Playoffs=as.factor(MyTrain$Playoffs)
MyTest$Playoffs[which(MyTest$Playoffs==0)]=-1
MyTrain

SVM_Train_1=MyTrain[,c(8,9,10,11,14)]
svmfit=svm(Playoffs ~OBP+ SLG+BA+G, data=SVM_Train_1, kernel="linear", cost=1)
svmtest_1=MyTest[,c(8,9,10,11,14)]
predictTest = predict(svmfit, type = "response", newdata = svmtest_1)
conf2=table(svmtest$Playoffs, predictTest)
conf2

SVM_Train_2=MyTrain[,c(8,9,10,11)]
svmfit=svm(Playoffs ~OBP+ SLG+BA, data=SVM_Train_1, kernel="linear", cost=1)
svmtest_2=MyTest[,c(8,9,10,11)]
predictTest = predict(svmfit, type = "response", newdata = svmtest_2)
conf2=table(svmtest$Playoffs, predictTest)
conf2

调参优化

set.seed(3214)
tune.out=tune(svm,Playoffs ~G +OBP +SLG +BA , data=SVM_Train_1, scale=TRUE, ranges=list(kernel=c("radial","polynomial","sigmoid"),cost=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1),gamma=c(0.025,0.05,0.075,0.1,0.2,0.3,0.5,0.6,0.7,0.8,0.9,1,1.2)))
bestmodSVM=tune.out$best.model
summary(bestmodSVM)

检验最优SVM的预测精度：

PredictSVM2 = predict(bestmodSVM,type="response")
confsvm2 = table(SVM_Train_1$Playoffs,PredictSVM2)
accuracySvm2= (confsvm2[1,1]+confsvm2[2,2])/sum(confsvm2) *100
accuracySvm2

检测样本外精度

PredictSVM2 = predict(bestmodSVM,type="response",newdata=svmtest_1)
confsvm2 = table(svmtest_1$Playoffs,PredictSVM2)
accuracySvm2= (confsvm2[1,1]+confsvm2[2,2])/sum(confsvm2) *100
accuracySvm2

