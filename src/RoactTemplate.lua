local RoactTemplate: RoactTemplate = loadstring(game:HttpGet("https://gist.github.com/zxibs/d4224c6e364ce7cffad17a33b259c500/raw/0e8484c3fce2a3e0763d68bc74494d4ebd9467b6/RoactTemplate.lua"))()

setfenv(RoactTemplate.fromInstance, setmetatable({
    require = require,
}, {
    __index = function(_self, key)
        return getfenv()[key]
    end,

    __newindex = function(_self, key, value)
        getfenv()[key] = value
    end,
}) :: any)

return RoactTemplate

