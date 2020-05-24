# 时间序列的数学基础

## 时间序列的定义

随机变量:随机现象/试验各种结果的实值单值函数

随机过程

设$\mathscr{T}$为实数集合$\mathscr{R}=(-\infin,+\infin)$的一个子集，称之为指标集。如果对于每个$t\in\mathscr{T}$，都有一个随机变量$X_t$与之对应，就称随机变量的集合$\{X_t\}=\{X_t,t\in\mathscr{T}\}$为一个随机过程。

几类随机过程

- 随机序列：$\mathscr{T}$是全体（非负）整数
- 时间序列：$\mathscr{T}$是时间指标的随机序列



## 时间序列的统计量

均值

$\mu_t\triangleq\mathrm{E}(X_t)$

方差

$\sigma^2_t\triangleq\mathrm{E}(X_t-\mu_t)$

自协方差

$\gamma_{t,s}\triangleq\mathrm{E}[(X_t-\mu_t)(X_s-\mu_s)]\equiv\gamma_{s,t}$

自相关系数

$\rho_{s,t}=\triangleq\frac{\gamma{t,s}}{\sqrt{\sigma_t^2}\sqrt{\sigma_s^2}}\equiv\rho_{t,s}$

## 时间序列的平稳性

### 弱平稳序列

1. $\forall t\in\mathscr{T},\mathrm{E}(X_t)=\mu$         
2. $\forall t\in\mathscr{T},\mathrm{E}(X_t^2)<\infty$
3. $\forall t,s\in\mathscr{T},\gamma_{t, s}=E\left[\left(X_{t}-\mu_{t}\right)\left(X_{s}-\mu_{s}\right)\right]=\gamma_{t-s}$，$\forall t=s \in \mathscr{T}, \gamma_{t, s}=E\left[\left(X_{t}-\mu_{t}\right)\left(X_{t}-\mu_{t}\right)\right]=\gamma_{0}$

### 严平稳序列

严格平稳的时间序列$\{X_t\}$

$\left(X_{t+k_{1}}, X_{t+k_{2}}, \ldots, X_{t+k_{n}}\right)$的联合分布仅和时间间隔$k_i$有关

### 白噪声过程

如果$\{\epsilon_t\}$是一个平稳序列，并且$\forall t,s\in\mathscr{T},有$

