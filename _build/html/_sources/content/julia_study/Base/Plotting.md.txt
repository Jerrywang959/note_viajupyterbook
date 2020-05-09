# Plotting

## Plots

使用“Plots”这一Packages画图，Plots本质上也只是一个前端的工具，真正渲染制作出图片的其实是后端的一些程序。

### 后端程序

#### GR

输入以下的命令使用GR作为后端

```julia
julia> using Plots

julia> gr()
Plots.GRBackend()

julia> plot(rand(10))
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587193641664.png)

但GR对中文的图像标注并[不友好](<https://github.com/JuliaPlots/Plots.jl/issues/791>)，我在deepin linux 15.11上无法解决这一问题，因此选择了其他的后端

#### PlotlyJS

这一后端支持中文输入，需要额外安装`PlotlyJS`、`WebIO`和`ORCA`

##### 安装和配置

```julia
]add PlotlyJS ORCA WebIO
```

若从repl中画图，会自动弹出jupyter的Blink窗口，不需要配置WebIO。

若从jupyter中画图，则需要安装对应的插件

```julia
using WebIO
WebIO.install_jupyter_nbextension()
```

jupyterlab则使用以下的命令

```julia
using WebIO
WebIO.install_jupyter_nbextension()
```

以上命令最好在repl中进行，并杀死jupyter进程

nteract(0.22.4)貌似还未适配WebIO.jl，但安装jupyter 的插件后，不影响画图结果。

##### 使用PlotlyJS

使用如下命令把plotlyjs作为plots的后端

```julia
using Plots
plotlyjs()
```

这会一些warning，不知道为什么，但不影响画图结果

**举例**

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587193551486.png)

#### UnicodePlots

安装

```julia
] add UnicodePlots
```

使用

```
unicodeplots()
```

画出来效果如下

```julia
unicodeplots()
p1 = plot(x, x.^2)
title!("你好")
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587212238940.png)

这样的粗略的画图便于在命令行中展示，而且支持中文。

### 画图命令

#### plot

折线图

```julia
using Plots
plotlyjs()
x = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8];
y = [45000, 20000, 15000, 5000, 400, 17];
plot(x,y,title="test")
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587210550738.png)

#### scatter

散点图

```julia
using Plots
plotlyjs()
x = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8];
y = [45000, 20000, 15000, 5000, 400, 17];
scatter(x, y, label="points")
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587210577608.png)

```julia
using Plots
plotlyjs()
x = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8];
y = [45000, 20000, 15000, 5000, 400, 17];
plot(x,y,title="test")
scatter!(x, y, label="points")
```

后面的`!`表示在原图的基础上继续画图，而非生成一个新的图像

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587210843471.png)

**一些参数**

参数可以直接在plot函数的内部加上，也可以在画图之后以`!`函数的形式加上

```julia
using Plots
plotlyjs()
x = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8];
y = [45000, 20000, 15000, 5000, 400, 17];
plot(x,y,xlabel="这是x轴",ylabel="这是y轴",title="这是标题")
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587211334677.png)

```julia
using Plots
plotlyjs()
x = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8];
y = [45000, 20000, 15000, 5000, 400, 17];
plot(x,y)
xlabel!("这是x轴")
ylabel!("这是y轴")
title!("这是标题1")
```
![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587211508127.png)



#### xflip!

`xflip!()`翻转x轴，`yflip!()`反转y轴

#### 多个子图

用一个变量表示一个子图，最后用`plot`连接起来

```julia
using Plots
x=1:10
plotlyjs()
p1 = plot(x, x.+1)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1, p2, p3, p4, layout = (2, 2))
```

![](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587212809004.png)