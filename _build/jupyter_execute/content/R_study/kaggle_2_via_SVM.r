# kaggle competition 2 
## 加载和浏览数据集
加载包

library(e1071)
library(caTools)

加载数据

Trainraw=read.csv("../../datas/kaggle_2_Train.csv")
Testraw=read.csv("../../datas/kaggle_2_Test.csv")
str(Trainraw)

分割数据集

set.seed(123)
split = sample.split(Trainraw$Playoffs, SplitRatio = 0.70)

MyTrain = subset(Trainraw, split == TRUE)
MyTest = subset(Trainraw, split == FALSE)

## 逻辑回归
### 仅使用 OBP+SLG 双变量

QualityLog = glm(Playoffs ~ OBP+SLG, data = MyTrain, family = binomial)
summary(QualityLog)

训练集验证及阈值筛选

PatoffTrain_1 = predict(QualityLog, type = "response")
summary(PatoffTrain_1)

tapply(PatoffTrain_1, MyTrain$Playoffs, mean)

conf05=table(MyTrain$Playoffs,predictTrain > 0.4)
conf05

画ROC曲线

