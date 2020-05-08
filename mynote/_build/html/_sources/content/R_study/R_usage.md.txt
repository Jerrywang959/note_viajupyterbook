# R的基本用法

## 向量和矩阵

创建向量

```r
x = c(1,3,2,5)
x <- c(1,6,2)
```

 `ls()`返回当前的所有变量

`rm()`删除我们不想要的变量

删除所有变量

```r
rm(list=ls())    #
```

创建矩阵

```r
x=matrix(data=c(1,2,3,4) , nrow=2, ncol =2)
x=matrix(c(1,2,3,4) ,2,2)
```

默认情况下，会把一个向量按行排列，若想按列排列，需要加入参数`byrow =TRUE`

```r
matrix(c(1,2,3,4),2,2,byrow =TRUE)
```

索引矩阵

```r
A=matrix (1:16,4,4)
A[2,3]   #索引一个位置
A[1:3 ,2:4] #索引连续行和连续列
A[1:2 ,]   #索引行
A[ ,1:2]   #索引列
A[c(1,3) ,c(2,4) ] #索引某些特定的点：行号为1或3，列号为2或4
A[-c(1,3) ,]     # `-`表示剔除这些元素的其他元素
```

`dim(A)`返回矩阵的形状

## 数据的处理

`sqrt(x)`，`x^2`分别为开方和乘方操作，支持向量操作

`rnorm()`返回一定数量的正态分布随机数

```r
x=rnorm(50)
y=x+rnorm(50, mean=50, sd=.1)
```

`cor(x,y)`返回两个向量的相关系数

`set.seed()`指定生成随机数的方式，以便在需要时候生成相同的随机数

```r
set.seed(1303)
rnorm(50)
```


生成等比数列

```r
seq(a,b)
seq(0,1,length=10)
x=1:10
```

`mean()`,` var()`,`sd()`返回均值，方差和标准差

生成数据集中每一个变量的基本数值特征

```r
summary(Auto)
```

生成某一个变量的基本数值特征

```r
summary(mpg) 
```

## 数据I/O

`read.table()`读取数据

`write.table()`输出数据

```r
Auto=read.table("Auto.data")
fix(Auto)       #在窗口中查看数据，但必须关闭窗口后才能继续输入其他命令
Auto=read.table("Auto.data", header =T,  na.strings="?")  
#  header=T说明第一行代表的是变量名称
#  na.strings是指看到某些字符就认为是缺失元素
Auto=na.omit(Auto) #删去元素缺失的行
names(Auto)    # 返回元素名称
```

## 画图

```r
x=rnorm(100)
y=rnorm(100)
plot(x,y)
plot(x,y,xlab=" this is the x-axis",ylab="this is the y-axis", main="Plot of X vs Y")
```

从已经导入的数据中选择变量画图

```r
plot(Auto$cylinders, Auto$mpg)
```

或者预先确定数据集

```r
attach(Auto)
plot(cylinders, mpg) 
```

![UTOOLS1587973200685.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587973200685.png ':size=500')

` as.factor()`把定量描述的变量转化为定性描述的变量，在画图时会有所不同

```r
cylinders =as.factor (cylinders)
plot(cylinders , mpg , col ="red", xlab="cylinders", ylab="MPG")
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587976211197.png ':size=500')

画直方图

```r
hist(mpg)
```

![UTOOLS1587976303682.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587976303682.png ':size=500')

```r
hist(mpg ,col =2)   #`col=2`=  `col ="red"`
```

![UTOOLS1587976352206.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587976352206.png ':size=500')

画出所有两两变量的散点图

```r
pairs(Auto)
```

![UTOOLS1587976420740.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587976420740.png ':size=500')

选择部分变量，画他们两两之间的散点图

```r
pairs(~mpg + displacement + horsepower + weight + acceleration , Auto)
```

![UTOOLS1587976527866.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587976527866.png ':size=500')



