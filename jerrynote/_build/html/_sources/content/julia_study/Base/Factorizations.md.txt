# Factorizations

因式分解相关函数，出现了一些我并不能看懂的线性代数方法。

## LU factorizations

> 在[线性代数](https://zh.wikipedia.org/wiki/%E7%BA%BF%E6%80%A7%E4%BB%A3%E6%95%B0)与[数值分析](https://zh.wikipedia.org/wiki/%E6%95%B0%E5%80%BC%E5%88%86%E6%9E%90)中，**LU分解**是[矩阵分解](https://zh.wikipedia.org/wiki/%E7%9F%A9%E9%98%B5%E5%88%86%E8%A7%A3)的一种，将一个[矩阵](https://zh.wikipedia.org/wiki/%E7%9F%A9%E9%98%B5)分解为一个[下三角矩阵](https://zh.wikipedia.org/wiki/%E4%B8%89%E8%A7%92%E7%9F%A9%E9%98%B5)和一个[上三角矩阵](https://zh.wikipedia.org/wiki/%E4%B8%89%E8%A7%92%E7%9F%A9%E9%98%B5)的乘积，有时需要再乘上一个[置换矩阵](https://zh.wikipedia.org/wiki/%E7%BD%AE%E6%8D%A2%E7%9F%A9%E9%98%B5)。LU分解可以被视为[高斯消元法](https://zh.wikipedia.org/wiki/%E9%AB%98%E6%96%AF%E6%B6%88%E5%8E%BB%E6%B3%95)的矩阵形式。在[数值计算](https://zh.wikipedia.org/wiki/%E6%95%B0%E5%80%BC%E8%AE%A1%E7%AE%97)上，LU分解经常被用来解[线性方程组](https://zh.wikipedia.org/wiki/%E7%BA%BF%E6%80%A7%E6%96%B9%E7%A8%8B%E7%BB%84)、且在求[反矩阵](https://zh.wikipedia.org/wiki/%E5%8F%8D%E7%9F%A9%E9%99%A3)和计算[行列式](https://zh.wikipedia.org/wiki/%E8%A1%8C%E5%88%97%E5%BC%8F)中都是一个关键的步骤。

$$
PA = LU
$$

$$A$$ 是被分解的矩阵，$$P$$ 是置换矩阵，$$L$$ 是下三角矩阵，$$U$$是上三角矩阵。



使用函数`lu()`进行LU分解，using `lufact`.

```julia
julia> A = rand(3, 3)
3×3 Array{Float64,2}:
 0.111894  0.730218   0.283805
 0.66003   0.487591   0.945071
 0.644679  0.0101276  0.862639

julia> using LinearAlgebra

julia> Alu = lu(A)
LU{Float64,Array{Float64,2}}
L factor:
3×3 Array{Float64,2}:
 1.0        0.0       0.0
 0.169529   1.0       0.0
 0.976742  -0.719817  1.0
U factor:
3×3 Array{Float64,2}:
 0.66003  0.487591  0.945071
 0.0      0.647557  0.123588
 0.0      0.0       0.0285094
```

使用`.P`,`.L`,`.U`调用分解后的P矩阵,L矩阵或U矩阵

```julia
julia> Alu.P
3×3 Array{Float64,2}:
 0.0  1.0  0.0
 1.0  0.0  0.0
 0.0  0.0  1.0

julia> Alu.L
3×3 Array{Float64,2}:
 1.0        0.0       0.0
 0.169529   1.0       0.0
 0.976742  -0.719817  1.0

julia> Alu.U
3×3 Array{Float64,2}:
 0.66003  0.487591  0.945071
 0.0      0.647557  0.123588
 0.0      0.0       0.0285094
```

Julia的多重分派可以使得对一个被分解后的矩阵整体进行某些操作，并得到相同结果。以下例子包括了**矩阵“除法”**和求**行列式**

```julia
julia> b=rand(3)
3-element Array{Float64,1}:
 0.7071667357222131
 0.14187417923162382
 0.8633724393268927

julia> A\b
3-element Array{Float64,1}:
 -55.646676986062815
  -7.08892173833099
  42.67067045131066

julia> Alu\b
3-element Array{Float64,1}:
 -55.646676986062815
  -7.08892173833099
  42.67067045131066

julia> det(A) ≈ det(Alu)
true
```

## QR factorizations

> **QR分解法**是三种将[矩阵分解](https://zh.wikipedia.org/wiki/%E7%9F%A9%E9%98%B5%E5%88%86%E8%A7%A3)的方式之一。这种方式，把[矩阵](https://zh.wikipedia.org/wiki/%E7%9F%A9%E9%98%B5)分解成一个[正交矩阵](https://zh.wikipedia.org/wiki/%E6%AD%A3%E4%BA%A4%E7%9F%A9%E9%98%B5)与一个[上三角矩阵](https://zh.wikipedia.org/wiki/%E4%B8%8A%E4%B8%89%E8%A7%92%E7%9F%A9%E9%98%B5)的积。QR分解经常用来解[线性最小二乘法](https://zh.wikipedia.org/wiki/%E7%BA%BF%E6%80%A7%E6%9C%80%E5%B0%8F%E4%BA%8C%E4%B9%98%E6%B3%95)问题。QR分解也是特定[特征值算法](https://zh.wikipedia.org/w/index.php?title=%E7%89%B9%E5%BE%81%E5%80%BC%E7%AE%97%E6%B3%95&action=edit&redlink=1)即[QR算法](https://zh.wikipedia.org/w/index.php?title=QR%E7%AE%97%E6%B3%95&action=edit&redlink=1)的基础。

$$
A=QR
$$

$$A$$ 为被分解的矩阵，$$Q$$是正交矩阵，$$R$$是上三角矩阵



使用`qr()`对矩阵进行QR分解操作，using `qrfact`

```julia
julia> using LinearAlgebra

julia> Aqr = qr(A)
LinearAlgebra.QRCompactWY{Float64,Array{Float64,2}}
Q factor:
3×3 LinearAlgebra.QRCompactWYQ{Float64,Array{Float64,2}}:
 -0.120395   0.891848   0.436018
 -0.710173   0.229519  -0.665563
 -0.693656  -0.389779   0.605734
R factor:
3×3 Array{Float64,2}:
 -0.929392  -0.441214  -1.30371
  0.0        0.759207   0.133785
  0.0        0.0        0.0172691
```

使用`.Q`,`.R`调用分解后的$$Q$$矩阵,$$R$$矩阵

```julia
julia> Aqr.Q
3×3 LinearAlgebra.QRCompactWYQ{Float64,Array{Float64,2}}:
 -0.120395   0.891848   0.436018
 -0.710173   0.229519  -0.665563
 -0.693656  -0.389779   0.605734

julia> Aqr.R
3×3 Array{Float64,2}:
 -0.929392  -0.441214  -1.30371
  0.0        0.759207   0.133785
  0.0        0.0        0.0172691
```

## Eigendecompositions

特征分解，奇异值分解，Hessenberg分解和Schur分解的结果are all stored in `Factorization` types[^1].



用`eigen`求解矩阵特征值和特征向量

```julia
julia> Asym = A + A'
3×3 Array{Float64,2}:
 0.223788  1.39025   0.928484
 1.39025   0.975182  0.955199
 0.928484  0.955199  1.72528

julia> AsymEig = eigen(Asym)
Eigen{Float64,Float64,Array{Float64,2},Array{Float64,1}}
values:
3-element Array{Float64,1}:
 -0.8530493828857049
  0.5600188449031531
  3.21727866868319
vectors:
3×3 Array{Float64,2}:
  0.812969   -0.337866  -0.474266
 -0.57692    -0.577869  -0.577262
 -0.0790263   0.74291   -0.664711

julia> AsymEig.values
3-element Array{Float64,1}:
 -0.8530493828857049
  0.5600188449031531
  3.21727866868319

julia> AsymEig.vectors
3×3 Array{Float64,2}:
  0.812969   -0.337866  -0.474266
 -0.57692    -0.577869  -0.577262
 -0.0790263   0.74291   -0.664711
```



Once again, when the factorization is stored in a type, we can dispatch on it and write specialized methods that exploit the properties of the factorization, e.g. that $$    A^{-1}=(V\Lambda V^{-1})^{-1}=V\Lambda^{-1}V^{-1}$$.[^2]

```julia
julia> inv(AsymEig)*Asym
3×3 Array{Float64,2}:
  1.0           1.66533e-15  -3.88578e-16
 -6.66134e-16   1.0           0.0
  8.88178e-16  -8.88178e-16   1.0
```



## Special matrix structures

矩阵结构在线性代数中非常重要。要了解它的重要性，让我们使用更大的线性系统

`issymmetric`检验一个矩阵是否是对称阵，并返回true or false

```julia
julia> using LinearAlgebra
julia> n = 1000;
julia> A = randn(n,n);
julia> Asym = A + A';
julia> issymmetric(Asym)
true
```

```julia
julia> Asym_noisy = copy(Asym);
julia> Asym_noisy[1,2] += 5eps();
julia> issymmetric(Asym_noisy);
false
```











[^1]: 我不太理解，因此保留英文
[^2]: 这句话我也不懂，还是保留了英文