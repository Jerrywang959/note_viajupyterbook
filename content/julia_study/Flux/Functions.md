# Fuctions

## `gradient`

求导函数，亦称求梯度函数

### 基本用法

**df(x) = gradient(f, x)**      

df为导函数，f为原函数，x为求导变量

**gradient(f, [2, 1], [2, 0])**

f为原函数，后面两个数组为函数的两个参数向量，该语句返回函数在某一点的导数（梯度）

**gs=gradient(params(x, y))   do   f(x, y) end**

通过处理参数集合`params`来获取导数

## `params`

返回函数参数的函数

## `update!`

按照一定的方式更新网络参数





