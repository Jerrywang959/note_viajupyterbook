---
description: Julia中对于字符串的操作
---

# String

### 生成字符串

```julia
julia> a="hello, world"
"hello, world"
```

### 多行字符串

并且可以包含字符串内的双引号

```julia
julia> a=""" hello,
       world,
       I am julia """
" hello,\nworld,\nI am julia "
```

### 字符串内使用变量的实际数值

用\$

```julia
julia> name = "Jane"
"Jane"

julia> println("Hello, my name is $name.")
Hello, my name is Jane.
```

### 合并字符串

```julia
julia> s3 = "How many cats ";

julia> s4 = "is too many cats?";

julia> string(s3, s4)
"How many cats is too many cats?"

julia> s3*s4
"How many cats is too many cats?"

julia> "$s3$s4"
"How many cats is too many cats?"
```


