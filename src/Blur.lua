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
    local focused, updateFocus = hooks.useState(nil :: string?)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            transparency = 1,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        api.start({
            transparency = focused and 0.5 or 1
        })

        local connection; connection = RunService.Heartbeat:Connect(function()
            local once: true?
            local changed = false; for key, opened in pairs(props.tips.value) do
                if opened then
                    if once then
                        props.tips.value[key] = false
                        changed = true
                    elseif not focused then
                        updateFocus(key)
                    elseif key ~= focused then
                        props.tips.value[key] = false
                        changed = true
                    end

                    once = true
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
    end, { focused })
 
    return Roact.createElement(props.template, {
        BackgroundTransparency = styles.transparency,
        Visible = focused and true or false,

        [Roact.Event.InputBegan] = function(_self: Frame, input: InputObject)
            if focused and input.UserInputType == Enum.UserInputType.MouseButton1 then
                local connection; connection = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        updateFocus(nil :: any)
                        connection:Disconnect()
                        connection = nil :: any
                    end
                end)
            end
        end
    })
end

return (RoactHooks.new(Roact :: any)(Blur) :: any) :: RoactElementFn<props>
