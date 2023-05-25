local RunService = cloneref(game:GetService("RunService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Types = require(script.Parent.Types)

type props = {
    render: () -> (),
    tips: { value: { [string]: boolean } },
    theme: Types.theme,
}

type internal = {
    template: RoactElement,
}

type styles = {
    transparency: RoactBinding<number>,
}

local function Blur(props: props & internal, hooks: RoactHooks.Hooks)
    local focused: RoactBinding<string?>, updateFocus = hooks.useBinding(nil :: string?)
    local clicked = hooks.useValue(false)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            transparency = 1,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        local connection; connection = RunService.Heartbeat:Connect(function()
            local focused = focused:getValue()
            local changed = false; for key, opened in pairs(props.tips.value) do
                if opened then
                    if not focused then
                        if clicked.value then
                            props.tips.value[key] = false
                            clicked.value = false
                            changed = true
                        else
                            updateFocus(key)
                        end
                    elseif key ~= focused then
                        props.tips.value[key] = false
                        changed = true
                    end
                end
            end

            if changed then
                props.render()
            end
        end)

        return function()
            connection:Disconnect()
            connection = nil
        end
    end, {})
 
    return Roact.createElement(props.template, {
        BackgroundTransparency = styles.transparency,
        Visible = focused:map(function(value)
            api.start({
                transparency = value and 0.5 or 1
            })

            return value and true or false
        end),

        [Roact.Event.MouseButton1Click] = function(_self: TextButton, input: InputObject)
            clicked.value = true
            updateFocus(nil)
        end
    })
end

return (RoactHooks.new(Roact :: any)(Blur) :: any) :: RoactElementFn<props>
