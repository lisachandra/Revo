local GuiService = cloneref(game:GetService("GuiService"))
local UserInputService = cloneref(game:GetService("UserInputService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Types = require(script.Parent.Types)

type props = {
    size: number,
    ref: RoactRef<TextButton>,
    template: RoactElement,
    theme: Types.theme,
    finished: () -> (),
}

type styles = {
    transparency: RoactBinding<number>,
    position: RoactBinding<UDim2>,
    size: RoactBinding<UDim2>,
}

local function Ripple(props: props, hooks: RoactHooks.Hooks)
    if props.ref then
        local button = props.ref:getValue()
        
        local ripples, updateRipples = hooks.useState({})
        local sizeTarget = hooks.useValue(
            if button.AbsoluteSize.X >= button.AbsoluteSize.Y then
                button.AbsoluteSize.X * 1.5
            else
                button.AbsoluteSize.Y * 1.5
        )

        hooks.useEffect(function()
            local connection; connection = button.MouseButton1Click:Connect(function()
                local ripples = table.clone(ripples)
                local element; element = Roact.createElement(Ripple :: any, {
                    size = sizeTarget.value,
                    template = props.template,
                    theme = props.theme,

                    finished = function()
                        table.remove(ripples, table.find(ripples, element))
                    end,
                })

                table.insert(ripples, element)
                updateRipples(ripples)
            end)

            return function()
                connection:Disconnect()
                connection = nil :: any
            end
        end, {})

        return Roact.createFragment(ripples)
    else
        local self = hooks.useValue(Roact.createRef() :: RoactRef<ImageLabel>)
        local mousePosition = hooks.useValue(UserInputService:GetMouseLocation() - GuiService:GetGuiInset())

        if self.value:getValue() then
            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    transparency = 0.6,
                    position = UDim2.new(mousePosition.value - self.value:getValue().AbsolutePosition),
                    size = UDim2.new(),

                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                api.start({
                    transparency = 1,
                    position = UDim2.new(0.5, -(props.size / 2), 0.5, -(props.size / 2)),
                    size = UDim2.fromOffset(props.size, props.size),
                }):andThen(props.finished)
            end, {})
            
            return Roact.createElement(props.template, {
                [Roact.Ref] = self.value,

                ImageColor3 = props.theme.schemeColor,
                ImageTransparency = styles.transparency,
                Position = styles.position,
                Size = styles.size,
            })
        else
            return Roact.createElement(props.template, {
                [Roact.Ref] = self.value
            })
        end
    end
end

return RoactHooks.new(Roact :: any)(Ripple)
