local UserInputService = cloneref(game:GetService("UserInputService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Ripple = require(script.Parent.Ripple)
local Tip = require(script.Parent.Tip)

local ESCAPE_INPUTS: { keybind } = {
    Enum.KeyCode.Escape,
    Enum.KeyCode.Unknown,
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.None,
    Enum.UserInputType.Focus,
    Enum.UserInputType.MouseWheel,
}

local e = Roact.createElement
local w = RoactTemplate.wrapped

type keybind = Enum.KeyCode | Enum.UserInputType
type props = Types.elementProps<keybind>
type styles = {
    background: RoactBinding<Color3>,
}

local function Keybind(props: props, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local ref = hooks.useValue(Roact.createRef() :: RoactRef<GuiButton>)

            local keybind: RoactBinding<keybind>, updateKeybind = hooks.useBinding(props.initialValue)

            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    background = window.theme.elementColor,
                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                updateKeybind(props.initialValue)
            end, { props.initialValue })

            return e(Templates.Keybind, {
                [Roact.Ref] = ref.value :: any,

                BackgroundColor3 = styles.background,
                LayoutOrder = props.info.order,

                [Roact.Event.MouseButton1Click] = function(_self: TextButton)
                    local old = keybind:getValue()

                    updateKeybind(nil :: any)

                    while true do
                        local input = UserInputService.InputBegan:Wait(); if input.KeyCode or input.UserInputType then
                            if table.find(ESCAPE_INPUTS, input.KeyCode or input.UserInputType) then
                                updateKeybind(old); break
                            end
                            
                            updateKeybind(input.KeyCode or input.UserInputType); break
                        end
                    end
                end,

                [Roact.Event.MouseEnter] = function(_self: TextButton)
                    api.start({
                        background = Color3.fromRGB(
                            (window.theme.elementColor.R * 255) + 8,
                            (window.theme.elementColor.G * 255) + 9,
                            (window.theme.elementColor.B * 255) + 10
                        ),
                    }) 
                end,

                [Roact.Event.MouseLeave] = function(_self: TextButton)
                    api.start({
                        background = window.theme.elementColor,
                    }) 
                end,
            }, {
                Ripple = w(Ripple, {
                    ref = ref.value,
                }),

                Tip = w(Tip, {
                    description = props.info.description or "",
                    location = props.info.location,
                }),

                Keybind = {
                    TextColor3 = window.theme.schemeColor,
                    Text = keybind:map(function(value)
                        if value then
                            props.update(value)
                        end
            
                        return value and value.Name or ". . ."
                    end),
                },

                Name = {
                    TextColor3 = window.theme.textColor,
                    Text = props.info.name,
                },

                Icon = { ImageColor3 = window.theme.schemeColor },
            })
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Keybind) :: any) :: RoactElementFn<props>
