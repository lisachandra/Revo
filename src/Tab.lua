local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local e = Roact.createElement

type internal = {
    name: string,
    location: string,
}

type styles = {
    sideTransparency: RoactBinding<number>,
}

local function Tab(props: internal, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local history = RoactRouter.useHistory(hooks)

            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    sideTransparency = 1,
                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                api.start({
                    sideTransparency = (history.location.path == props.location or history.location.path:find(props.location)) and 0 or 1,
                })
            end, { history.location.path })

            return e(Templates.Tab, {
                BackgroundColor3 = window.theme.schemeColor,
                TextColor3 = window.theme.textColor,
                BackgroundTransparency = styles.sideTransparency,
                Text = props.name,

                [Roact.Event.MouseButton1Click] = function(_self: GuiButton)
                    history:push(props.location)
                end,
            })
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Tab) :: any) :: RoactElementFn<internal>
