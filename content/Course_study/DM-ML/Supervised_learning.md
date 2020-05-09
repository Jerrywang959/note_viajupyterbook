# Surpervised Learning Intro

## Discriminative models

辨别模型

描述无法观察到的变量对可以观察到的变量的依赖关系

比如：$p_\theta(y|x)$



## Generative models

生成模型

描述数据的联合概率分布的模型

比如$p_\theta(x,y)$

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587867372720.png)



## ML THREE element





![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587867245727.png)







### Model

**空间**

- 输入空间X
- 输出空间Y

**训练数据**

* 样本$S$，长度为$N$，每一个数据都是独立同分布的，服从$X\times Y $的联合分布$D$
* $S=\left\{\left(x_{1}, y_{1}\right),\left(x_{2}, y_{2}\right), \ldots,\left(x_{N}, y_{N}\right)\right\}$

**假设空间**

- $F\sube Y^X$(从$X$映射到$Y$)
- 可能的模型空间，例如：所有的线性函数
- 取决于特征结构和有关该问题的先验知识

### Strategy

**目标**

找到一个较好的假设$f\sube F$

什么叫较好的假设？可以从以下三个角度来谈

#### 泛化误差

**损失函数**

$L: Y \times Y \rightarrow \mathbb{R}$

**泛化误差**
$$
R(f)=\mathbb{E}_{(x, y) \sim D}[L(f(x), y)]
$$
**经验误差**
$$
\hat{R}(f)=\frac{1}{N} \sum_{i=1}^{N} L\left(f\left(x_{i}\right), y_{i}\right)
$$
对于有限的假设空间$F$,$\forall f \sube F$，有不超过$1-\delta$的概率，满足
$$
R(f) \leq \hat{R}(f)+\epsilon(d, N, \delta)
$$
此处，$N$为训练次数，$d$为$F$中的函数个数，
$$
\epsilon(d, N, \delta)=\sqrt{\frac{1}{2 N}\left(\log d+\log \frac{1}{\delta}\right)}
$$
证明：

由霍丁夫不等式



**Hint: Hoeffding Inequality**

霍夫丁不等式

假设$X_1,X_2,...,X_n$是独立有界的随机变量，$X_i\in[a,b]$，随机变量$Z$为
$$
Z=\frac{1}{n} \sum_{i=1}^{n} X_{i}
$$
那么下列的两个不等式成立
$$
\begin{aligned}
&P(Z-\mathbb{E}[Z] \geq t) \leq \exp \left(\frac{-2 n t^{2}}{(b-a)^{2}}\right)\\
&P(\mathbb{E}[Z]-Z \geq t) \leq \exp \left(\frac{-2 n t^{2}}{(b-a)^{2}}\right)
\end{aligned}
$$
![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587867917749.png)

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587868545478.png)

把先验知识加入





![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587869994763.png)



![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587870260064.png)





![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587870648546.png)

皮尔森相关系数：只能用于线性关系

用 R-squared

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587871334009.png)



![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587871761741.png)

## Cross validation





