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


