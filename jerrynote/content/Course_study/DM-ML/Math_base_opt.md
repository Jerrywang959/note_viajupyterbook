# 函数求极值

## Gradient and Hessian

函数$f:\mathbb{R}^d\rightarrow\mathbb{R}$的梯度为：
$$
\nabla f=\left(\begin{array}{c}
\frac{\partial f}{\partial x_{1}} \\
\frac{\partial f}{\partial x_{2}} \\
\vdots \\
\frac{\partial f}{\partial x_{d}}
\end{array}\right)
$$


函数$f:\mathbb{R}^d\rightarrow\mathbb{R}$的Hessian矩阵为
$$
\nabla^{2} f=\left(\begin{array}{ccc}
\frac{\partial^{2} f}{\partial x_{1}^{2}} & \cdots & \frac{\partial^{2} f}{\partial x_{1} \partial x_{d}} \\
\vdots & \ddots & \vdots \\
\frac{\partial^{2} f}{\partial x_{d} \partial x_{1}} & \cdots & \frac{\partial^{2} f}{\partial x_{d}^{2}}
\end{array}\right)
$$

## Gradient Descent

梯度下降法

**一般迭代步骤**

目标函数 $\min\limits_x f(x)$

迭代：$x_{t+1}=x_{t}-\eta_{t} \nabla f\left(x_{t}\right)$

### $\eta_t$的选取

**精确线性搜索**

$\eta_{t}=\arg \min _{\eta} f(x-\eta \nabla f(x))$

往往这是不切实际的

**回溯线搜索**

我们令$\alpha\in(1,\frac{1}{2}],\beta\in(0,1)$，$\eta$从$\eta=1$出发，并不断迭代$\eta=\beta\eta$直到
$$
f(x-\eta \nabla f(x)) \leq f(x)-\alpha \eta\|\nabla f(x)\|^{2}
$$
这种方法在实际操作中效果较佳

## Convergence Analysis

收敛性分析

假设函数$f$是凸函数且可导，那么它是利普希茨连续的(Lipschitz continuous)：
$$
\|\nabla f(x)-\nabla f(y)\|_{2} \leq L\|x-y\|_{2}
$$
**定理**

固定步长$\eta\le\frac{1}{L}$的梯度下降法满足
$$
f\left(x_{t}\right)-f^{*} \leq \frac{\left\|x_{0}-x^{*}\right\|_{2}^{2}}{2 t \eta}
$$
为了实现$f\left(x_{t}\right)-f^{*} \leq\epsilon$，我们需要$O(1 / \epsilon)$次的迭代

回溯线搜索的有着相同的收敛速度

### 强凸性下的收敛性分析

假设$f$为强凸函数且$m$为常数

**定理**

固定步长$\eta\le2/(m+L)$或者回溯线搜索的梯度下降法满足
$$
f\left(x_{t}\right)-f^{*} \leq c^{t} \frac{L}{2}\left\|x_{0}-x^{*}\right\|_{2}^{2}
$$
此处$0<c<1$

为了实现$f\left(x_{t}\right)-f^{*} \leq\epsilon$，我们需要$O(\log(1 / \epsilon))$次的迭代

这被称为线性收敛

## Newton’s Method

牛顿法求解最值问题

**思路：从一个点出发，寻找它附近比它更接近导数为0的点的点**

任意一个函数$f(x)$可以写成如下的形式：
$$
f(x) \approx f(x-x_k)+\nabla f(x-x_k)^{\top} (x-x_k)+\frac{1}{2} (x-x_k)^{\top} \nabla^{2} f(x-x_k) (x-x_k)
$$
其中，$x$为$x_k$附近的一个点。如果令$\approx$变成$=$，对上式的右边对$x$求导数，并令其为0（即，使$f\prime(x)=0$)，则有
$$
\nabla f(x_k) + \nabla^{2} f(x_k) (x-x_k)=0
$$

整理得到


$$
x=x_k-\left[\nabla^{2} f(x_k)\right]^{-1} \nabla f(x_k)
$$

这个式子表明，在近似情况下，从$x_k$来看，$x$是使得$f\prime(x)$为$0$的点，即最值点。

那么我们可以认为，在不近似的情况下$x$是比$x_k$更加接近导数为0的点的点。

