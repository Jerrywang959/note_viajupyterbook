# 数据
能够轻松加载和处理数据是一项至关重要的任务，它可以使任何数据科学变得更加愉快。在本笔记本中，我们将介绍数据科学任务中经常遇到的最常见类型，并将在本教程的其余部分中使用这些数据。

using BenchmarkTools
using DataFrames
using DelimitedFiles
using CSV
using XLSX

cd("../../../")
pwd()

## 🗃️ 获得数据
在Julia中，使用`download`功能从网络下载文件非常容易。但同时，你可以使用自己喜欢的命令行commad通过轻松通过从朱莉娅切换到下载文件`;`键。让我们都尝试一下。

注意：“download”取决于外部工具，例如`curl`，`wget`或`fetch`。因此，您必须拥有其中之一。

?download

P = download("https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv",
    "programminglanguages.csv")

与此相同的命令为

;wget "https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv"

## 📂 从文本文件中读取数据
这里的关键问题是要从文件中加载数据，例如csv文件，xlsx文件或原始文本文件。我们将介绍一些Julia软件包，这些软件包将使我们能够非常轻松地读取此类文件。

### DelimitedFiles

让我们从标准库中的软件包`DelimitedFiles`开始。

#;head programminglanguages.csv

用`DelimitedFiles`中的`readdlm`读取csv文件。其中，P为数据，H为header

#=
readdlm(source, 
    delim::AbstractChar, 
    T::Type, 
    eol::AbstractChar; 
    header=false, 
    skipstart=0, 
    skipblanks=true, 
    use_mmap, 
    quotes=true, 
    dims, 
    comments=false, 
    comment_char='#')
=#
P,H = readdlm("$(pwd())/programming_languages.csv",',';header=true);

P

H

### 写入数据

writedlm("programminglanguages_dlm.txt", P, '-')

### CSV
此处使用的更强大的软件包是`CSV`软件包。默认情况下，CSV包将数据导入到`DataFrame`中，这具有许多优点，如下所示。

通常，推荐使用[`CSV.jl`]（https://juliadata.github.io/CSV.jl/stable/） 加载CSV。仅当您有一个更复杂的文件要指定多个内容时，才使用`DelimitedFlies”`。

C = CSV.read("programming_languages.csv");

读取DataFrame中的某些数据

@show typeof(C)
C[1:10,:]

C.year 

C[!,:year]

查看DataFrames的变量名

names(C)

用`describe()`函数以得到C的变量描述

describe(C)

用`@btime`测试两种读取方式的速度

@btime P,H = readdlm("programming_languages.csv",',';header=true);
@btime C = CSV.read("programming_languages.csv");

### XLXS
读取xlsx文件

T = XLSX.readdata("$(pwd())/datas/julia_datascience_data/zillow_data_download_april2020.xlsx", #file name
    "Sale_counts_city", #sheet name
    "A1:F9" #cell range
    )

也可以选择不指定单元格的范围，但这样会花费更多的时间

G = XLSX.readtable("$(pwd())/datas/julia_datascience_data/zillow_data_download_april2020.xlsx","Sale_counts_city"); 

G

G[1]

G[1][1][1:10]

G[2][1:10]

而且我们可以轻松地将此数据存储在DataFrame中

DataFrame(G[1],G[2])

typeof(G)

 `DataFrame(G...)`使用`splat`运算符_unwrap_这些数组并将它们传递给DataFrame构造函数。

D = DataFrame(G...)

使用`by`函数以获得特性DataFrame列的函数映射

by(D,:StateName,size)

通过向量创建DataFrame

foods = ["apple", "cucumber", "tomato", "banana"]
calories = [105,47,22,105]
prices = [0.85,1.6,0.8,0.6,]
dataframe_calories = DataFrame(item=foods,calories=calories)
dataframe_prices = DataFrame(item=foods,price=prices)

合并DataFrame

DF = join(dataframe_calories,dataframe_prices,on=:item)

直接把矩阵转化为DataFrame

DataFrame(T)

#### 写入XLXS文件

XLSX.writetable("filename.xlsx",collect(DataFrames.eachcol(df)), DataFrames.names(df))

# XLSX.writetable("writefile_using_XLSX.xlsx",G[1],G[2])

## ⬇️ Importing your data

通常，要导入的数据不是以纯文本格式存储的，可能要导入其他类型的类型。在这里，我们将介绍导入`jld`，`npz`，`rda`和`mat`文件的过程。希望这四种能够从数据科学中使用的四种常见编程语言（Julia，Python，R，Matlab）中捕获类型。

在这里，我们将使用一个非常小的矩阵的玩具示例。但是相同的语法适用于较大的文件。

```
4×5 Array{Int64,2}:
 2  1446  1705  1795  1890
 3  2926  3121  3220  3405
 4  2910  3022  2937  3224
 5  1479  1529  1582  1761
 ```

using JLD
jld_data = JLD.load("$(pwd())/datas/julia_datascience_data/mywrite.jld")
save("mywrite.jld", "A", jld_data)

using NPZ
npz_data = npzread("$(pwd())/datas/julia_datascience_data/mytempdata.npz")
npzwrite("mywrite.npz", npz_data)

using RData
R_data = RData.load("$(pwd())/datas/julia_datascience_data/mytempdata.rda")
# We'll need RCall to save here. https://github.com/JuliaData/RData.jl/issues/56
using RCall
@rput R_data
R"save(R_data, file=\"mywrite.rda\")"

using MAT
Matlab_data = matread("$(pwd())/datas/julia_datascience_data/mytempdata.mat")
matwrite("mywrite.mat",Matlab_data)

