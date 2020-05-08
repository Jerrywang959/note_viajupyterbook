# 矩阵相关知识

## Orthogonal Matrices
如果一个矩阵$$Q\in R^{n\times n} $$满足
$$
Q^TQ=I
$$
则它为正交矩阵


## Tall Matrices with Orthonormal Columns

具有正交列的高矩阵

如果一个矩阵$Q\in\mathbb{R}^{n\times m},(m>n)$并具有正交列，满足

1. $Q^\top Q=I$
2. $QQ^\top\not=I$

则它为具有正交列的高矩阵

## General Matrix Norms

一个范数——norm是一个函数$\|\cdot\|$，满足：

1. $\|A\|\geq0$，当且仅当$A=0$时等号成立
2. $\|A+B\|\le\|A\|+\|B\|$
3. $\|\alpha A\|=|a|\|A\|$

### p-范数诱导的矩阵范数

向量$\mathbf{x}$的p-范数
$$
\|\mathbf{x}\|_{p}=\left(\left|x_{1}\right|^{p}+\left|x_{2}\right|^{p}+\cdots+\left|x_{n}\right|^{p}\right)^{1 / p}
$$
矩阵的p范数为
$$
\|\mathbf{A}\|_{p}=\max _{\mathbf{x} \neq 0} \frac{\|\mathbf{A} \mathbf{x}\|_{p}}{\|\mathbf{x}\|_{p}}
$$
例如，1-范数为
$$
\|\mathbf{A}\|_{1}=\max _{j} \sum_{i=1}^{n}\left|a_{i j}\right|
$$
这种由矢量范数诱导的矩阵范数称为 算子范数（operator norm）。

### **弗罗贝尼乌斯范数**(Frobenius norm)

矩阵$A\in\mathbb{R}^{m\times n}$的弗罗贝尼乌斯范数为

$$
\|\mathbf{A}\|_{F}=\left(\sum_{i=1}^{m} \sum_{j=1}^{n}\left|a_{i j}\right|^{2}\right)^{1 / 2}
$$

一些性质
$$
\|\mathbf{A}\|_{F}^{2}=\operatorname{trace}\left(\mathbf{A}^{\top} \mathbf{A}\right) \\
\|\mathbf{A B}\|_{F}=\|\mathbf{A}\|_{F}\|\mathbf{B}\|_{F}
$$
正交乘法下不变性
$$
\|\mathbf{Q A}\|_{2}=\|\mathbf{A}\|_{2} \quad\|\mathbf{Q A}\|_{F}=\|\mathbf{A}\|_{F}
$$
其中$Q$是一个正交矩阵

## Eigenvalue Decomposition

矩阵特征分解

对于一个方阵$A\in\mathbb{R}^{m\times n}$，我们称非0向量$\mathbf{x}\in\mathbb{R^n}$是其特征值$\lambda$对应的一个特征向量，如果：
$$
\mathbf{A x}=\lambda \mathbf{x}
$$
方针$A$的特征值分解为
$$
A=X \Lambda X^{-1}
$$
其中，$\mathbf{X}$是一个非奇异矩阵，且由$A$矩阵的特征向量组成；$\mathbf{\Lambda}$是一个对角线上的值为$A$矩阵的特征值的对角矩阵。

Note:

1. 不是所有的矩阵都有特征分解，一个矩阵有特征分解当且仅当它是可对角化的(diagonalizable)。
2. 实对称矩阵的特征值都是实数，且它的特征分解具有$\mathbf{A}=\mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{\top}$的形式，其中$Q$为正交矩阵。

### Singular Value Decomposition
奇异值分解 SVD

每一个矩阵$\mathbf{A}\in\mathbb{R}$都有如下的奇异值分解形式
$$
\mathbf{A}=\mathbf{U} \boldsymbol{\Sigma} \mathbf{V}^{\top}
$$
其中，$\mathbf{U}\in\mathbb{R}^{m\times m}$和$\mathbf{V}\in\mathbb{R}^{n\times n}$为正交矩阵，$\boldsymbol{\Sigma} \in \mathbb{R}^{m \times n}$是一个对角线上的值为$\mathbf{A}$的奇异值的对角矩阵

如果矩阵$\mathbf{A}$的秩为$r$，则$\mathbf{A}$的奇异值为
$$
\sigma_{1} \geq \sigma_{2} \geq \cdots \geq \sigma_{r} \geq \sigma_{r+1}=\ldots \sigma_{\min (m, n)}=0
$$

**Full SVD**

$U$是$m\times m$矩阵，$\Sigma$是$m\times n $矩阵

**Reduced SVD**

$U$是$m\times n$矩阵，$\Sigma$是$n\times n $矩阵

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587817818433.png)

#### 性质

1. $A$矩阵的非0奇异值是$A^\top A$的非0特征值的平方根

$$
\mathbf{A}^{\top} \mathbf{A}=\left(\mathbf{U} \boldsymbol{\Sigma} \mathbf{V}^{\top}\right)^{\top}(\mathbf{U} \boldsymbol{\Sigma} \mathbf{V})=\mathbf{V} \boldsymbol{\Sigma}^{\top} \mathbf{U}^{\top} \mathbf{U} \boldsymbol{\Sigma} \mathbf{V}^{\top}=\mathbf{V}\left(\boldsymbol{\Sigma}^{\top} \boldsymbol{\Sigma}\right) \mathbf{V}^{\top}
$$
2. 如果$A=A^\top$，则$A$的奇异值即为$A$的特征值

