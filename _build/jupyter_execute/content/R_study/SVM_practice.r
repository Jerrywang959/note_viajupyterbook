# SVM练习
## 加载和浏览数据集

quality=read.csv("/home/jerrywang/GitHub/note_viajupyterbook/datas/Diabetes.csv")

str(quality)

MemberID是从1到131 对患者进行编号的唯一标识符。   
InpatientDays是住院次数或患者在医院度过的天数。   
ERVisits是患者访问急诊室的次数。   
OfficeVisits是患者拜访任何医生办公室的次数。   
Narcotics是患者对麻醉剂开出的处方数量。   
DaysSinceLastERVisit是患者上次急诊室（ER）到研究期结束之间的天数，如果患者从未去过ER，则将其设置为研究期的长度。   
Pain是患者抱怨疼痛的就诊次数。     
TotalVisits是患者拜访任何医疗保健提供者的总次数。      
ProviderCount是为患者提供服务的提供者的数量。    
MedicalClaims是患者提出医疗要求的天数。   
ClaimLines是医疗索赔的总数。   
StartedOnCombination是患者是否开始使用药物组合治疗糖尿病。   
AcuteDrugGapSmall是处方用完后迅速补充的急性药物的一部分。   
PoorCare是因变量，如果患者护理不佳，则等于1，如果患者护理得好，则等于0。   

percPC = sum(quality$PoorCare)/nrow(quality)
percPC

在SVM模型中，需要将因变量的值设为-1或1。将Poorcare 0更改为Poorcare -1

quality$PoorCare[which(quality$PoorCare==0)]=-1

将Poorcare更改为因子变量。

quality$PoorCare=as.factor(quality$PoorCare)
str(quality$PoorCare)

table(quality$PoorCare)

## 分割数据集以进行培训和测试

library(caTools)

set.seed(123)
split = sample.split(quality$PoorCare, SplitRatio = 0.70)

qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)

table(qualityTrain$PoorCare)

table(qualityTest$PoorCare)

## 建立SVM模型

现在，我们准备好使用OfficeVisits和Narcotics作为自变量来构建SVM模型，与上一讲一致。在此之前，让我们减少无用的变量。

Train=qualityTrain[,c(4,5,14)]
Test=qualityTest[,c(4,5,14)]

plot(Train[,c(-3)], col=(2+as.numeric(Train[,3])))
legend("topleft", legend=c("Good Care", "Poor Care"),     col=3:4, pch=1, cex=0.8)

装载包 "e1071"，这个包涵盖了潜在类分析，短时傅立叶变换，模糊聚类，支持向量机，最短路径计算，袋装聚类，朴素贝叶斯分类器等功能

library(e1071)

函数`svmfit`用于拟合SVM模型，第一个参数是模型的公式，在这里，我们仍然使用PoorCare〜OfficeVisits + Narcotics。二个参数指示用于训练模型的数据集。参数cost的意思是约束违反的成本，即惩罚因子C。scale=TRUE (default) 使数据在内部（x和y变量）均缩放为零均值和单位方差

svmfit=svm(PoorCare ~Narcotics+ OfficeVisits, data=Train, kernel="linear", cost=10)
plot(svmfit, Train)

用`svmfit$index`列出支持的向量

svmfit$index

summary(svmfit)

选择一个更小的成本函数

svmfit=svm(PoorCare ~Narcotics+ OfficeVisits, data=Train, kernel="linear", cost=1)
plot(svmfit, Train)

把线性的kernel换成RBF kernel。    
gamma可以看作是sigma的倒数（？）  exp(-gamma|x-z|^2)

svmfit=svm(PoorCare ~Narcotics+ OfficeVisits, data=Train, kernel="radial",  gamma=2, cost=10)
plot(svmfit, Train)

选择更小的成本函数

svmfit=svm(PoorCare ~Narcotics+ OfficeVisits, data=Train, kernel="radial",  gamma=2, cost=1)
plot(svmfit, Train)

## 样本内交叉验证

`tune()`函数可以帮助我们从一组选择中调整诸如`cost`，`kernel`，`gamma`等参数。这可能需要很多时间。

set.seed(123)
tune.out=tune(svm,PoorCare ~Narcotics+ OfficeVisits, data=Train, scale=TRUE, ranges=list(kernel=c("radial","polynomial","sigmoid"),cost=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1),gamma=c(0.025,0.05,0.075,0.1,0.2,0.3,0.5,0.6,0.7,0.8,0.9,1,1.2)))
bestmod=tune.out$best.model
summary(bestmod)

绘制最佳模型：

plot(bestmod, Train)

并且我们得到以下具有最佳模型的混淆矩阵。

predictTrain = predict(bestmod, type = "response")
conf1=table(Train$PoorCare, predictTrain)
conf1

样本内准确度是76/92 = 82.61％。

## 样本外模型测试

同样，我们可以使用测试数据集对模型进行样本外测试。我们首先在测试集中绘制数据：

plot(Test[,c(-3)], col=(2+as.numeric(Test[,3])))
legend("topleft", legend=c("Good Care", "Poor Care"),     col=3:4, pch=1, cex=0.8)

并且我们得到以下具有最佳模型的混淆矩阵用于新的预测。

predictTest = predict(bestmod, type = "response", newdata = Test)
conf2=table(Test$PoorCare, predictTest)
conf2

最佳模型的样本外准确性为31/39 = 79.49％。对于此特定数据集，SVM具有与逻辑回归相同的性能。