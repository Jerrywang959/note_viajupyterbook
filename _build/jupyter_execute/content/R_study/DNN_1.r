# 简单生成DNN
再次考虑 为二手丰田卡罗拉定价 问题
## 加载和预处理数据集
加载包

library(mxnet)
library(caret)
library(forecast)

加载数据集

toyota.df <- read.csv("https://github.com/Jerrywang959/note_viajupyterbook/raw/master/datas/ToyotaCorolla.csv")

使用`Age_08_04，KM，Fuel_Type，HP，Automatic，Doors，Quarterly_Tax，Mfr_Guarantee，Guarantee_Period，Airco，Automatic_airco，CD_Player，Powered_Windows，Sport_Model和Tow_Bar`来做价格预测,一次性做好变量的预处理

toyota=toyota.df[,-c(1,2,5,6,10,11,13,15,16,18,20,22,23,24,27,29,31,32,33,35,36,37,38)]
toyota$Fuel_Type_CNG <- 1* (toyota$Fuel_Type == "CNG")
toyota$Fuel_Type_Diesel <- 1* (toyota$Fuel_Type == "Diesel")
toyota=toyota[,-4]
toyota$Price=log(toyota$Price)
set.seed(1)
train.index <- sample(row.names(toyota), 0.6*dim(toyota)[1])  
valid.index <- setdiff(row.names(toyota), train.index) 
train <- toyota[train.index, ]
valid <- toyota[valid.index, ]
preProcValues=preProcess(train,method = "range",rangeBounds = c(0,1))
trainTransformed <- predict(preProcValues, train)
validTransformed <- predict(preProcValues, valid)
str(validTransformed)

## 训练深度神经网络
软件包mxnet可以逐层生成神经网络。因此，我们可以根据设计的网络结构独立定义每个层。  
我们首先通过函数`mx.symbol.Variable()`定义输入层。此步骤仅创建具有指定名称的符号变量。

data <- mx.symbol.Variable("data")

然后，我们定义第一个隐藏层。`mx.symbol.FullyConnected()`用于定义具有输入数据和隐藏节点数15 的完全连接层。

fc1 <- mx.symbol.FullyConnected(data, num_hidden=15, name="fc1")

然后在第一个隐藏层之后定义激活函数。第一个参数是输入，它是第一隐藏层的输出。我们在这里使用`tanh`函数。

act1 <- mx.symbol.Activation(fc1, name="tanh1", act_type="tanh")

然后是第二个隐藏层。

fc2 <- mx.symbol.FullyConnected(act1, name="fc2", num_hidden=25)

第二隐藏层之后的激活函数。我们现在使用`relu`。

act2 <- mx.symbol.Activation(fc2, name="relu2", act_type="relu")

现在我们定义输出层。



fc3 <- mx.symbol.FullyConnected(act2, name="fc3", num_hidden=1)

以及线性回归输出。

lro <- mx.symbol.LinearRegressionOutput(fc3)

基本上，神经网络的结构是：`数据-> fc1-> ac1-> fc2-> act2-> fc3-> lro`。

然后我们训练模型。使用`mx.model.FeedForward.create()`创建前馈神经网络。

train.x=data.matrix(trainTransformed[,2:17])
train.y=trainTransformed[,1]
mx.set.seed(0)
model <- mx.model.FeedForward.create(lro, X=train.x, y=train.y,
                                     num.round=100, array.batch.size=15,
                                     learning.rate=0.07, momentum=0.9,
                                     eval.metric=mx.metric.rmse, array.layout = "rowmajor")

## 预测验证集
使用训练有素的模型来预测测试集。这里的`predit()`将使用模型来预测`valid.x`。

valid.x=data.matrix(validTransformed[,2:17])
valid.y=validTransformed[,1]
preds = predict(model, valid.x, array.layout="rowmajor")
preds=as.vector(preds)

可以通过包装预测中的函数`precision()`计算预测精度。

accu=accuracy(preds, valid.y)
accu

有效均方根值为0.05。

ME：平均误差

RMSE：均方根误差

MAE：平均绝对误差

MPE：平均百分比误差

MAPE：平均绝对百分比误差