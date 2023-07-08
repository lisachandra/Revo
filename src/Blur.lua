local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any

local e = Roact.createElement

type internal = {
    template: RoactElement,
}

type styles = {
    transparency: RoactBinding<number>,
}

local function Blur(props: internal, hooks: RoactHooks.Hooks)
    local history = RoactRouter.useHistory(hooks)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            transparency = 1,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        local connection; connection = history.onChanged:connect(function(path)
            api.start({
                transparency = path:find("_tip") and 0.5 or 1
            })
        end)

        return function()
            connection:disconnect()
            connection = nil :: any
        end
    end, {})
 
    return e(props.template, {
        BackgroundTransparency = styles.transparency,
        Visible = styles.transparency:map(function(value)
            return if value < 0.5 then true else false
        end),

        [Roact.Event.MouseButton1Click] = function()
            if history.location.path:find("_tip") then
                history:goBack()
            end
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Blur) :: any) :: RoactElementFn<internal>