$$
\mathbf{A}=\mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{\top}=\mathbf{Q}|\mathbf{\Lambda}| \operatorname{sign}(\mathbf{\Lambda}) \mathbf{Q}^{\top}
$$

3. 


$$
\begin{aligned}
&\|\mathbf{A}\|_{2}=\sigma_{1}\\
&\|\mathbf{A}\|_{F}=\sqrt{\sigma_{1}^{2}+\sigma_{2}^{2}+\cdots+\sigma_{r}^{2}}
\end{aligned}
$$

4. 如果$\mathbf{U}=\left(\begin{array}{llll}\mathbf{u}_{1} & \mathbf{u}_{2} & \dots & \mathbf{u}_{m}\end{array}\right)$，$\mathbf{V}=\left(\begin{array}{llll}\mathbf{v}_{1} & \mathbf{v}_{2} & \dots & \mathbf{v}_{n}\end{array}\right)$，那么

$$
\mathbf{A}=\sum_{i=1}^{r} \sigma_{i} \mathbf{u}_{i} \mathbf{v}_{i}^{\top}
$$

#### Low-rank Approximation

低阶近似

$\mathbf{A}=\sum_{i=1}^{r} \sigma_{i} \mathbf{u}_{i} \mathbf{v}_{i}^{\top}$，我们设$\mathbf{A}_{k}=\sum_{i=1}^{k} \sigma_{i} \mathbf{u}_{i} \mathbf{v}_{i}^{\top},\quad 0<k<r$

**Eckart-Young Theorem**(埃卡特-杨定理)
$$
\begin{array}{c}
\min\limits _{\operatorname{rank}(\mathbf{B}) \leq k}\|\mathbf{A}-\mathbf{B}\|_{2}=\left\|\mathbf{A}-\mathbf{A}_{k}\right\|_{2}=\sigma_{k+1} \\
\min\limits _{\operatorname{rank} k(\mathbf{B}) \leq k}\|\mathbf{A}-\mathbf{B}\|_{F}=\left\|\mathbf{A}-\mathbf{A}_{k}\right\|_{F}=\sqrt{\sigma_{k+1}^{2}+\cdots+\sigma_{r}^{2}}
\end{array}
$$
$A_k$为秩为$k$的$A$的最佳近似



## Positive (semi-)definite matrices

正定矩阵和正半定矩阵

如果一个对称矩阵满足$\forall x \in \mathbb{R}^n, \ x^\top A x \ge 0$，则我们称它为半正定的(positive semi-definite, PSD)

如果一个对称矩阵满足$\forall x\not= 0, \ x\in\mathbb{R}^n, \ x^\top Ax >0$，则我们称他为正定的( positive definite ,PD)

正定性比半正定性具有更强的严格性

### 性质

1. **一个对称矩阵是半正定的当且仅当它的特征值都是非负值。**

证明如下，$x,\lambda$分别为$A$的特征向量和特征值
$$
0 \leq \mathbf{x}^{\top} \mathbf{A} \mathbf{x}=\mathbf{x}^{\top}(\lambda \mathbf{x})=\lambda \mathbf{x}^{\top} \mathbf{x}=\lambda\|\mathbf{x}\|_{2}^{2}
$$

2. **对一个半正定矩阵进行特征值分解等于对它进行奇异值分解**
3. 对于一个半正定矩阵$\mathbf{A}$，存在唯一一个半正定矩阵$\mathbf{B}$满足$\mathbf{B}^2=\mathbf{A}$

证明：

对$A$做特征值分解$\mathbf{A}=\mathbf{U} \mathbf{\Lambda} \mathbf{U}^{\top}$

令$\mathbf{B}=\mathbf{U} \mathbf{\Lambda}^{\frac{1}{2}} \mathbf{U}^{\top}$

有
$$
\mathbf{B}^{2}=\mathbf{U} \mathbf{\Lambda}^{\frac{1}{2}} \mathbf{U}^{\top} \mathbf{U} \mathbf{\Lambda}^{\frac{1}{2}} \mathbf{U}^{\top}=\mathbf{U} \mathbf{\Lambda}^{\frac{1}{2}} \mathbf{\Lambda}^{\frac{1}{2}} \mathbf{U}^{\top}=\mathbf{A}
$$

# 参考文献

1. [可对角化矩阵](<https://zh.wikipedia.org/w/index.php?title=%E5%8F%AF%E5%AF%B9%E8%A7%92%E5%8C%96%E7%9F%A9%E9%98%B5&oldid=57619445> )
2. [特征分解](<https://zh.wikipedia.org/wiki/%E7%89%B9%E5%BE%81%E5%88%86%E8%A7%A3>)[矩阵范数](<https://zh.wikipedia.org/wiki/%E7%9F%A9%E9%99%A3%E7%AF%84%E6%95%B8#p-%E8%8C%83%E6%95%B0%E8%AF%B1%E5%AF%BC%E7%9A%84%E7%9F%A9%E9%98%B5%E8%8C%83%E6%95%B0>)
3. [算子范数](<https://zh.wikipedia.org/wiki/%E7%AE%97%E5%AD%90%E8%8C%83%E6%95%B0>)
4. [The Eckart-Young Theorem](<https://legacy.voteview.com/ideal_point_Eckart_Young_Theorem.htm>)
5. [Low-rank approximation](<https://en.wikipedia.org/wiki/Low-rank_approximation>)