# Control flow

## While循环语句

```julia
while *condition*
    *loop body*
end
```
#### 举例

```julia
while n < 10
    n += 1
    println(n)
end

>1
2
3
4
5
6
7
8
9
10
10
```

```julia
myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you!")
    i += 1
end

>Hi Ted, it's great to see you!
Hi Robyn, it's great to see you!
Hi Barney, it's great to see you!
Hi Lily, it's great to see you!
Hi Marshall, it's great to see you!

```

## For循环语句

```julia
for *var* in *loop iterable*
    *loop body*
end
```

#### 举例

```julia
myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

for friend in myfriends
    println("Hi $friend, it's great to see you!")
end

>Hi Ted, it's great to see you!
Hi Robyn, it's great to see you!
Hi Barney, it's great to see you!
Hi Lily, it's great to see you!
Hi Marshall, it's great to see you!
```

```julia
m, n = 5, 5
A = fill(0, (m, n))

>5×5 Array{Int64,2}:
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end
A

>5×5 Array{Int64,2}:
 2  3  4  5   6
 3  4  5  6   7
 4  5  6  7   8
 5  6  7  8   9
 6  7  8  9  10
```

### for语句的其他形式

```julia
B = fill(0, (m, n))

>5×5 Array{Int64,2}:
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0
 0  0  0  0  0

for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

>5×5 Array{Int64,2}:
 2  3  4  5   6
 3  4  5  6   7
 4  5  6  7   8
 5  6  7  8   9
 6  7  8  9  10
```

```julia
C = [i + j for i in 1:m, j in 1:n]

>5×5 Array{Int64,2}:
 2  3  4  5   6
 3  4  5  6   7
 4  5  6  7   8
 5  6  7  8   9
 6  7  8  9  10
```

## If条件语句

```julia
if *condition 1*
    *option 1*
elseif *condition 2*
    *option 2*
else
    *option 3*
end
```

#### 举例

```julia
julia> N =4
4

julia> if (N % 3 == 0) && (N % 5 == 0) # `&&` means "AND"; % computes the remainder after division
           println("FizzBuzz")
       elseif N % 3 == 0
           println("Fizz")
       elseif N % 5 == 0
           println("Buzz")
       else
           println(N)
       end
4
```

### if语句的其他形式

#### 三元运算符

```julia
a ? b : c
```
这等同于

```julia
if a
    b
else
    c
end
```
#### 使用语句连接符

```julia
julia> x=3
3

julia> (x > 0) && error("x cannot be greater than 0")
ERROR: x cannot be greater than 0
Stacktrace:
 [1] error(::String) at ./error.jl:33
 [2] top-level scope at REPL[8]:1

julia> x=-4
-4

julia> (x > 0) && error("x cannot be greater than 0")
false
```



```julia
julia> true || println("hi")
true

julia> false || println("hi")
hi
```