@show typeof(jld_data)
@show typeof(npz_data)
@show typeof(R_data)
@show typeof(Matlab_data)
;

jld_data["A"]["tempdata"]

npz_data

R_data["tempdata"]

Matlab_data["tempdata"]

# 🔢 处理来自julia的数据
我们将主要介绍`Matrix`（或`Vector`），`DataFrames`和`Dict`（或`Dictionary`）。让我们带回编程语言集，并开始将其存储在矩阵中。

P

以下是一些我们可能想问这个简单数据的快速问题。  
- 哪一种语言是哪一年发明的？
- 一年中创建了几种语言？

function year_created(P,language::String)
    loc = findfirst(P[:,2] .== language)
    return P[loc,1]
end
year_created(P,"Julia")

year_created(P,"W")

改进函数并给出报错信息，`return`之后函数将直接结束

function year_created_handle_error(P,language::String)
    loc = findfirst(P[:,2] .== language)
    !isnothing(loc) && return P[loc,1]
    error("Error: Language not found.")
end
year_created_handle_error(P,"W")

# Q2: 一个给定的年中，有多少语言被创造了
function how_many_per_year(P,year::Int64)
    year_count = length(findall(P[:,1].==year))
    return year_count
end
how_many_per_year(P,2011)

把数据储存在DataFrame中

P_df = C  #DataFrame(year = P[:,1], language = P[:,2]) # or DataFrame(P)

更好的是，由于我们知道每一列的类型，因此可以如下创建DataFrame:

P_df = DataFrame(year = Int.(P[:,1]), language = string.(P[:,2]))

使用DataFrame解决刚刚的两个问题

Q1：给定语言是哪一年发明的？
- 更加直观，无需记住列ID


function year_created(P_df,language::String)
    loc = findfirst(P_df.language .== language)
    return P_df.year[loc]
end
year_created(P_df,"Julia")

Q2：在一年中创建了几种语言？

function how_many_per_year(P_df,year::Int64)
  year_count = length(findall(P_df.year.==year))
  return year_count
end
how_many_per_year(P_df,2011)

接下来，我们将使用字典。创建字典的快速方法是使用`Dic()`命令。但这会创建一个没有类型的字典。在这里，我们将指定此字典的类型。

# 一个简单的例子来展示如何构建字典
Dict([("A", 1), ("B", 2),(1,[1,2])])

创建字典并指定类型

P_dictionary = Dict{Integer,Vector{String}}()

符合预创建类型的字典可以插入，不符合的则将无法插入

 P_dictionary[67] = ["julia","programming"]       

P_dictionary["julia"] = 7

P_dictionary

现在，让我们用年份作为键和向量填充字典，这些键和向量将每年创建的所有编程语言作为其值。用遍历的方法进行

P_dictionary = Dict{Integer,Vector{String}}()  # 重新创建P_dictionary
dict = Dict{Integer,Vector{String}}()
for i = 1:size(P,1)
    year,lang = P[i,:]
    if year in keys(dict)
        dict[year] = push!(dict[year],lang) 
        # note that push! is not our favorite thing do in Julia, 
        # but we're focusing on correctness rather than speed here
    else
        dict[year] = [lang]
    end
end

尽管更聪明的方法是：

P_dictionary = Dict{Integer,Vector{String}}()   # 重新创建P_dictionary
curyear = P_df.year[1]
P_dictionary[curyear] = [P_df.language[1]]
for (i,nextyear) in enumerate(P_df.year[2:end])
    if nextyear == curyear
        #same key
        P_dictionary[curyear] = push!(P_dictionary[curyear],P_df.language[i+1])
    else
        curyear = nextyear
        P_dictionary[curyear] = [P_df.language[i+1]]
    end
end

注意`push!`在朱莉娅不是我们最喜欢的事情，但是我们在这里专注于正确性而不是速度


length(keys(P_dictionary))

length(unique(P[:,1]))

我们用字典来解决刚才的问题

Q1：给定语言是哪一年发明的？

现在，我们将寻找许多小的向量，而不是寻找一个长向量

function year_created(P_dictionary,language::String)
    keys_vec = collect(keys(P_dictionary))
    lookup = map(keyid -> findfirst(P_dictionary[keyid].==language),keys_vec)
# 现在查找向量没有任何值或数值。我们想找到数值的索引。
    return keys_vec[findfirst((!isnothing).(lookup))]
end
year_created(P_dictionary,"Julia")

问题2：在一年中创建了几种语言？

how_many_per_year(P_dictionary,year::Int64) = length(P_dictionary[year])
how_many_per_year(P_dictionary,2011)

## 📝 A note about missing data

创建一个有missing值的DataFrame

P[1,1] = missing
P_df = DataFrame(year = P[:,1], language = P[:,2])

用`dropmissing()`删去有missing数值的行

dropmissing(P_df)

## Finally...
After finishing this notebook, you should be able to:
- [ ] dowload a data file from the web given a url
- [ ] load data from a file from a text file via DelimitedFiles or CSV
- [ ] write your data to a text file or csv file
- [ ] load data from file types xlsx, jld, npz, mat, rda
- [ ] write your data to an xlsx file, jld, npz, mat, rda
- [ ] store data in a 2D array (`Matrix`), or `DataFrame` or `Dict`
- [ ] write functions to perform basic lookups on `Matrix`, `DataFrame`, and `Dict` types
- [ ] use some of the basic functions on `DataFrame`s such as: `dropmissing`, `describe`, `by`, and `join`