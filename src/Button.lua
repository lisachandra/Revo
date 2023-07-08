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

type props = {
    info: Types.Info,
    pressed: () -> (),
}

type styles = {
    background: RoactBinding<Color3>,
}

local function Button(props: props, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local ref = hooks.useValue(Roact.createRef())

            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    background = window.theme.elementColor,
                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            return e(Templates.Button, {
                [Roact.Ref] = ref.value :: any,

                BackgroundColor3 = styles.background,
                LayoutOrder = props.info.order,

                [Roact.Event.MouseButton1Click] = props.pressed,

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

                Name = {
                    TextColor3 = window.theme.textColor,
                    Text = props.info.name,
                },

                Icon = { ImageColor3 = window.theme.schemeColor },
            })
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Button) :: any) :: RoactElementFn<props>
