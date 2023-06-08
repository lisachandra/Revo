local GuiService = cloneref(game:GetService("GuiService"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Ripple = require(script.Parent.Ripple)
local Tip = require(script.Parent.Tip)

local e = Roact.createElement
local w = RoactTemplate.wrapped

local function round(num: number, dp: number)
    local mult = 10 ^ (dp or 0)
    return math.floor((num * mult) + 0.5) / mult
end

type props = {
    info: Types.info,
    initialValue: Color3,

    update: (value: Color3) -> (),
}

type styles = {
    rainbowToggleTransparency: RoactBinding<number>,
    background: RoactBinding<Color3>,
    canvasSize: RoactBinding<UDim2>,
}

local function zigzag(t: number)
    return math.acos(math.cos((t / 100) * math.pi)) / math.pi
end

local function ColorPicker(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef() :: RoactRef<TextButton>)

    local colorRef = hooks.useValue(Roact.createRef() :: RoactRef<ImageButton & { Cursor: ImageLabel }>)
    local opacityRef = hooks.useValue(Roact.createRef() :: RoactRef<ImageButton & { Cursor: ImageLabel }>)
    
    local frames = hooks.useValue(0)
    local opened = hooks.useValue(false)
    local rainbowConnection = hooks.useValue(nil :: RBXScriptConnection?)
    
    local hsv: RoactBinding<table>, updateHsv = hooks.useBinding({ Color3.toHSV(props.initialValue) })

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            background = props.info.theme.elementColor,
            canvasSize = UDim2.fromOffset(352, 33),
            rainbowToggleTransparency = 1,

            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        updateHsv({ Color3.toHSV(props.initialValue) })
    end, { props.initialValue })

    hooks.useEffect(function()
        return function()
            if rainbowConnection.value then
                rainbowConnection.value:Disconnect()
                rainbowConnection.value = nil
            end
        end
    end, {})

    return e(Templates.ColorPicker, {
        Size = styles.canvasSize,
        LayoutOrder = props.info.order,
    }, {
        Header = {
            [Roact.Ref] = ref.value :: any,

            BackgroundColor3 = styles.background,

            [Roact.Event.MouseButton1Click] = function(_self: TextButton)
                opened.value = not opened.value

                api.start({
                    canvasSize = opened.value and UDim2.fromOffset(352, 141) or UDim2.fromOffset(352, 33),
                })
            end :: any,

            [Roact.Event.MouseEnter] = function(_self: TextButton)
                api.start({
                    background = Color3.fromRGB(
                        (props.info.theme.elementColor.R * 255) + 8,
                        (props.info.theme.elementColor.G * 255) + 9,
                        (props.info.theme.elementColor.B * 255) + 10
                    ),
                }) 
            end,
    
            [Roact.Event.MouseLeave] = function(_self: TextButton)
                api.start({
                    background = props.info.theme.elementColor,
                }) 
            end,

            [Roact.Children] = {
                Ripple = w(Ripple, {
                    ref = ref.value :: any,
                    theme = props.info.theme,
                }),
        
                Tip = w(Tip, {
                    ref = props.info.ref,
                    description = props.info.description or "",
                    theme = props.info.theme,
                    location = props.info.location,
                }),
        
                Name = {
                    TextColor3 = props.info.theme.textColor,
                    Text = props.info.name,
                },

                Color = {
                    BackgroundColor3 = hsv:map(function(value)
                        return Color3.fromHSV(table.unpack(value))
                    end),
                },

                Icon = { ImageColor3 = props.info.theme.schemeColor },
            },
        },

        Inners = {
            BackgroundColor3 = props.info.theme.elementColor,

            [Roact.Children] = {
                Values = {
                    [Roact.Children] = {
                        R = {
                            [Roact.Children] = {
                                Value = {
                                    TextColor3 = props.info.theme.textColor,

                                    BackgroundColor3 = Color3.fromRGB(
                                        (props.info.theme.elementColor.R * 255) + 13,
                                        (props.info.theme.elementColor.G * 255) + 13,
                                        (props.info.theme.elementColor.B * 255) + 13
                                    ),

                                    Text = hsv:map(function(value)
                                        local color = Color3.fromHSV(table.unpack(value))

                                        return `{round(color.R * 255, 2)}`
                                    end),

                                    [Roact.Event.FocusLost] = function(self: TextBox, enterPressed: boolean)
                                        if rainbowConnection.value then return end

                                        local r: number? = enterPressed and tonumber(self.Text) :: any; if r then
                                            r = math.clamp(r, 0, 255)
                                            local color = Color3.fromHSV(table.unpack(hsv:getValue()))

                                            updateHsv({ Color3.toHSV(Color3.new(r / 255, color.G, color.B)) })
                                        end
                                    end,
                                },

                                Name = { TextColor3 = props.info.theme.textColor },
                            },
                        },

                        G = {
                            [Roact.Children] = {
                                Value = {
                                    TextColor3 = props.info.theme.textColor,

                                    BackgroundColor3 = Color3.fromRGB(
                                        (props.info.theme.elementColor.R * 255) + 13,
                                        (props.info.theme.elementColor.G * 255) + 13,
                                        (props.info.theme.elementColor.B * 255) + 13
                                    ),

                                    Text = hsv:map(function(value)
                                        local color = Color3.fromHSV(table.unpack(value))

                                        return `{round(color.G * 255, 2)}`
                                    end),

                                    [Roact.Event.FocusLost] = function(self: TextBox, enterPressed: boolean)
                                        if rainbowConnection.value then return end

                                        local g: number? = enterPressed and tonumber(self.Text) :: any; if g then
                                            g = math.clamp(g, 0, 255)
                                            local color = Color3.fromHSV(table.unpack(hsv:getValue()))

                                            updateHsv({ Color3.toHSV(Color3.new(color.R, g / 255, color.B)) })
                                        end
                                    end,
                                },

                                Name = { TextColor3 = props.info.theme.textColor },
                            },
                        },

                        B = {
                            [Roact.Children] = {
                                Value = {
                                    TextColor3 = props.info.theme.textColor,

                                    BackgroundColor3 = Color3.fromRGB(
                                        (props.info.theme.elementColor.R * 255) + 13,
                                        (props.info.theme.elementColor.G * 255) + 13,
                                        (props.info.theme.elementColor.B * 255) + 13
                                    ),

                                    Text = hsv:map(function(value)
                                        local color = Color3.fromHSV(table.unpack(value))

                                        return `{round(color.B * 255, 2)}`
                                    end),

                                    [Roact.Event.FocusLost] = function(self: TextBox, enterPressed: boolean)
                                        if rainbowConnection.value then return end

                                        local b: number? = enterPressed and tonumber(self.Text) :: any; if b then
                                            b = math.clamp(b, 0, 255)
                                            local color = Color3.fromHSV(table.unpack(hsv:getValue()))

                                            updateHsv({ Color3.toHSV(Color3.new(color.R, color.G, b / 255)) })
                                        end
                                    end,
                                },

                                Name = { TextColor3 = props.info.theme.textColor },
                            },
                        },
                    },
                },

                Rainbow = {
                    [Roact.Children] = {
                        Fill = {
                            [Roact.Event.InputBegan] = function(_self: ImageLabel, input: InputObject)
                                if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                                    return
                                end

                                while true do
                                    input.Changed:Wait()

                                    if input.UserInputState == Enum.UserInputState.End then
                                        break
                                    end
                                end

                                if rainbowConnection.value then
                                    rainbowConnection.value:Disconnect()
                                    rainbowConnection.value = nil
                                else
                                    rainbowConnection.value = RunService.RenderStepped:Connect(function()
                                        frames.value += 1

                                        updateHsv({ zigzag(frames.value), 1, 1 })
                                        props.update(Color3.fromHSV(table.unpack(hsv:getValue())))
                                    end)
                                end

                                api.start({
                                    rainbowToggleTransparency = rainbowConnection.value and 0 or 1,
                                })
                            end,

                            ImageColor3 = props.info.theme.schemeColor,
                            ImageTransparency = styles.rainbowToggleTransparency,
                        },

                        Outline = { ImageColor3 = props.info.theme.schemeColor },

                        Name = { TextColor3 = props.info.theme.textColor },
                    },
                },

                Opacity = {
                    [Roact.Ref] = opacityRef.value :: any,

                    [Roact.Children] = {
                        Cursor = {
                            Position = hsv:map(function(value)
                                local opacity = opacityRef.value:getValue(); if opacity then
                                    return UDim2.new(0.5, 0, 1 - value[3], -opacity.Cursor.AbsoluteSize.Y / 2)
                                end

                                return UDim2.new()
                            end),

                            ImageColor3 = hsv:map(function(value)
                                return Color3.fromHSV(0, 0, value[3])
                            end),
                        }
                    } :: any,

                    [Roact.Event.InputBegan] = function(_self: ImageButton, input: InputObject)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local connection; connection = RunService.RenderStepped:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    connection:Disconnect()
                                    connection = nil :: any
                                    return
                                end

                                local opacity = opacityRef.value:getValue()
                                local mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset().Y)
                                local y = mousePosition.Y - opacity.AbsolutePosition.Y
                                local currentHsv = hsv:getValue()

                                if y < 0 then
                                    y = 0
                                end

                                if y > opacity.AbsoluteSize.Y then
                                    y = opacity.AbsoluteSize.Y
                                end

                                updateHsv({ currentHsv[1], currentHsv[2], 1 - (y / opacity.AbsoluteSize.Y) })
                                props.update(Color3.fromHSV(table.unpack(hsv:getValue())))
                            end)
                        end
                    end,
                },

                Color = {
                    [Roact.Ref] = colorRef.value :: any,

                    [Roact.Children] = {
                        Cursor = {
                            Position = hsv:map(function(value)
                                local color = colorRef.value:getValue(); if color then
                                    local cursorSize = color.Cursor.AbsoluteSize / 2
                                    return UDim2.new(1 - value[1], -cursorSize.X, 1 - value[2], -cursorSize.Y)
                                end

                                return UDim2.new()
                            end),

                            ImageColor3 = hsv:map(function(value)
                                return Color3.fromHSV(table.unpack(value))
                            end),
                        }
                    } :: any,

                    [Roact.Event.InputBegan] = function(_self: ImageButton, input: InputObject)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local connection; connection = RunService.RenderStepped:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    connection:Disconnect()
                                    connection = nil :: any
                                    return
                                end

                                local color = colorRef.value:getValue()
                                local mousePosition = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset().Y)
                                local x, y = mousePosition.X - color.AbsolutePosition.X, mousePosition.Y - color.AbsolutePosition.Y

                                if x < 0 then
                                    x = 0
                                end

                                if x > color.AbsoluteSize.X then
                                    x = color.AbsoluteSize.X
                                end

                                if y < 0 then
                                    y = 0
                                end

                                if y > color.AbsoluteSize.Y then
                                    y = color.AbsoluteSize.Y
                                end

                                updateHsv({ 1 - (x / color.AbsoluteSize.X), 1 - (y / color.AbsoluteSize.Y), hsv:getValue()[3] })
                                props.update(Color3.fromHSV(table.unpack(hsv:getValue())))
                            end)
                        end
                    end,
                }, 
            },
        },
    })
end

return (RoactHooks.new(Roact :: any)(ColorPicker) :: any) :: RoactElementFn<props>
