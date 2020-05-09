预测葡萄酒的质量
# 读取并初步探索数据

wine = read.csv("/home/jerrywang/GitHub/note_viajupyterbook/mynote/datas/Wine.csv")
str(wine)

summary(wine)

画图以直观地反映变量之间的关系

plot(wine$AGST, wine$Price)
abline(h = mean(wine$Price), col = "red")

# 建立线性模型

model1 = lm(Price ~ AGST, data = wine)
summary(model1)

plot(wine$AGST, wine$Price)
abline(h = mean(wine$Price), col = "red")
abline(model1, col = "green")

## 残差平方和
计算残差平方和

SSE1 = sum(model1$residuals^2)
SSE1

增加一个解释变量

model2 = lm(Price ~ AGST + HarvestRain, data = wine)
summary(model2)

计算新模型的残差平方和

SSE2 = sum(model2$residuals^2)
SSE2

再次增加变量并计算残差平方和

model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data = wine)
summary(model3)

SSE3 = sum(model3$residuals^2)
SSE3

# 改进模型
之前的模型中，年龄和法国人口都是微不足道的，我们怀疑存在多重共线性，因此我们先用`cor()`函数来计算数据中每个变量之间的相关系数

cor(wine)

`FrancePop`和`Age`的相关系数接近-1，存在很明显的相关性，画图以直观地表现这一结果

plot(wine$Age, wine$FrancePop)

在模型中减少一个变量，直观上我们觉得取消法国人口更加合适

model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data = wine)
summary(model4)

优化后的模型各个系数都很显著，这表明我们之前的模型是存在多重共线性，去掉一个变量后，很好的解决了这样的问题。   
我们也可以选择去掉年龄那一个变量，回归结果不会有太大的差异，但是从解释角度来看就存在不同。一方面，使用年龄的模型对经理和客户更友好。另一方面我们有理由怀疑，人口与价格的关系是虚假的，人口和价格的关系是通过人口和年龄的关系传导的。    
为了进一步的优化模型，我们可以选择删除一些变量，让我们尝试先来同时删除年龄和人口

model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data = wine)
summary(model5)

我们可以看到，r方有明显的下降，因此保留年龄这个变量是必要的。

# 测试模型
现在我们将使用我们训练好的模型来用测试集检验

wineTest = read.csv("/home/jerrywang/GitHub/note_viajupyterbook/jerrynote/datas/Wine_Test.csv")
str(wineTest)

我们可以调用`predict()`函数来进行检验

predictTest = predict(model4, newdata = wineTest)
predictTest

为了评估我们预测的准确性，我们可以计算样本外R平方。

SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST