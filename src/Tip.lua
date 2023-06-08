local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local e = Roact.createElement
local f = Roact.createFragment

type props = {
    ref: RoactRef<Types.Mainframe>,
    description: string,
    theme: Types.theme,
}

type internal = {
    template: RoactElement,
    location: string,
}

type styles = {
    position: RoactBinding<UDim2>,
}

local function Tip(props: props & internal, hooks: RoactHooks.Hooks) print("Tip")
    local Main = props.ref:getValue(); if not Main then
        return e("Frame", { Visible = false })
    end

    local history = RoactRouter.useHistory(hooks)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            position = UDim2.fromScale(0, 2),
            config = RoactSpring.config.gentle :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        api.start({
            position = if history.location.path:find(props.location) then
                UDim2.fromScale(0, 0)
            else
                UDim2.fromScale(0, 2)
        })
    end, { history, props.location } :: table)

    return f({
        Button = e(props.template, {
            ImageColor3 = props.theme.schemeColor,

            [Roact.Event.MouseButton1Click] = hooks.useCallback(function()
                history:push(props.location)
            end, { history, props.location } :: table),
        }),

        Tip = e(Roact.Portal, {
            target = Main.Tips :: Instance,
        }, {
            Tip = e(Templates.Tip, {
                BackgroundColor3 = Color3.fromRGB(
                    (props.theme.schemeColor.R * 255) - 14,
                    (props.theme.schemeColor.G * 255) - 17,
                    (props.theme.schemeColor.B * 255) - 13
                ),

                Position = styles.position,
            }, {
                Tip = {
                    TextColor3 = props.theme.textColor,
                    Text = props.description
                },
            }),
        }),
    })
end

return (RoactHooks.new(Roact :: any)(Tip) :: any) :: RoactElementFn<props>
