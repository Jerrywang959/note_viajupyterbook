# Packages

julia有专门的包管理工具——Pkg，可以用 ]进入pkg管理页面，也可以使用`using Pkg` `Pkg.xxx`来管理Pkg

```julia
(@v1.4) pkg> add Colors
   Updating registry at `~/.julia/registries/General`
   Updating git-repo `https://github.com/JuliaRegistries/General.git`
  Resolving package versions...
   Updating `~/.julia/environments/v1.4/Project.toml`
 [no changes]
   Updating `~/.julia/environments/v1.4/Manifest.toml`
 [no changes]

julia> using Colors

julia> palette = distinguishable_colors(100)
100-element Array{RGB{N0f8},1} with eltype RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(1.0,1.0,0.455)
 RGB{N0f8}(1.0,0.608,1.0)
 RGB{N0f8}(0.0,0.827,1.0)
 RGB{N0f8}(0.886,0.388,0.051)
 RGB{N0f8}(0.0,0.494,0.0)
 RGB{N0f8}(0.0,0.314,0.902)
 RGB{N0f8}(0.675,0.0,0.278)
 ⋮
 RGB{N0f8}(0.855,0.0,0.247)
 RGB{N0f8}(0.18,0.129,0.141)
 RGB{N0f8}(0.0,0.345,0.082)
 RGB{N0f8}(1.0,0.557,0.114)
 RGB{N0f8}(0.4,0.455,0.694)
 RGB{N0f8}(0.0,0.804,0.678)
 RGB{N0f8}(0.0,0.498,0.388)
 RGB{N0f8}(0.6,0.435,0.239)

julia> rand(palette, 3, 3)
3×3 Array{RGB{N0f8},2} with eltype RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.196,0.212,0.024)  …  RGB{N0f8}(0.62,0.62,0.467)
 RGB{N0f8}(0.0,0.498,0.388)       RGB{N0f8}(0.655,0.525,0.0)
 RGB{N0f8}(0.306,0.427,0.314)     RGB{N0f8}(1.0,0.306,0.78)
```

RGB的向量在nteract中输出会自动渲染成颜色，而在repl不会。

![UTOOLS1587175869785.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587175869785.png)

![UTOOLS1587175884467.png](https://mypictuchuang.oss-cn-shenzhen.aliyuncs.com/UTOOLS1587175884467.png)