1. $\mathrm{E}(\epsilon_t)=\mu$
2. $\gamma_{t, s}=\left\{\begin{array}{l}\sigma^{2}, \text { if } t=s \\ 0, \ \ \text { if } t \neq s\end{array}\right.$

则称$\{\epsilon_t\}$为白噪声过程（跨期不相关的平稳序列）

几种白噪声过程

- 独立白噪声：$\{\epsilon_t\}$是一个独立序列
- 0均值白噪声：$\mu=0$
- 标准白噪声：$\mu=0,\sigma^2=1$
- 高斯/正态白噪声：$\epsilon_t$服从正态分布

### 分析平稳时间序列

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



## 滞后算子

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

## 差分方程

差分算子$\Delta$

差分方程：与它滞后项相关的方程

$$
y_t=f(y_{t-1},y_{t-2},...,y_{t-p};\omega_t;\Phi)
$$


### 差分方程的特征

- 阶数：$y_t=y_{t-1}+2$
- 线性：$y_t=y_t^2+2$
- 齐次：$y_t=y_{t-1}$
- 系数：$y_t=g_ty_{t-1}+2$



常系数线性差分方程

$$
\begin{array}{c}
y_{t}=\phi y_{t-1}+w_{t}  \qquad  \text{AR(1)}  \\      
y_{t}=\phi_{1} y_{t-1}+\phi_{2} y_{t-2}+\cdots+\phi_{p} y_{t-p}+w_{t}  \qquad  \text{AR(p)}
\end{array}
$$

### 一阶差分方程

#### 递归求解法

$$
\begin{array}{l}
y_{t}=\phi y_{t-1}+w_{t} \\
=\phi\left(\phi y_{t-2}+w_{t-1}\right)+w_{t}=\phi^{2} y_{t-2}+\phi w_{t-1}+w_{t} \\
=\phi^{2}\left(\phi y_{t-3}+w_{t-2}\right)+\phi w_{t-1}+w_{t}=\phi^{3} y_{t-3}+\phi^{2} w_{t-2}+\phi w_{t-1}+w_{t} \\
=\phi^{3}\left(\phi y_{t-4}+w_{t-3}\right)+\phi^{2} w_{t-2}+\phi w_{t-1}+w_{t}=\phi^{4} y_{t-4}+\phi^{3} w_{t-3}+\phi^{2} w_{t-2}+ \\
\phi w_{t-1}+w_{t}=\cdots
\end{array}
$$

缺点：非一阶方程会非常复杂

#### 滞后算子求解法

$$
y_{t}=\phi y_{t-1}+w_{t} \Rightarrow(1-\phi L) y_{t}=w_{t}
$$

两边同乘$1+\phi L+\phi^{2} L^{2}+\cdots+\phi^{t} L^{t}$

左边：

$$
\left(1+\phi L+\phi^{2} L^{2}+\cdots+\phi^{t} L^{t}\right)(1-\phi L) y_{t}=\left(1-\phi^{t+1} L^{t+1}\right) y_{t}
$$

右边：

$$
\begin{array}{l}
\left(1+\phi L+\phi^{2} L^{2}+\cdots+\phi^{t} L^{t}\right) w_{t} 
\end{array}
$$

我们得到

$$
\begin{array}{c}
\left(1-\phi^{t+1} L^{t+1}\right) y_{t}=\left(1+\phi L+\phi^{2} L^{2}+\cdots+\phi^{t} L^{t}\right) w_{t}\\
y_{t}=\phi^{t+1} y_{-1}+\phi^{t} w_{0}+\phi^{t-1} w_{1}+\cdots+\phi^{1} w_{t-1}+\phi^{0} w_{t} \\
y_{t+k}=\phi^{k+1} y_{t-1}+\phi^{k} w_{t}+\phi^{k-1} w_{t+1}+\cdots+\phi^{1} w_{t+k-1}+\phi^{0} w_{t+k}
\end{array}
$$

和递归算出来的结果完全一样

#### 考察三类影响

##### 影响之类型一：$\omega$的一次性变化,对k期以后y的影响

$$
\frac{\partial y_{t+k}}{\partial w_{t}}=\phi^{k}
$$

- 影响之类型二：$\omega$的一次性变化,对以后各期y的累积影响
- 影响之类型三：$\omega$的持久性变化,对k期以后y的影响

##### 影响之类型二：$\omega$的一次性变化,以后各期y的累计影响

$$
y_{t+k}=\phi^{k+1} y_{t-1}+\phi^{0} w_{t+k}+\phi^{1} w_{t+k-1}+\cdots+\phi^{k-1} w_{t+1}+\phi^{k} w_{t}  \\
\frac{\partial y_{t+k}}{\partial w_{t+k}}=1 ; \frac{\partial y_{t+k}}{\partial w_{t+k-1}}=\phi^{1} ; \ldots ; \frac{\partial y_{t+k}}{\partial w_{t}}=\phi^{k}
$$


一次性变化的累计影响为

$$
\frac{\partial \sum_{j=0}^{k} y_{t+j}}{\partial w_{t}}=1+\phi^{1}+\cdots+\phi^{k}=\frac{1-\phi^{k+1}}{1-\phi} \approx \frac{1}{1-\phi}(|\phi|<1)
$$

##### 影响之类型三：$\omega$的持续性变化,以后k期以后y的影响

持久变化的影响为

$$
\sum_{j=0}^{k} \frac{\partial y_{t+k}}{\partial w_{t+j}}=1+\phi^{1}+\cdots+\phi^{k}=\frac{1-\phi^{k+1}}{1-\phi} \approx \frac{1}{1-\phi}(|\phi|<1)
$$

### 二阶差分方程

$$
y_{t}=\phi_{1} y_{t-1}+\phi_{2} y_{t-2}+w_t
$$

以滞后算子写作

$$
\left(1-\phi_{1} L-\phi_{2} L^{2}\right) y_{t}=w_{t}
$$

或

$$
\left(1-\lambda_{1} L\right)\left(1-\lambda_{2} L\right) y_{t}=w_{t}
$$

其中

$$
\left\{\begin{array}{c}
\lambda_{1}+\lambda_{2}=\phi_{1} \\
\lambda_{1} \lambda_{2}=-\phi_{2}
\end{array}\right.
$$

有

$$
y_{t}=\left(1-\lambda_{1} L\right)^{-1}\left(1-\lambda_{2} L\right)^{-1} w_{t}
$$

做如下的形式转化

$$
\left(1-\lambda_{1} L\right)^{-1}\left(1-\lambda_{2} L\right)^{-1}=\underbrace{\frac{\lambda_{1}}{\lambda_{1}-\lambda_{2}}}_{c_{1}}\left(1-\lambda_{1} L\right)^{-1} \underbrace{-\frac{\lambda_{2}}{\lambda_{1}-\lambda_{2}}}_{c_{2}}\left(1-\lambda_{2} L\right)^{-1}
$$

可以得到

$$
\begin{array}{c}
y_{t}=c_{1}\left(1+\lambda_{1} L+\lambda_{1}^{2} L^{2}+\cdots\right) w_{t}+c_{2}\left(1+\lambda_{2} L+\lambda_{2}^{2} L^{2}+\cdots\right) w_{t} \\
=\left(c_{1}+c_{2}\right) w_{t}+\left(c_{1} \lambda_{1}+c_{2} \lambda_{2}\right) w_{t-1}+\left(c_{1} \lambda_{1}^{2}+c_{2} \lambda_{2}^{2}\right) w_{t-2}+\cdots \\
\triangleq \varphi_{0} w_{t}+\varphi_{1} w_{t-1}+\varphi_{2} w_{t-2}+\cdots \\
\frac{\partial y_{t+k}}{\partial w_{t}}=\varphi_{k}=c_{1} \lambda_{1}^{k}+c_{2} \lambda_{2}^{k}
\end{array}
$$

#### 稳定的二阶差分方程

$$
\frac{\partial y_{t+k}}{\partial w_{t}}=c_{1} \lambda_{1}^{k}+c_{2} \lambda_{2}^{k}
$$

其中$\left|\lambda_{1}\right|<1,\left|\lambda_{2}\right|<1$

#### 其他情况

##### 重根

$\phi_{1}^{2}+4 \phi_{2}=0$

易得

$$
y_{t}=(1-\lambda L)^{-2} w_{t}=\left(1+\lambda L+\lambda^{2} L^{2}+\cdots\right)^{2} w_{t}
$$

$$
\frac{\partial y_{t+k}}{\partial \omega_t}=
$$

##### 复根

$\phi_{1}^{2}+4 \phi_{2}<0$

$$
y_{t}=\phi_{1} y_{t-1}+\phi_{2} y_{t-2}+w_{t} \\
\left(1-\phi_{1} L-\phi_{2} L^{2}\right) y_{t}=w_{t} \\
\left(1-\lambda_{1} L\right)\left(1-\lambda_{2} L\right) y_{t}=w_{t} \\
\frac{1}{\lambda_{1}}=a+b i ; \frac{1}{\lambda_{2}}=a-b i
$$

要使得差分方程稳定，必有点$\left(\frac{1}{\lambda_{1}},\frac{1}{\lambda_{2}}\right)$在单位圆外

### 高阶差分方程

$$
y_{t}=\phi_{1} y_{t-1}+\phi_{2} y_{t-2}+\cdots+\phi_{p} y_{t-p}+w_{t} \\
\left(1-\phi_{1} L-\phi_{2} L^{2}-\cdots-\phi_{p} L^{p}\right) y_{t}=w_{t} \\
\left(1-\lambda_{1} L\right)\left(1-\lambda_{2} L\right) \ldots\left(1-\lambda_{p} L\right) y_{t}=w_{t}
$$

$$
\begin{array}{l}
y_{t}=\left(1-\lambda_{1} L\right)^{-1}\left(1-\lambda_{2} L\right)^{-1} \ldots\left(1-\lambda_{p} L\right)^{-1} w_{t} \\
=w_{t}+\left(\sum_{i=1}^{p} c_{i} \lambda_{i}\right) w_{t-1}+\left(\sum_{i=1}^{p} c_{i} \lambda_{i}^{2}\right) w_{t-2}+\cdots \\
\triangleq w_{t}+\varphi_{1} w_{t-1}+\varphi_{2} w_{t-2}+\cdots
\end{array}
$$

其中

$$
c_{i}=\frac{\lambda_{i}^{p-1}}{\prod_{j=1, j \neq i}^{p}\left(\lambda_{i}-\lambda_{j}\right)}
$$

$\omega$一次性变化的k期影响

$$
\frac{\partial y_{t+k}}{\partial \omega_{t}}=\varphi_{k}=\sum_{i=1}^{p} c_{i} \lambda_{i}^{k}={c_{1} \lambda_{1}^{k}+c_{2} \lambda_{2}^{k}+\cdots+c_{p} \lambda_{p}^{k}}
$$

$$
\begin{array}{c}
y_{t}=\phi_{1} y_{t-1}+\phi_{2} y_{t-2}+\cdots+\phi_{p} y_{t-p}+w_{t} \\
\left(1-\phi_{1} L-\phi_{2} L^{2}-\cdots-\phi_{p} L^{p}\right) y_{t}=w_{t} \\
y_{t}=\left(1+\varphi_{1} L+\varphi_{2} L^{2}+\cdots\right) w_{t} \\
1+\varphi_{1} L+\varphi_{2} L^{2}+\cdots \equiv\left(1-\phi_{1} L-\phi_{2} L^{2}-\cdots-\phi_{p} L^{p}\right)^{-1} \\
\frac{\partial \sum_{j=0}^{k} y_{t+j}}{\partial w_{t}}=\sum_{j=0}^{k} \varphi_{j}=\varphi(1)=\frac{1}{1-\phi_{1}-\phi_{2}-\cdots-\phi_{p}}
\end{array}
$$