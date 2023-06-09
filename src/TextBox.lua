local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Tip = require(script.Parent.Tip)

local e = Roact.createElement
local w = RoactTemplate.wrapped

type props = Types.elementProps<string>
type styles = {
    background: RoactBinding<Color3>,
}

local function TextBox(props: props, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local ref = hooks.useValue(Roact.createRef() :: RoactRef<GuiButton>)

            local text: RoactBinding<string>, updateText = hooks.useBinding(props.initialValue)

            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    background = window.theme.elementColor,
                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                updateText(props.initialValue)
            end, { props.initialValue })

            return e(Templates.TextBox, {
                [Roact.Ref] = ref.value :: any,

                BackgroundColor3 = styles.background,
                LayoutOrder = props.info.order,

                [Roact.Event.MouseEnter] = function(_self: TextButton)
                api.start({
                        background = Color3.fromRGB(
                            (window.theme.elementColor.R * 255) + 8,
                            (window.theme.elementColor.G * 255) + 9,
                            (window.theme.elementColor.B * 255) + 10
                        ),
                }) 
                end,

                [Roact.Event.MouseLeave] = function(_self: TextButton)
                    api.start({
                        background = window.theme.elementColor,
                    }) 
                end,
            }, {
                Tip = w(Tip, {
                    description = props.info.description or "",
                    location = props.info.location,
                }),

                TextBox = {
                    BackgroundColor3 = Color3.fromRGB(
                        (window.theme.elementColor.R * 255) - 6, 
                        (window.theme.elementColor.G * 255) - 6, 
                        (window.theme.elementColor.B * 255) - 7
                    ),

                    TextColor3 = window.theme.textColor,
                    Text = text:map(function(value)
                        props.update(value)

                        return value
                    end),

                    [Roact.Event.FocusLost] = function(self: TextBox, enterPressed: boolean)
                        if enterPressed then
                            updateText(self.Text); return
                        end

                        updateText(text:getValue())
                    end,
                },

                Name = {
                    TextColor3 = window.theme.textColor,
                    Text = props.info.name,
                },

                Icon = { ImageColor3 = window.theme.schemeColor },
            })
        end,
    })
end

return (RoactHooks.new(Roact :: any)(TextBox) :: any) :: RoactElementFn<props>
