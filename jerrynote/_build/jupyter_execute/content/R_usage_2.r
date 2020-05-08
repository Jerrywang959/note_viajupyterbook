# DataFrame

创建一个DataFrame

Country = c("Brazil", "China", "India", "Switzerland", "USA")
LifeExpectancy = c(74, 76, 65, 83, 79)
Data = data.frame(Country, LifeExpectancy)
Data

给DataFrame增加列

Population = c(199000, 1390000, 1240000, 7997, 318000)
Data2 = cbind(Data, Population)
Data2

给DataFrame增加行

Country = c("Australia", "Greece")
LifeExpectancy = c(82, 81)
Population = c(23050, 11125)
NewData = data.frame(Country, LifeExpectancy, Population)
NewData

Data3 = rbind(Data2, NewData)
Data3

# DataFrame获得数据概要

获取当前路径

getwd()

读取数据文件，这包含了世界卫生组织（WHO）在所有国家/地区的最新统计数据

WHO = read.csv("/home/jerrywang/GitHub/note_viajupyterbook/jerrynote/datas/WHO.csv")
WHO

## 数据结构
`str()`函数向我们展示了数据的结构

str(WHO)

可以看出，这是一个包含194个观测值和13个变量的DataFrame，变量名显示在左列，右边显示的是相应变量的类型，包括Factor、num、int。Factor应该是类型变量，显示了包含的类型的个数。num应该为一般的数字，int为整数

`summary()`函数显示DataFrame的摘要。包括最小最大值，均值，第一、第二、第三个四分位数。

summary(WHO)

选择DataFrame的子数据生成新的DataFrame

SEA = subset(WHO, Region == "South-East Asia")
str(SEA)

## 保存csv文件

write.csv(SEA, "WHO_SEA.csv")

ls()

删除部分变量以释放内存

rm(SEA)
ls()

# 数据分析
访问DataFrame中的变量

WHO$Under15

均值

mean(WHO$Under15)

标准差

sd(WHO$Under15)

摘要

summary(WHO$Under15)

## which.min
找出哪个国家在15岁以下的人口最少的

which.min(WHO$Under15)

WHO$Country[86]

## 散点图
画GNI与FertilityRate的散点图

plot(WHO$GNI, WHO$FertilityRate)

## subset
使用`subset()`找出收入高，生育率高的国家

Outliers = subset(WHO,  GNI > 10000 & FertilityRate > 2.5)
nrow(Outliers)

`nrow`函数返回DataFrame中的行数或观察值，我们可以看到有七个这样的国家。让我们仅输出国名，国民总收入和这七个国家的生育率。

Outliers[c("Country", "GNI", "FertilityRate")]

## 直方图
创建预期寿命的直方图

hist(WHO$LifeExpectancy)

## 箱形图
画一个按照区域排序的LifeExpectancy箱形图

boxplot(WHO$LifeExpectancy ~ WHO$Region)

对图像做简单的注释

boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab = "Region", ylab = "Life Expectancy", main = "Life Expectancy of Countries by Region")

## 选择并生成表
生成类型变量的汇总表

table(WHO$Region)

生成数值变量某一特征的汇总表，按照`WHO$Region`排序

tapply(WHO$Over60, WHO$Region, mean)

按照第二个变量分类和排序，生成第一个变量的最小值表

tapply(WHO$LiteracyRate, WHO$Region, min)

这是因为有缺失值的存在，删除缺失值后解决

tapply(WHO$LiteracyRate, WHO$Region, min, na.rm = TRUE)