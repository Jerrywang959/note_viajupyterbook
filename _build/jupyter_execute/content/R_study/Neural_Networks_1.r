# 多层感知机
为二手丰田卡罗拉定价
## 加载和预处理数据集

library(mxnet)
library(caret)
library(forecast)

读取数据,并转化成dataframe

toyota.df <- read.csv("https://github.com/Jerrywang959/note_viajupyterbook/raw/master/datas/ToyotaCorolla.csv")
str(toyota.df)

我们用`Age_08_04, KM, Fuel_Type, HP, Automatic, Doors, Quarterly_Tax, Mfr_Guarantee, Guarantee_Period, Airco, Automatic_airco, CD_Player, Powered_Windows, Sport_Model and Tow_Bar`来预测价格,因此删除不需要的变量

toyota=toyota.df[,-c(1,2,5,6,10,11,13,15,16,18,20,22,23,24,27,29,31,32,33,35,36,37,38)]
str(toyota)

把字符串类型变量`Fuel_Type`转化为虚拟变量.因为Fuel_Type有三种类型的字符串 Fuel_Type=="CNG" 则赋值`Fuel_Type_CNG`为1. Fuel_Type=="Diesel"则赋值`Fuel_Type_Diesel`为1.最后删除`Fuel_Type`这一变量

toyota$Fuel_Type_CNG <- 1* (toyota$Fuel_Type == "CNG")
toyota$Fuel_Type_Diesel <- 1* (toyota$Fuel_Type == "Diesel")
toyota=toyota[,-4]
str(toyota)

对于价格,一般都求log

toyota$Price=log(toyota$Price)

将数据集拆分为训练和验证集。我们在这里使用另一个函数`sample()`

set.seed(1)
train.index <- sample(row.names(toyota), 0.6*dim(toyota)[1])  
valid.index <- setdiff(row.names(toyota), train.index) 
train <- toyota[train.index, ]
valid <- toyota[valid.index, ]

我们首先在包插入符号中使用函数preProcess将数字变量缩放为0-1，并将转换保存到preProcValues。然后使用`predict()`将转换应用于数据。

preProcValues=preProcess(train,method = "range",rangeBounds = c(0,1))
trainTransformed <- predict(preProcValues, train)
validTransformed <- predict(preProcValues, valid)
str(validTransformed)

## 训练神经网络
我们将在包`mxnet`中使用`mx.mlp()`函数。数据和标签表示x和y。让我们首先创建它们。

train.x=data.matrix(trainTransformed[,2:17])
train.y=trainTransformed[,1]

`hidden_node`:隐藏层中的节点数。c(2,3)表示有2个隐藏层，第一个隐藏层具有2个神经元，第二个隐藏层具有3个。   
`out_node = 1`:由于是回归问题,因此在输出层中有1个节点   
`activation ="relu"`: 激活函数选择`relu`,也可以选择`Sigmoid,tanh`    
`out_activation ="rmse"`:输出层中的激活函数；对于分类问题，默认值为softmax。  
`array.layout ="rowmajor"`：如果row是数据的实例  
`num.round`：迭代次数   
`array.batch.size`：每个批次中的样本数 
`learning.rate`：梯度下降中的学习率  
`momentum`: 带有动量的梯度下降考虑了过去的梯度以平滑更新。它计算渐变的指数加权平均值，然后使用该渐变来更新您的权重。它比标准的梯度下降算法更快地工作。这是介于0到1之间的数字。   
`eval_metric`：  评估指标。分类问题可以使用mx.metric.accuracy


mx.set.seed(1)
model<-mx.mlp(train.x, train.y, hidden_node=c(4,4), activation = "tanh",out_node=1,out_activation="rmse",array.layout="rowmajor", num.round=50, array.batch.size=15, learning.rate=0.1, momentum=0.9, eval.metric=mx.metric.rmse)

生成的神经网络中的权重和偏差可以通过`model$arg.params`找到。

model$arg.params

## 预测验证集
使用训练有素的模型来预测测试集。这里的`predit()`将使用模型来预测valid.x。

valid.x=data.matrix(validTransformed[,2:17])
valid.y=validTransformed[,1]
preds = predict(model, valid.x, array.layout="rowmajor")
preds=as.vector(preds)

可以通过包装预测中的函数 `precision()` 计算预测精度。

accu=accuracy(preds, valid.y)
accu

有效均方根值为0.14 
ME：平均误差  
RMSE：均方根误差  
MAE：平均绝对误差   
MPE：平均百分比误差  
MAPE：平均绝对百分比误差  


## 调整模型
让我们降低学习率并增加迭代次数。并通过辍学简化模型。   
这里的dropout是`[0,1)`中的数字，其中包含从最后一个隐藏层到输出层的丢失率。

mx.set.seed(1)
model2<-mx.mlp(train.x, train.y, hidden_node=c(4,5), activation = "tanh",out_node=1, dropout=0.2, out_activation="rmse",array.layout="rowmajor", num.round=100, array.batch.size=15, learning.rate=0.05, momentum=0.9, eval.metric=mx.metric.rmse)

让我们检查准确性。

preds2 = as.vector(predict(model2, valid.x, array.layout="rowmajor"))
accu2=accuracy(preds2, valid.y)
accu2

有效均方根值是0.05，比以前的模型好。

## 绘制预测价格和真实价格
当前的preds2是标准化的标签。让我们重置它们。

real.preds2=exp(preds2*(max(train[,1])-min(train[,1]))+min(train[,1]))
real.valid.y=exp(valid[,1])

让我们使用`ggplot()`，让我们首先将预测价格和真实价格合并为一列。使用“预测”或“正确”来标记它们。

result_compare2=rbind(cbind(seq(1:575),real.valid.y,rep("True",575)),cbind(seq(1:575),real.preds2,rep("Predict",575)))

将矩阵转换为data.frame。

result_compare2=as.data.frame(result_compare2)
colnames(result_compare2)=c("Index","Price","Value")

我们需要将指数和价格转换为数字变量。

result_compare2$Index=as.numeric(result_compare2$Index)
result_compare2$Price=as.numeric(result_compare2$Price)
## 在R 3.5-3.6中 ,应该使用
## result_compare2$Index=as.numeric(levels(result_compare2$Index))[result_compare2$Index]
##  result_compare2$Price=as.numeric(levels(result_compare2$Price))[result_compare2$Price]
## 这一差异的产生是因为3.5-3.6的R预测变量结果类型是factor 而这里是是 str

使用`ggplot()`绘制它们。

ggplot(result_compare2, aes(x=Index, y=Price, colour=Value)) + geom_point()