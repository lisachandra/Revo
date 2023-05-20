local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Types = require(script.Parent.Types)

type props = {
    tips: RoactBinding<{ typeof({ Roact.createBinding(false) }) }>,
    theme: Types.theme,
    template: RoactElement,
}

type styles = {
    transparency: RoactBinding<number>,
}

local function Blur(props: props, hooks: RoactHooks.Hooks)
    local focused, updateFocus = hooks.useState(false)
    local finished = hooks.useValue(true)

    local styles: any, api = RoactSpring.useSpring(function()
        return {
            transparency = 1,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        finished.value = false

        api.start({
            transparency = focused and 0.5 or 1
        }):andThen(function()
            finished.value = true
        end)
    end, { focused })
 
    return Roact.createElement(props.template, {
        BackgroundTransparency = props.tips:map(function(tips)
            for _index, open in ipairs(tips) do
                local opened = open[1]:getValue()

                if opened then
                    if finished.value then
                        if not focused then
                            updateFocus(true); break
                        end
                    elseif not focused then
                        (open[2] :: any)(false)
                    end
                end
            end

            return styles.transparency
        end),

        [Roact.Event.InputBegan] = function(_self: Frame, input: InputObject)
            if focused and input.UserInputType == Enum.UserInputType.MouseButton1 then
                local connection; connection = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        updateFocus(false)
                        connection:Disconnect()
                        connection = nil :: any
                    end
                end)
            end
        end
    })
end

return RoactHooks.new(Roact :: any)(Blur)
