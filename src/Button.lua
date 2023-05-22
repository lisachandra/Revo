local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Ripple = require(script.Parent.Ripple)
local Tip = require(script.Parent.Tip)

type props = {
    info: Types.info,

    pressed: () -> (),
}

type styles = {
    background: RoactBinding<Color3>,
}

local function Button(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef())

    local styles: any, api = RoactSpring.useSpring(function()
        return {
            background = props.info.theme.background,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    return Roact.createElement(Templates.Toggle, {
        [Roact.Ref] = ref.value :: any,

        BackgroundColor3 = styles.background,
        LayoutOrder = props.info.order,

        [Roact.Event.MouseButton1Click] = props.pressed,

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
    }, {
        Ripple = RoactTemplate.wrapped(Ripple, {
            ref = ref.value,
            theme = props.info.theme,
        }),

        Tip = RoactTemplate.wrapped(Tip, {
            ref = props.info.ref,
            description = props.info.description or "",
            theme = props.info.theme,
            opened = props.info.tip.opened,
            update = props.info.tip.update,
        }),

        Name = {
            TextColor3 = props.info.theme.textColor,
            Text = props.info.name,
        },

        Icon = { ImageColor3 = props.info.theme.schemeColor },
    })
end

return (RoactHooks.new(Roact :: any)(Button) :: any) :: RoactElementFn<props>