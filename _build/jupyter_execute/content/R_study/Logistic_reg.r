# 加载和浏览数据集

quality = read.csv("/home/jerrywang/GitHub/note_viajupyterbook/mynote/datas/Diabetes.csv")
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

通过使用`table()`，我们可以看到有多少患者接受了较差的护理，有多少患者获得了良好的护理。

table(quality$PoorCare)

护理不佳的患者百分比可以如下计算。

percPC = sum(quality$PoorCare)/nrow(quality)
percPC

summary(quality$PoorCare)

数据中`PoorCare`是数值变量，但是从实际问题出发，我们应该将其转化为类别变量

quality$PoorCare = as.factor(quality$PoorCare)
str(quality)

# 分割数据集以进行训练和测试
通常，我们有训练集和测试集，然而在现实情况下，我们只有一个数据集。因此我们将用到`caTools`这一库，以完成随机的训练集和测试集的分配

library(caTools)

设置`seed`以便于每次每次生成的是相同的随机数，这样有助于检验结果

set.seed(123)
split = sample.split(quality$PoorCare, SplitRatio = 0.70)
split

`sample.split()`函数中的第一个参数确保训练集和测试集合`PoorCare`的比例是相同的。

让我们使用`subset()`创建训练和测试集。`TRUE`表示我们应该将该观察结果放入训练集中，而`FALSE`意味着我们应该将该观察结果放入测试集中。

qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)

我们可以检查训练集和测试集中的数据点数量，并确认接受不良护理的患者比例确实与整个数据集相似。

table(qualityTrain$PoorCare)

table(qualityTest$PoorCare)

# 建立Logistic回归模型
使用函数`glm()`表示广义线性模型，参数`family = binomial`表示我们正在尝试预测两种可能的结果，以便从广义线性模型的类别中调用逻辑回归模型。

QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data = qualityTrain, family = binomial)
summary(QualityLog)

`AIC`是模型质量的量度，类似于调整$R^2$。因为它说明了所使用的变量数与观测值数之比。它提供了一种模型选择的方法，但是只能使用它来比较基于相同数据集构建的模型。

首选模型是具有最小AIC的模型。最后一行与用于计算系数（通过解决优化问题）的算法（默认情况下为Newton-Raphson算法或Newton方法）有关。

# 样品中模型验证
## 敏感性和特异性（ReCall）
`type = "response"`确保算法使用逻辑响应函数来计算预测

predictTrain = predict(QualityLog, type = "response")
summary(predictTrain)

让我们看一下训练集中前十名患者接受不良护理的预期概率，并将其与实际观察结果进行比较。

predictTrain[1:10]

qualityTrain$PoorCare[1:10]

通过输出均值查看模型是否如我们预期的那样为实际的`PoorCare`案例预测了更高的概率。

tapply(predictTrain, qualityTrain$PoorCare, mean)

如果使用0.5作为阈值，则会得到以下混淆矩阵。

conf05 = table(qualityTrain$PoorCare, predictTrain > 0.5)
conf05

我们在预测`PoorCare`的情况下犯了3个错误，但`Caregood`；在预测`Caregood`的好的情况下犯了13个错误，但是`PoorCare`。     

预测准确性为$76/92 = 82.61\%$

灵敏度或真实阳性率（$=10/23 = 0.43$）

特异性或真实阴性率（$=66/69 = 0.96$）。

尝试提高阈值或者降低阈值

conf07 = table(qualityTrain$PoorCare, predictTrain > 0.7)
conf07

conf02 = table(qualityTrain$PoorCare, predictTrain > 0.2)
conf02

通过增加阈值，敏感性下降，特异性上升；通过降低阈值，敏感性提高，特异性降低

# ROC曲线
又叫接收者操作特征曲线

package `ROCR`负责画出ROC曲线

library(ROCR)

用训练集的预测创建ROC曲线

ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf)

为ROC图添加更多视觉效果。

plot(ROCRperf, colorize = TRUE, print.cutoffs.at = seq(0,1,0.1), text.adj = c(-0.2,1.7))

现在我们计算ROC曲线下面的面积，即AUC

ROCRauc = performance(ROCRpred, "auc")
ROCRauc@y.values

为ROC曲线下的区域着色，使用`pROC`包中的`plot.roc`功能

library(pROC)

plot.roc(qualityTrain$PoorCare, predictTrain, 
    auc.polygon = TRUE, 
    auc.polygon.col=rgb(.35,0.31,0.61, alpha = 0.4), 
    auc.polygon.border=rgb(.35,0.31,0.61, 0.4))

默认情况下,`plot.roc`,x轴是特异性，等于（1-假阳性率），数字从1到0从左到右

# 样本外模型验证

predictTest = predict(QualityLog, type = "response", newdata = qualityTest)
conf03out = table(qualityTest$PoorCare, predictTest > 0.3)
conf03out

阈值为0.3的模型的样本外准确性$为31/39 = 79.49\%$。我们还可以绘制模型的样本外ROC并计算其样本外AUC。

ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
ROCRperfTest = performance(ROCRpredTest, "tpr", "fpr")
plot(ROCRperfTest, colorize = TRUE, print.cutoffs.at = seq(0,1,0.2), text.adj = c(-0.2,1.7))