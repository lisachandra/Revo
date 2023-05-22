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
Using and loading Revo in a single script using [Packager](https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/)
```lua
-- This means you can load your exploit normally using loadstring

if not getfenv(1).__packager then
    local Packager = loadstring(game:HttpGet("https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/raw/"))()

    return Packager("user", "repo", "branch", "src")()
end

local Revo = loadstring(game:HttpGet("https://github.com/zxibs/Revo/raw/main/src/init.lua"))()

...
```
