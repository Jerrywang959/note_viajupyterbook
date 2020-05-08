# 时间序列的定义

随机变量:随机现象/试验各种结果的实值单值函数

随机过程

设$\mathscr{T}$为实数集合$\mathscr{R}=(-\infin,+\infin)$的一个子集，称之为指标集。如果对于每个$t\in\mathscr{T}$，都有一个随机变量$X_t$与之对应，就称随机变量的集合$\{X_t\}=\{X_t,t\in\mathscr{T}\}$为一个随机过程。

几类随机过程

- 随机序列：$\mathscr{T}$是全体（非负）整数
- 时间序列：$\mathscr{T}$是时间指标的随机序列



# 时间序列的统计量

均值

$\mu_t\triangleq\mathrm{E}(X_t)$

方差

$\sigma^2_t\triangleq\mathrm{E}(X_t-\mu_t)$

自协方差

$\gamma_{t,s}\triangleq\mathrm{E}[(X_t-\mu_t)(X_s-\mu_s)]\equiv\gamma_{s,t}$

自相关系数

$\rho_{s,t}=\triangleq\frac{\gamma{t,s}}{\sqrt{\sigma_t^2}\sqrt{\sigma_s^2}}\equiv\rho_{t,s}$

# 时间序列的平稳性

## 弱平稳序列

1. $\forall t\in\mathscr{T},\mathrm{E}(X_t)=\mu$         
2. $\forall t\in\mathscr{T},\mathrm{E}(X_t^2)<\infin$
3. $\forall t,s\in\mathscr{T},\gamma_{t, s}=E\left[\left(X_{t}-\mu_{t}\right)\left(X_{s}-\mu_{s}\right)\right]=\gamma_{t-s}$，$\forall t=s \in \mathscr{T}, \gamma_{t, s}=E\left[\left(X_{t}-\mu_{t}\right)\left(X_{t}-\mu_{t}\right)\right]=\gamma_{0}$

## 严平稳序列

严格平稳的时间序列$\{X_t\}$

$\left(X_{t+k_{1}}, X_{t+k_{2}}, \ldots, X_{t+k_{n}}\right)$的联合分布仅和时间间隔$k_i$有关

## 白噪声过程

如果$\{\epsilon_t\}$是一个平稳序列，并且$\forall t,s\in\mathscr{T},有$

1. $\mathrm{E}(\epsilon_t)=\mu$
2. $\gamma_{t, s}=\left\{\begin{array}{l}\sigma^{2}, \text { if } t=s \\ 0, \ \ \text { if } t \neq s\end{array}\right.$

则称$\{\epsilon_t\}$为白噪声过程（跨期不相关的平稳序列）

几种白噪声过程

- 独立白噪声：$\{\epsilon_t\}$是一个独立序列
- 0均值白噪声：$\mu=0$
- 标准白噪声：$\mu=0,\sigma^2=1$
- 高斯/正态白噪声：$\epsilon_t$服从正态分布

## 分析平稳时间序列

难点：只有一次实现，不知道$X_t$的分布

解决方法：遍历性

假设$\mathrm{E}(X_t)=\mu,\mathrm{E}(X_t^2)=\sigma^2$

均值遍历
$$
\bar x\triangleq\frac{1}{T}\sum_{t=1}^Tx_t \stackrel{p}\longrightarrow \mu
$$
方差遍历
$$
s^2\triangleq\frac{1}{T}\sum_{t=1}^T(x_t-\mu)^2 \stackrel{P}\longrightarrow\sigma^2
$$
协方差遍历（**为什么是这样**）
$$
s^{2} \triangleq \frac{1}{T-j} \sum_{t=j+1}^{T}\left(x_{t}-\mu\right)\left(x_{t-j}-\mu\right) \stackrel{p}{\rightarrow} \gamma_{j}^{2}
$$


遍历性只是一个假设，无法验证其成立与否。路径依赖的时间序列变量不满足平稳性。



# 滞后算子

$L$：对时间序列的一种操作，取其一阶滞后数据

$Lx_t\equiv x_{t-1}$

习惯用法：
$$
L(Lx_t)=L(x_{t-1})=x_{t-2}  \\
L^kx_t=x_{t-k}      \\
L^0x_t=x_t    \\
L^{-1}x_t=x_{t+1}     \\
Lc=c
$$
滞后算子服从的运算法则：交换律、结合律、分配率

例子
$$
\left(a+b L+c L^{2}\right) L x_{t}=a L x_{t}+b L^{2} x_{t}+c L^{3} x_{t}=a x_{t-1}+b x_{t-2}+c x_{t-3}   \\
\left(1-\lambda_{1} L\right)\left(1-\lambda_{2} L\right) x_{t}=\left(1-\lambda_{1} L-\lambda_{2} L+\lambda_{1} \lambda_{2} L^{2}\right) x_{t}=x_{t}-\left(\lambda_{1}+\lambda_{2}\right) x_{t-1}+\lambda_{1} \lambda_{2} x_{t-2}
$$


