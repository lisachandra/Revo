# Revo
Kavo inspired UI Library with Roact
## How to use
Using Revo in a script loaded by [Packager](https://gist.github.com/zxibs/f1a148a72a058636296c0bc991aca130/)
```lua
local Revo: Revo = loadstring(game:HttpGet("https://github.com/zxibs/Revo/raw/main/src/init.lua"))()

-- Require already loaded dependencies (assuming this is the init.lua file)
local Roact = require(script.Parent.Roact)
local RoactHooks = require(script.Parent.RoactHooks)
local RoactSpring = require(script.Parent.RoactSpring)

local tree

local function App()
	return e("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = false,
		ResetOnSpawn = false,
		Enabled = true,
	}, {
		Window = e(Revo.Window, {
			visible = true,
			theme = Revo.Themes.Blood,
			title = "Test",
        	close = function()
    			Roact.unmount(tree)
			end,
		}, {
			Test1 = e(Revo.Page, {}, {
				Label = e(Revo.Label, {
					info = {
						description = "Label",
						order = 0,
					},
				}),

				Toggle = e(Revo.Toggle, {
					initialValue = false,
					info = {
						description = "This is a Toggle element",
						order = 1,
					},
				
					update = function(value)
						print("current value of the Toggle is:", value)
					end,
				}),

				Button = e(Revo.Button, {
					info = {
						description = "This is a button element",
						order = 2,
					},
				
					pressed = function()
						print("the button has been pressed")
					end,
				}),

				Keybind = e(Revo.Keybind, {
					initialValue = Enum.KeyCode.Pause,
					info = {
						description = "This is a Keybind element",
						order = 3,
					},
				
					update = function(value)
						print("current value of the Keybind is:", value)
					end,
				}),

				TextBox = e(Revo.TextBox, {
					initialValue = "",
					info = {
						description = "This is a TextBox element",
						order = 4,
					},
				
					update = function(value)
						print("current value of the TextBox is:", value)
					end,
				}),

				Dropdown = e(Revo.Dropdown, {
					initialValue = "One",
					info = {
						description = "This is a Dropdown element",
						order = 5,
					},

					options = { "One", "Two", "Three" },
				
					update = function(value)
						print("current value of the Dropdown is:", value)
					end,
				}),

				ColorPicker = e(Revo.ColorPicker, {
					initialValue = Color3.new(),
					info = {
						description = "This is a ColorPicker element",
						order = 6,
					},
				
					update = function(value)
						print("current value of the ColorPicker is:", value)
					end,
				}),
			}),
		})
	})
end

tree = Roact.mount(e(App), gethui())

```
