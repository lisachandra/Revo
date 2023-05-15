--loadstring(game:HttpGet("https://github.com/zxibs/Revo/raw/main/src/init.lua"))()

local Packager: Packager = loadstring(game:HttpGet("https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/raw/8c2fb87e5d9701bbad22916462480ed528d6f6ef/Packager.lua"))()

Packager("Roblox", "roact", "master", "src", { "Roact", "React" })()
Packager("evaera", "roblox-lua-promise", "master", "lib", { "Promise" })()
Packager("howmanysmall", "Janitor", "main", "src")()
Packager("Kampfkarren", "roact-hooks", "main", "src", { "RoactHooks" })()
Packager("chriscerie", "roact-spring", "main", "src", { "RoactSpring" })()

local Roact: Roact = require(script.Parent.Roact) :: any
local RoactHooks = require(script.Parent.RoactHooks)

type props = {}

local function Revo(props: props, hooks)
    
end

return RoactHooks.new(Roact :: any)(Revo)
