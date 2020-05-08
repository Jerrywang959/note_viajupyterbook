# Basic

## 生成向量或矩阵

```julia
julia> A = rand(1:4,3,3)
3×3 Array{Int64,2}:
 4  2  4
 4  2  3
 1  2  2

julia> x = fill(1.0, (3,))
3-element Array{Float64,1}:
 1.0
 1.0
 1.0


```

## 乘和转置

```julia
julia> b = A*x
3-element Array{Float64,1}:
 10.0
  9.0
  5.0

julia> A'
3×3 LinearAlgebra.Adjoint{Int64,Array{Int64,2}}:
 4  4  1
 2  2  2
 4  3  2

julia> transpose(A)
3×3 LinearAlgebra.Transpose{Int64,Array{Int64,2}}:
 4  4  1
 2  2  2
 4  3  2

julia> A'A
3×3 Array{Int64,2}:
 33  18  30
 18  12  18
 30  18  29
```

## `\`

从方程 $Ax=b$ 求解x，其中$A$为方阵

```julia
julia> A\b
3-element Array{Float64,1}:
 1.0
 1.0
 1.0
```

如果`/`前是一个**过度确定的线性系统**(least squares solution)(高矩阵)，我们会得到一个**最小二乘法**的解。

```julia
julia> Atall = rand(3, 2)
3×2 Array{Float64,2}:
 0.509259   0.199434
 0.927561   0.92623
 0.0378898  0.165023

julia> Atall\b
2-element Array{Float64,1}:
 17.8463824370428
 -6.596395027758899
```

如果是**秩不足的最小二乘问题**，则会得到**最小范数最小二乘解**

```julia
julia> v = rand(3)
3-element Array{Float64,1}:
 0.5216257841057546
 0.5350262816162525
 0.6433750280513937

julia> rankdef = hcat(v, v)
3×2 Array{Float64,2}:
 0.521626  0.521626
 0.535026  0.535026
 0.643375  0.643375

julia> rankdef\b
2-element Array{Float64,1}:
 6.813056253069082
 6.81305625306908
```

如果`\`前面的是**未定的问题**(underdetermined solution)(短矩阵)

```julia
julia> bshort = rand(2)
2-element Array{Float64,1}:
 0.8352714299155983
 0.8146631376007327

julia> Ashort = rand(2, 3)
2×3 Array{Float64,2}:
 0.287498  0.153943   0.231742
 0.479411  0.0772732  0.197439

julia> Ashort\bshort
3-element Array{Float64,1}:
 0.7691000398938104
 1.434562771848009
 1.697210113213556
```

## 内积、外积、叉积

### 内积

```julia
julia> v = [1,2,3]
3-element Array{Int64,1}:
 1
 2
 3

julia> v'v
14
```

### 叉积

```julia
julia> using LinearAlgebra

julia> cross_v=cross(v,v)
3-element Array{Int64,1}:
 0
 0
 0
```

### 外积

```julia
julia> outer_v=reshape(kron(v,v),length(v),length(v))
3×3 Array{Int64,2}:
 1  2  3
 2  4  6
 3  6  9
```



