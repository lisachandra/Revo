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

type props = Types.elementProps<boolean>
type styles = {
    transparency: RoactBinding<number>,
    background: RoactBinding<Color3>,
}

local function Toggle(props: props, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local ref = hooks.useValue(Roact.createRef() :: RoactRef<GuiButton>)
            local toggle = hooks.useValue(props.initialValue)
        
            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    transparency = props.initialValue and 0 or 1,
                    background = window.theme.elementColor,
                    config = RoactSpring.config.stiff :: any,
                }
            end)
        
            local styles: styles = styles
        
            hooks.useEffect(function()
                toggle.value = props.initialValue
            end, { props.initialValue })
        
            return e(Templates.Toggle, {
                [Roact.Ref] = ref.value :: any,
        
                BackgroundColor3 = styles.background,
                LayoutOrder = props.info.order,
        
                [Roact.Event.MouseButton1Click] = function(_self: TextButton)
                    local value = not toggle.value; api.start({
                        transparency = value and 0 or 1
                    })
        
                    toggle.value = value
                    props.update(value)
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
        
                Toggle = {
                    [Roact.Children] = {
                        Outline = {
                            ImageColor3 = window.theme.schemeColor,
                        },
        
                        Fill = {
                            ImageColor3 = window.theme.schemeColor,
                            ImageTransparency = styles.transparency,
                        },
                    },
                },
        
                Name = {
                    TextColor3 = window.theme.textColor,
                    Text = props.info.name,
                },
            }) 
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Toggle) :: any) :: RoactElementFn<props>