因此我们可以得到如下的迭代过程
$$
x_{k+1}=x_k-\left[\nabla^{2} f(x_k)\right]^{-1} \nabla f(x_k)
$$
牛顿法的一般迭代步骤如下：

1. 给定终止误差值$0\leq\epsilon\ll1$，初始点$x\in R_n$，$k=0$
2. 计算$g_{k}=\nabla f\left(x_{k}\right)$，若$\left\|g_{k}\right\| \leq \varepsilon$，则终止迭代
3. 计算$G_{k}=\nabla^2 f\left(x_{k}\right)$，并求解线性方程组得解$d_{k}: G_{k} d=-g_{k}$
4. 令$x_{k+1}=x_{k}+d_{k}, k=k+1$，并转2。

也可以给定步长迭代。

**牛顿法的条件**

1. $f$是强凸函数
2. $\nabla f(x),\nabla^2 f(x)$都是利普希茨连续的

**牛顿法的性质**

1. 二次收敛：收敛比率为$O(\log(\log(1 / \epsilon)))$
2. 局部二次收敛:我们只保证经过若干步k后的二次收敛。
3. 缺点：计算Hessian矩阵的逆矩阵比较耗费资源，后来出现了Quasi-Newton, Approximate Newton

## Lagrangian Method

从一个优化问题出发
$$
\begin{array}{l}
\min\limits_{x} f(x) \\
\text { s.t. } g_{i}(x) \leq 0, i=1,2, \ldots, m \\
\quad h_{j}(x)=0, j=1,2, \ldots, n
\end{array}
$$
我们定义拉格朗日函数为
$$
L(x, u, v)=f(x)+\sum_{i=1}^{m} u_{i} g_{i}(x)+\sum_{j=1}^{n} v_{j} h_{j}(x) \qquad ,u_i\ge0
$$
（本质上是把约束条件转化为惩罚函数加入目标：这是一个最小化的目标，令$u_i\ge0$意味着要想最小化$L$，$g_i(x)$必须越小越好）

$\forall u\ge0 ,v $和可行的$x$，我们有（因为$L$函数的定义域比$f$函数的定义域更大，或者说：约束更小）
$$
L(x, u, v) \leq f(x)
$$

### 拉格朗日对偶函数

$C$表示原始的可行解，$f^*$表示原始的最优解，在所有的$x$上最小化$L(x,u,v)$会得到$f^*$的更小的边界，$\forall u\ge0,v$，即
$$
f^{*} \geq \min _{x \in C} L(x, u, v) \geq \min _{x} L(x, u, v)=g(u, v)
$$
对偶函数的形式为
$$
g(u, v)=\min _{x} L(x, u, v)
$$
对于初始的问题，拉格朗日对偶问题为
$$
\begin{array}{l}
\max\limits _{u, v} g(u, v) \\
\text {s.t. } u \geq 0
\end{array}
$$

#### 性质

1. 弱对偶性
   $$
   f^*\ge g^*
   $$

2. 对偶问题是一个凸优化问题，即使原优化问题并不是凸的

$$
g(u, v)=\min _{x}\left\{f(x)+\sum_{i=1}^{m} u_{i} g_{i}(x)+\sum_{j=1}^{n} v_{j} h_{j}(x)\right\}
$$

3. 函数$g(u,v)$是凹的

**强对偶性**

在某些情况下（原问题是凸的），我们可以观察到$f^*=g^*$，这被称为强对偶性

**斯莱特条件**（Slater’s condition，充分条件）

如果原问题是凸优化问题，且至少存在一个严格可行的$x$，满足
$$
g_{1}(x)<0, \ldots, g_{m}(x)<0 \text { and } h_{1}(x)=\ldots h_{n}(x)=0
$$
那么强对偶性满足。



![UTOOLS1587872480002.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587872480002.png)



# 参考文献

1. [理解牛顿法](<https://zhuanlan.zhihu.com/p/37588590>)
2. [优化算法——牛顿法(Newton Method)](<https://blog.csdn.net/google19890102/article/details/41087931>)
3. [Newton's method](<https://en.wikipedia.org/wiki/Newton%27s_method>)
4. [Backtracking line search](<https://en.wikipedia.org/wiki/Backtracking_line_search>)
5. [Line search](<https://en.wikipedia.org/wiki/Line_search>)