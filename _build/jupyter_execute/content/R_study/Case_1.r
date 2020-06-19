# Case 1: 点球成金
## 加载和浏览数据集

baseball = read.csv("../../datas/Moneyball.csv")
str(baseball)

由于我们确认了Moneyball的索赔，因此我们希望使用Paul DePodesta在2002年获得的数据来构建模型。

moneyball = subset(baseball, Year < 2002)
str(moneyball)

## 预测胜利
我们首先建立一个线性回归模型，以使用得分数和失分数之间的差异来预测获胜。为了使操作更容易一些，让我们从创建一个名为RD的新变量RD开始，并将其设置为的分数减去失分数

moneyball$RD = moneyball$RS - moneyball$RA
str(moneyball)

PredictWins = lm(W ~ RD, data = moneyball)
summary(PredictWins)

## 预测得分 
我们想看看是否可以使用线性回归来使用三个统计数据(上垒率（OBP），长打率（SLG）和打击率（BA）)来预测得分（RS）。

PredictRS = lm(RS ~ OBP + SLG + BA, data = moneyball)
summary(PredictRS)

根据定义（您可以在网上找到这些定义），这三个统计数据彼此非常相似，它们可以衡量玩家的击球表现。这些统计数据越大，球员的击球表现就越好。因此，我们希望所有这些变量的系数都为正，因为更好的参与者应该导致更多的得分。BA的违反直觉的负系数表明该模型可能存在问题。如果我们只关心模型预测的准确性，那么模型就很好。但是，在这种情况下，团队依赖模型聘用潜在的参与者，因此错误的系数将导致严重的错误决策。   

考虑到这些统计数据相互之间密切相关，因为它们都以定义稍有不同的方式来衡量击球表现，因此我们怀疑模型中可能存在一些多重共线性问题。我们可以检查这三个变量之间的相关性以确认这一点。

cor(data.frame(moneyball$OBP, moneyball$SLG, moneyball$BA))

我们可以看到这三个变量确实彼此高度相关，因为所有相关系数都大于0.8。要决定保留哪个变量，我们需要执行更多分析。

首先，让我们分别对这三个变量进行单变量分析，以检查其预测能力。通过单变量分析，即运行单变量线性回归。

PredictRS1 = lm(RS ~ OBP, data = moneyball)
summary(PredictRS1)

PredictRS1 = lm(RS ~ OBP, data = moneyball)
summary(PredictRS1)

PredictRS2 = lm(RS ~ SLG, data = moneyball)
summary(PredictRS2)

PredictRS3 = lm(RS ~ BA, data = moneyball)
summary(PredictRS3)

上面的单变量分析表明，单独使用OBP和SLG可以得到更高的$R^2$. OBP的系数远大于SLG。让我们用OBP和SLG进行多元线性回归来确认发现。

PredictRS4 = lm(RS ~ SLG + OBP, data = moneyball)
summary(PredictRS4)

我们可以观察到, 这一模型的$R^2$近似于有三个因子变量的$R^2$ :$0.9302$.  换句话说，BA的效果几乎可以被OBP和SLG捕获。如Moneyball所述，OBP和SLG的系数确定了变量的相对重要性。如果进一步的分析,会发现其他组合的$R^2$将大大小于0.9302

我们决定保留`OBP`和`SLG`，即使它们彼此高度相关，这有两个主要原因. 一, 使用两个因子的模型的$R^2$高于使用单个因子的模型的$R^2$,这表明每个变量中都有大量信息无法被另一个变量捕获。其次，两个变量的系数均显着为正，并且其大小与单变量分析一致。

## 预测失分
我们可以进行类似的线性回归分析，以构建模型来预测失分.

PredictRA = lm(RA ~ OOBP + OSLG, data = moneyball)
summary(PredictRA)