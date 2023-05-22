local RoactTemplate: RoactTemplate = loadstring(game:HttpGet("https://gist.github.com/zxibs/d4224c6e364ce7cffad17a33b259c500/raw"))()

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

