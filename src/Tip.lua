local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

type props = {
    ref: RoactRef<Frame & { Tips: Frame }>,
    description: string,
    theme: Types.theme,

    opened: boolean,
    update: (value: boolean) -> (),
}

type internal = {
    template: RoactElement,
}

type styles = {
    position: RoactBinding<UDim2>,
}

local function Tip(props: props & internal, hooks: RoactHooks.Hooks)
    local ref = props.ref:getValue()

    local styles: any, api = RoactSpring.useSpring(function()
        return {
            position = UDim2.fromScale(0, 2),
            config = RoactSpring.config.gentle :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        api.start({
            position = if props.opened then
                UDim2.fromScale(0, 2)
            else
                UDim2.fromScale(0, 0)
        })
    end, { props.opened })

    return Roact.createFragment({
        Button = Roact.createElement(props.template, {
            ImageColor = props.theme.schemeColor,

            [Roact.Event.MouseButton1Click] = function(_self: TextButton)
                props.update(true)
            end,
        }),

        Tip = Roact.createElement(Roact.Portal, {
            target = ref.Tips :: Instance,
        }, {
            Tip = Roact.createElement(Templates.Tip, {
                BackgroundColor3 = Color3.fromRGB(
                    (props.theme.schemeColor.R * 255) - 14,
                    (props.theme.schemeColor.G * 255) - 17,
                    (props.theme.schemeColor.B * 255) - 13
                ),

                Position = styles.position,
            }, {
                Tip = { TextColor3 = props.theme.textColor }
            })
        })
    })
end

return (RoactHooks.new(Roact :: any)(Tip) :: any) :: RoactElementFn<props>
