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
    initialValue: boolean,

    update: (value: boolean) -> (),
}

type styles = {
    transparency: RoactBinding<number>,
    background: RoactBinding<Color3>,
}

local function Toggle(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef() :: RoactRef<TextButton>)
    local toggle = hooks.useValue(props.initialValue)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            transparency = props.initialValue and 0 or 1,
            background = props.info.theme.elementColor,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        toggle.value = props.initialValue
    end, { props.initialValue })

    return Roact.createElement(Templates.Toggle, {
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
            ref = ref.value :: any,
            theme = props.info.theme,
        }),

        Tip = RoactTemplate.wrapped(Tip, {
            ref = props.info.ref,
            description = props.info.description or "",
            theme = props.info.theme,
            opened = props.info.tip.opened,
            update = props.info.tip.update,
        }),

        Toggle = {
            [Roact.Children] = {
                Outline = {
                    ImageColor3 = props.info.theme.schemeColor,
                },

                Fill = {
                    ImageColor3 = props.info.theme.schemeColor,
                    ImageTransparency = styles.transparency,
                },
            },
        },

        Name = {
            TextColor3 = props.info.theme.textColor,
            Text = props.info.name,
        },
    })
end

return (RoactHooks.new(Roact :: any)(Toggle) :: any) :: RoactElementFn<props>
