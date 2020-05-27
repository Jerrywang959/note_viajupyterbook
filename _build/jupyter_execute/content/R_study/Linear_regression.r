# 线性回归入门

## 安装并使用包

切换清华镜像源

options(repos=structure(c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))) 

MASS:支持Venables和Ripley的函数和数据集   
ISLR:R中应用统计学习入门的数据

#install.packages("ISLR")

#install.packages("MASS")

加载包并删除全部变量

library(MASS)
library(ISLR)
rm(list=ls())

# 简单线性回归
查看变量名词

names(Boston)

做线性回归，`lm()`为线性回归模型，`~`前为被解释变量，`~`后为自变量

lm.fit=lm(medv~lstat,data = Boston)

显示回归结果

lm.fit

summary(lm.fit)

找出存储在回归结果中的其他信息

names(lm.fit)

返回参数

lm.fit$coefficient

coef(lm.fit)

返回拟合的置信区间

confint(lm.fit)

预测数值并给出置信区间

predict(lm.fit,data.frame(lstat=(c(5,10,15))), interval="confidence")

画散点图并画出集拟合的直线

plot(Boston$lstat,Boston$medv)
abline(lm.fit)

给直线加粗或者添加颜色

plot(Boston$lstat,Boston$medv)
abline(lm.fit,lwd=3,col="red")

`plot`中的`pch`参数代表了画出的点的形状，具体如下
![UTOOLS1588302281481.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1588302281481.png)

plot(Boston$lstat,Boston$medv,pch=25)

plot(1:20,1:20,pch=1:20)

画出线性回归结果诊断图，包括   
1. 拟合数跟残差的关系图，较好的线性拟合应该会在此图中得到水平的直线   
2. 标准化残差与正态分布的QQ图，较好的线性拟合应该是一条直线    
3. 规模定位图或者点差位置图，较好的线性拟合应该是一条水平的直线    
4. 残差与杠杆图，帮助确定模型上有影响力的数据点，库克距离线(cook's distance)只之外的点是对模型有影响的点

plot(lm.fit)

按照2 × 2的结构画成子图

par(mfrow=c(2,2)) 
plot(lm.fit)

画诊断图中的第一个图

par(mfrow=c(1,1))
plot(predict(lm.fit), residuals(lm.fit))

画拟合值和[学生化残差](https://en.wikipedia.org/wiki/Studentized_residual)之间的关系，学生化残差是残差除以其标准偏差的估计所得的商，是学生统计量的一种

plot(predict(lm.fit), rstudent(lm.fit))

leverage是衡量一个观察值的独立变量值与其他观察值的相距多远的度量，`hatvalues()`以获得杠杆统计的结果

plot(hatvalues(lm.fit))

找到最大杠杆点的索引

which.max(hatvalues(lm.fit))

# 多元线性回归

lm.fit=lm(medv~lstat+age,data=Boston)
summary(lm.fit)

使用一个因变量和其他所有自变量回归

lm.fit=lm(medv~.,data=Boston)
summary(lm.fit)

获得回归的$R^2$

summary(lm.fit)$r.sq

获得相对标准误差（Relative Standard Error，RSE）

$$
\mathrm{RSE}=\frac{Standard Error}{Estimate}
$$

Standard Error为样本的标准误，Estimate为样本的均值

summary(lm.fit)$sigma 

排除某一个变量并做回归

lm.fit1=lm(medv~.-age,data=Boston)
summary(lm.fit1)

也可以用`update()`函数来更新之前的模型

lm.fit1=update(lm.fit, ~.-age)
lm.fit1

使用`*`以包括交互项

summary(lm(medv~lstat*age,data=Boston))

使用`*`以只对交互项回归

summary(lm(medv~lstat:age,data=Boston))

# 加入解释变量的非线性项

函数`I()`将项包装起来

lm.fit2=lm(medv~lstat+I(lstat^2),data = Boston)
summary(lm.fit2)

`anova()`函数对两个模型进行方差分析

lm.fit=lm(medv~lstat,data = Boston)
lm.fit
anova(lm.fit,lm.fit2)

使用`poly()`以获得高阶多项式

lm.fit5=lm(medv~poly(lstat,5),data = Boston)
summary(lm.fit5)

# 定性预测因子

查看Carseats数据的变量

names(Carseats)

str(Carseats)

summary(Carseats$ShelveLoc)

lm.fit=lm(Sales~.+Income:Advertising+Price:Age,data=Carseats)
summary(lm.fit)

当我们对类型变量回归时，会自动生产虚拟变量，比如：

lm.fit=lm(Sales~.+Income:Advertising+Price:Age,data=Carseats)
summary(lm.fit)

用`contrasts()`函数以得到R生产的虚拟变量的具体情况

contrasts(Carseats$ShelveLoc)

这表示，截距项包含了`Bad`的对被解释变量的影响，`ShelveLocGood`系数的含义是`Good`与`Bad`的差异，`ShelveLocMedium`系数的含义是`Medium`与`Bad`的差异