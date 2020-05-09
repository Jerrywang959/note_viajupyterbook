# Functions

## Declare a function

### 标准形式

用 fuction … end 声明一个函数

```julia
julia> function sayhi(name)
           println("Hi $name, it's great to see you!")
       end
sayhi (generic function with 1 method)

julia> sayhi("C-3PO")
Hi C-3PO, it's great to see you!
```

### 简介形式

```julia
julia> sayhi2(name) = println("Hi $name, it's great to see you!")
sayhi2 (generic function with 1 method)

julia> sayhi2("R2D2")
Hi R2D2, it's great to see you!
```

### 匿名函数形式

```julia
julia> sayhi3 = name -> println("Hi $name, it's great to see you!")
#3 (generic function with 1 method)

julia> sayhi3("Chewbacca")
Hi Chewbacca, it's great to see you!
```

## Duck-typing

> If it walks like a duck and it quacks like a duck, then it must be a duck

函数方法不依赖于对象的类型，其他类型的对象会尽可能地调用方法，若能调用成功，则函数对于此类型的对象可用。julia的函数即是这样的。

```julia
julia> function sayhi(name)
                 println("Hi $name, it's great to see you!")
             end
sayhi (generic function with 1 method)

julia> sayhi(55595472)
Hi 55595472, it's great to see you!
```

```julia
julia> f(x)=x^2
f (generic function with 1 method)

julia> f("hi")
"hihi"

julia> f(rand(3,3))
3×3 Array{Float64,2}:
 0.738116  0.982017  0.529161
 0.339603  0.528315  0.473647
 0.494267  0.500296  0.365849

julia> f(rand(3))
ERROR: MethodError: no method matching ^(::Array{Float64,1}, ::Int64)
Closest candidates are:
  ^(::Float16, ::Integer) at math.jl:885
  ^(::Regex, ::Integer) at regex.jl:712
  ^(::Missing, ::Integer) at missing.jl:155
  ...
Stacktrace:
 [1] macro expansion at ./none:0 [inlined]
 [2] literal_pow at ./none:0 [inlined]
 [3] f(::Array{Float64,1}) at ./REPL[4]:1
 [4] top-level scope at REPL[7]:1
```

## Mutating vs. non-mutating functions

带`!`的函数会改变输入的参数，不带`!`的函数不会改变输入的参数

```julia
julia> v = [3, 5, 2]
3-element Array{Int64,1}:
 3
 5
 2

julia> sort(v);v
3-element Array{Int64,1}:
 3
 5
 2

julia> sort!(v);v
3-element Array{Int64,1}:
 2
 3
 5
```

## higher order functions

高阶函数

### map

把一个函数分别传递到一个数据结构中的每一个数，并映射到函数值

`map(f, [1, 2, 3])`将得到`[f(1), f(2), f(3)]`

```julia
julia> map(x -> x^3, [1, 2, 3])
3-element Array{Int64,1}:
  1
  8
 27
```

### broadcast

`broadcast(f, [1, 2, 3])`将得到`f.([1, 2, 3])`

```julia
julia> f(x)=x^2
f (generic function with 1 method)

julia> A = [i + 3*j for j in 0:2, i in 1:3]
3×3 Array{Int64,2}:
 1  2  3
 4  5  6
 7  8  9

julia> A .+ 2 .* f.(A) ./ A
3×3 Array{Float64,2}:
  3.0   6.0   9.0
 12.0  15.0  18.0
 21.0  24.0  27.0

julia> broadcast(x -> x + 2 * f(x) / x, A)
3×3 Array{Float64,2}:
  3.0   6.0   9.0
 12.0  15.0  18.0
 21.0  24.0  27.0
```



