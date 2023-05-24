# Revo
Kavo inspired UI Library with Roact
## How to use
Using Revo in a script loaded by [Packager](https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/)
```lua
local Revo = loadstring(game:HttpGet("https://github.com/zxibs/Revo/raw/main/src/init.lua"))()

-- Require already loaded dependencies (assuming this is the init.lua file)
local Roact = require(script.Parent.Roact)
local RoactHooks = require(script.Parent.RoactHooks)
local RoactSpring = require(script.Parent.RoactSpring)

...
```
