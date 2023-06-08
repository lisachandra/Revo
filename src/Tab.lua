local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local e = Roact.createElement

type props = {}

type internal = {
    theme: Types.theme,
    name: string,
    location: string,
}

type styles = {
    sideTransparency: RoactBinding<number>,
}

local function Tab(props: props & internal, hooks: RoactHooks.Hooks)
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
            sideTransparency = history.location.path:find(props.location) and 0 or 1
        })
    end, { history, props.location } :: table)

    return e(Templates.Tab, {
        BackgroundColor3 = props.theme.schemeColor,
        TextColor3 = props.theme.textColor,
        BackgroundTransparency = styles.sideTransparency,
        Text = props.name,

        [Roact.Event.MouseButton1Click] = function()
            if not history.location.path:find(props.location) then
                history:replace(props.location)
            end
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Tab) :: any) :: RoactElementFn<props & internal>
