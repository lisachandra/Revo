--loadstring(game:HttpGet("https://github.com/zxibs/Revo/raw/main/src/init.lua"))()

if not getfenv(1).__packager then
    local Packager: Packager = loadstring(game:HttpGet("https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/raw/"))()

    Packager("evaera", "roblox-lua-promise", "v4.0.0", "lib", { "Promise" })()
    Packager("Roblox", "roact", "v1.4.4", "src", { "Roact", "React" })()
    Packager("Kampfkarren", "roact-hooks", "main", "src", { "RoactHooks" })()
    Packager("chriscerie", "roact-spring", "v1.1.5", "src", { "RoactSpring" })()

    return Packager("zxibs", "Revo", "main", "src")()
end

return table.freeze({
    Themes = require(script.Themes),

    Window = require(script.Window),
    Label = require(script.Label),
    Page = require(script.Page),
    
    Toggle = require(script.Toggle),
    Button = require(script.Button),
    Keybind = require(script.Keybind),
    TextBox = require(script.TextBox),
    Dropdown = require(script.Dropdown),
    ColorPicker = require(script.ColorPicker),
})
