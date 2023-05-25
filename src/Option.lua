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
    selected: RoactBinding<string>,
    select: (option: string) -> (),
}

type styles = {
    background: RoactBinding<Color3>
}

local function Option(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef() :: RoactRef<TextButton>)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            background = props.selected:getValue() and props.theme.schemeColor or props.theme.elementColor,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    return Roact.createElement(Templates.Option, {
        [Roact.Ref] = ref.value :: any,

        TextColor3 = Color3.fromRGB(
            (props.theme.textColor.R * 255) - 6, 
            (props.theme.textColor.G * 255) - 6, 
            (props.theme.textColor.B * 255) - 6
        ),

        LayoutOrder = props.order,
        Text = "  " .. props.option,
        BackgroundColor3 = styles.background,

        [Roact.Event.MouseButton1Click] = function(_self: TextButton)
            props.select(props.option)
        end,

        [Roact.Event.MouseEnter] = function(_self: TextButton)
            local color = props.selected:getValue() and props.theme.schemeColor or props.theme.elementColor

            api.start({
                background = Color3.fromRGB(
                    (color.R * 255) + 8,
                    (color.G * 255) + 9,
                    (color.B * 255) + 10
                ),
           }) 
        end,

        [Roact.Event.MouseLeave] = function(_self: TextButton)
            api.start({
                background = props.selected:getValue() and props.theme.schemeColor or props.theme.elementColor,
            }) 
        end,
    }, {
        Ripple = RoactTemplate.wrapped(Ripple, {
            ref = ref.value :: any,
            theme = props.theme,
        }),
    })
end

return (RoactHooks.new(Roact :: any)(Option) :: any) :: RoactElementFn<props>
