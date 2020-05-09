# DataStructure

## Tuples

#### 创建元组

`(item1, item2, ...)`

```julia
julia> myfavoriteanimals = ("penguins", "cats", "sugargliders")
("penguins", "cats", "sugargliders")
```

#### 索引元组

julia是从1开始索引

```julia
julia> myfavoriteanimals[1]
"penguins"
```

#### 不能改变元组

因为它是immutable的

```julia
julia> myfavoriteanimals[1] = "otters"
ERROR: MethodError: no method matching setindex!(::Tuple{String,String,String}, ::String, ::Int64)
Stacktrace:
 [1] top-level scope at REPL[10]:1
```

### NamedTuples

和一般的元组一样，只是把元组内部的每个元素都有一个name，用数字或者.name索引

`(name1 = item1, name2 = item2, ...)`

```julia
julia> myfavoriteanimals = (bird = "penguins", mammal = "cats", marsupial = "sugargliders")
(bird = "penguins", mammal = "cats", marsupial = "sugargliders")

julia> myfavoriteanimals[1]
"penguins"

julia> myfavoriteanimals.bird
"penguins"

```

## Dictionary

#### 创建字典

`Dict(key1 => value1, key2 => value2, ...)`，字典的值需是相同的类型

```julia
julia> myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2368")
Dict{String,String} with 2 entries:
  "Jenny"        => "867-5309"
  "Ghostbusters" => "555-2368"
```

#### 读取字典内容

```julia
julia> myphonebook["Jenny"]
"867-5309"
```

#### 增加字典内容

```julia
julia> myphonebook["Kramer"]="555-FILK"
"555-FILK"

julia> myphonebook
Dict{String,String} with 3 entries:
  "Jenny"        => "867-5309"
  "Kramer"       => "555-FILK"
  "Ghostbusters" => "555-2368"
```

#### 删除一个键值对应并返回值

使用`pop!`

```julia
julia> pop!(myphonebook, "Kramer")
"555-FILK"

julia> myphonebook
Dict{String,String} with 2 entries:
  "Jenny"        => "867-5309"
  "Ghostbusters" => "555-2368"
```

## Arrays

与Tuples不同，Arrays是可变的；与Dictionary不同，Arrays是有序的

`[item1, item2, ...]`

#### 创建Arrays

返回的类型中，第一个“String”表示Arrays内元素的类型，1表示Arrays的维度

```julia
julia> myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
5-element Array{String,1}:
 "Ted"
 "Robyn"
 "Barney"
 "Lily"
 "Marshall"

julia> fibonacci = [1, 1, 2, 3, 5, 8, 13]
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

julia> mixture = [1, 1, 2, 3, "Ted", "Robyn"]
6-element Array{Any,1}:
 1
 1
 2
 3
  "Ted"
  "Robyn"

```

#### 索引Arrays

用数字所在的序号索引

```julia
julia> myfriends[3]
"Barney"

```

#### 修改Arrays某一索引

```julia
julia> myfriends[3] = "Baby Bop"
"Baby Bop"

```

#### 增加和减少Arrays

`push!`,`pop!`

```julia
julia> push!(fibonacci, 21)
8-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13
 21

julia> pop!(fibonacci)
21

julia> fibonacci
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

```

### 复杂的Arrays

可以是多个维度的Arrays，也可以是Arrays的Arrays

```julia
julia> favorites = [["koobideh", "chocolate", "eggs"],["penguins", "cats", "sugargliders"]]
2-element Array{Array{String,1},1}:
 ["koobideh", "chocolate", "eggs"]
 ["penguins", "cats", "sugargliders"]

julia> numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
3-element Array{Array{Int64,1},1}:
 [1, 2, 3]
 [4, 5]
 [6, 7, 8, 9]

julia> rand(4, 3)
4×3 Array{Float64,2}:
 0.580342  0.840483  0.590226
 0.612861  0.801844  0.859797
 0.742443  0.590106  0.649077
 0.477118  0.72509   0.342509

julia> rand(4, 3, 2)
4×3×2 Array{Float64,3}:
[:, :, 1] =
 0.888219  0.384393  0.0619398
 0.473101  0.204024  0.784434
 0.72608   0.92305   0.100044
 0.815554  0.161155  0.416701

[:, :, 2] =
 0.305238   0.530652   0.74287
 0.484455   0.0904463  0.105327
 0.0632765  0.818537   0.704337
 0.152749   0.0189906  0.120929

```

### 创建副本防止绑定更新

使用`=`生产的新Arrays，内存地址上和原来的Arrays是相同的，因此会同时更新

```julia
julia> fibonacci
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

julia> somenumbers = fibonacci
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

julia> somenumbers[1] = 404
404

julia> fibonacci
7-element Array{Int64,1}:
 404
   1
   2
   3
   5
   8
  13

```

若要防止此情况，使用copy创建新的Arrays

```julia
julia> fibonacci
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

julia> somemorenumbers = copy(fibonacci)
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13

julia> somemorenumbers[1] = 404
404

julia> fibonacci
7-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13
```

