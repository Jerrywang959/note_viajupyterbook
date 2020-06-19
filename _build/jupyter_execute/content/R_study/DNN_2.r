# 包含RNN的DNN练习
实现手写数字分类
## 加载和预处理数据集
加载所需的软件包。

library(mxnet)
library(caret)
library(forecast)

让我们读取数据集：

digit <- read.csv('../../datas/digit.csv', header=TRUE)

区分训练集和测试集

set.seed(1)
train.index <- sample(row.names(digit), 0.6*dim(digit)[1])  
valid.index <- setdiff(row.names(digit), train.index) 
train <- digit[train.index, ]
valid <- digit[valid.index, ]

    train <- data.matrix(train)
    valid<- data.matrix(valid)
    train.x <- train[,-1]
    train.y <- train[,1]
    valid.x <- valid[,-1]
    valid.y <- valid[,1]

在训练/测试中，每个图像都表示为一行。每个图像的灰度范围在`[0，255]`范围内。使用以下命令将其线性转换为`[0,1]`：

    train.x <- train.x/255
    valid.x <- valid.x/255

然后让我们将输入更改为专业列，并将矩阵重塑为数组：

train.array <- t(train.x)
dim(train.array)<-c(28, 28, 1, nrow(train.x))
valid.array <- t(valid.x)
dim(valid.array)<-c(28, 28, 1, nrow(valid.x))

在标签部分，每个数字的位数分布相当均匀：

table(train.y)

table(valid.y)

## 训练卷积神经网络
现在让我们使用著名的CNN：LeNet。Yann LeCun提出了这种方法来识别手写数字。我们将演示如何在mxnet中构建和训练LeNet。

LeNet：Conv-> Tanh-> Pool-> Conv-> Tanh-> Pool-> FC-> FC-> Softmax

<http://yann.lecun.com/exdb/lenet/>

首先，我们构建网络：  
输入层：

data <- mx.symbol.Variable('data')

第一卷积+激活+池化层。`num_filter`定义内核数。

conv1 <- mx.symbol.Convolution(data=data, kernel=c(5,5), num_filter=20)
tanh1 <- mx.symbol.Activation(data=conv1, act_type="tanh")
pool1 <- mx.symbol.Pooling(data=tanh1, pool_type="max",
                          kernel=c(2,2), stride=c(2,2))

第二个卷积+激活+池化层

conv2 <- mx.symbol.Convolution(data=pool1, kernel=c(5,5), num_filter=50)
tanh2 <- mx.symbol.Activation(data=conv2, act_type="tanh")
pool2 <- mx.symbol.Pooling(data=tanh2, pool_type="max",
                          kernel=c(2,2), stride=c(2,2))

第一个完全连接的层。

flatten <- mx.symbol.Flatten(data=pool2)
fc1 <- mx.symbol.FullyConnected(data=flatten, num_hidden=500)
tanh3 <- mx.symbol.Activation(data=fc1, act_type="tanh")

输出完全连接的层。

fc2 <- mx.symbol.FullyConnected(data=tanh3, num_hidden=10)

以及线性回归输出。

lenet <- mx.symbol.SoftmaxOutput(data=fc2)

训练lenet

mx.set.seed(0)
model <- mx.model.FeedForward.create(lenet, X=train.array, y=train.y, num.round=5, array.batch.size=100,
                                     learning.rate=0.05, momentum=0.9, wd=0.00001,
                                     eval.metric=mx.metric.accuracy,
                                       epoch.end.callback=mx.callback.log.train.metric(100))


## 预测验证集
使用训练好的的模型预测验证集。

preds <- predict(model, valid.array)
pred.label <- max.col(t(preds)) - 1

可以通过包装`forecast`中的 函数 `precision()`计算预测精度。

accu=length(which(pred.label == valid.y))/length(valid.y)
accu

