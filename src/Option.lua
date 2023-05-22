local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Ripple = require(script.Parent.Ripple)

type props = {
    theme: Types.theme,
    option: string,
    order: number,
    select: (option: string) -> (),
}

type styles = {
    background: RoactBinding<Color3>
}

local function Option(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef())

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            background = props.theme.background,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    return Roact.createElement(Templates.Toggle, {
        [Roact.Ref] = ref.value :: any,

        TextColor3 = Color3.fromRGB(
            (props.theme.textColor.R * 255) - 6, 
            (props.theme.textColor.G * 255) - 6, 
            (props.theme.textColor.B * 255) - 6
        ),

        BackgroundColor3 = styles.background,
        LayoutOrder = props.order,
        Text = "  " .. props.option,

        [Roact.Event.MouseButton1Click] = function(_self: TextButton)
            props.select(props.option)
        end,

        [Roact.Event.MouseEnter] = function(_self: TextButton)
           api.start({
                background = Color3.fromRGB(
                    (props.theme.elementColor.R * 255) + 8,
                    (props.theme.elementColor.G * 255) + 9,
                    (props.theme.elementColor.B * 255) + 10
                ),
           }) 
        end,

        [Roact.Event.MouseLeave] = function(_self: TextButton)
            api.start({
                background = props.theme.elementColor,
            }) 
        end,
    }, {
        Ripple = RoactTemplate.wrapped(Ripple, {
            ref = ref.value,
            theme = props.theme,
        }),
    })
end

return (RoactHooks.new(Roact :: any)(Option) :: any) :: RoactElementFn<props>
