local GuiService = cloneref(game:GetService("GuiService"))
local UserInputService = cloneref(game:GetService("UserInputService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Types = require(script.Parent.Types)

type props = {
    ref: RoactRef<GuiButton>,
    theme: Types.theme,
}

type internal = {
    template: RoactElement,
    finished: () -> (),
    size: number,
}

type styles = {
    transparency: RoactBinding<number>,
    position: RoactBinding<UDim2>,
    size: RoactBinding<UDim2>,
}

local function Ripple(props: props & internal, hooks: RoactHooks.Hooks)
    if props.ref then
        local button = props.ref:getValue()
        
        local _, render = hooks.useState(nil :: any)
        local ripples = hooks.useValue({})
        local sizeTarget = hooks.useValue(button and (
            if button.AbsoluteSize.X >= button.AbsoluteSize.Y then
                button.AbsoluteSize.X * 1.5
            else
                button.AbsoluteSize.Y * 1.5
        ) or 0)

        hooks.useEffect(function()
            if button then
                local connection; connection = button.MouseButton1Click:Connect(function()
                    print("adding ripple")

                    local element; element = Roact.createElement(Ripple :: any, {
                        size = sizeTarget.value,
                        template = props.template,
                        theme = props.theme,
    
                        finished = function()
                            table.remove(ripples.value, table.find(ripples.value, element))
                        end,
                    })
    
                    table.insert(ripples.value, element)
                    render()
                end)
    
                return function()
                    connection:Disconnect()
                    connection = nil :: any
                end :: any
            else
                render()
            end

            return
        end, { button and true or false })

        return Roact.createFragment(ripples.value)
    else
        local self = hooks.useValue(Roact.createRef() :: RoactRef<ImageLabel>)
        local mousePosition = hooks.useValue(UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset().Y))

        local _, render = hooks.useState(nil :: any)

        hooks.useEffect(function()
            print("rerendering ripple")
            render()
        end, {})

        if self.value:getValue() then
            local styles: any, api = RoactSpring.useSpring(hooks, function()
                local position = mousePosition.value - self.value:getValue().AbsolutePosition

                return {
                    transparency = 0.6,
                    position = UDim2.fromOffset(position.X, position.Y),
                    size = UDim2.new(),

                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                print("starting ripple")

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

Ripple = RoactHooks.new(Roact :: any)(Ripple) :: any

return Ripple :: RoactElementFn<props>
