local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Option = require(script.Parent.Option)
local Ripple = require(script.Parent.Ripple)
local Tip = require(script.Parent.Tip)

local merge = require(script.Parent.merge)

local e = Roact.createElement
local w = RoactTemplate.wrapped

type props = Types.elementProps<string> & {
    options: { string },
}

type styles = {
    background: RoactBinding<Color3>,
    canvasSize: RoactBinding<UDim2>,
}

local function Dropdown(props: props, hooks: RoactHooks.Hooks)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            local ref = hooks.useValue(Roact.createRef())
            local opened = hooks.useValue(false)

            local selected: RoactBinding<string>, updateSelected = hooks.useBinding(props.initialValue or props.info.name)

            local styles: any, api = RoactSpring.useSpring(hooks, function()
                return {
                    canvasSize = UDim2.fromOffset(352, 33),
                    background = window.theme.elementColor,
                    config = RoactSpring.config.stiff :: any,
                }
            end)

            local styles: styles = styles

            hooks.useEffect(function()
                if props.initialValue then
                    updateSelected(props.initialValue)
                end
            end, { props.initialValue })

            local options = {}; for index, option in ipairs(props.options) do
                table.insert(options, e(Option, {
                    theme = window.theme,
                    option = option,
                    order = index,
                    selected = selected,
                    select = updateSelected,
                }))
            end

            return e(Templates.Dropdown, {
                LayoutOrder = props.info.order,
                Size = styles.canvasSize,
            }, merge(options, {
                Open = {
                    [Roact.Ref] = ref.value :: any,
                    
                    BackgroundColor3 = styles.background,

                    [Roact.Event.MouseButton1Click] = function(self: Frame & { Parent: Frame & { UIListLayout: UIListLayout } })
                        local absoluteContentSize = self.Parent.UIListLayout.AbsoluteContentSize

                        opened.value = not opened.value

                        api.start({
                            canvasSize = UDim2.fromOffset(352, opened.value and absoluteContentSize.Y or 33)
                        })
                    end,
                    
                    [Roact.Event.MouseEnter] = function(_self: Frame)
                        api.start({
                            background = Color3.fromRGB(
                                (window.theme.elementColor.R * 255) + 8,
                                (window.theme.elementColor.G * 255) + 9,
                                (window.theme.elementColor.B * 255) + 10
                            ),
                        }) 
                    end,
            
                    [Roact.Event.MouseLeave] = function(_self: Frame)
                        api.start({
                            background = window.theme.elementColor,
                        }) 
                    end,

                    [Roact.Children] = {
                        Ripple = w(Ripple, {
                            ref = ref.value,
                            theme = window.theme,
                        }),
                
                        Tip = w(Tip, {
                            ref = window.ref,
                            description = props.info.description or "",
                            theme = window.theme,
                            location = props.info.location,
                        }),

                        Selected = {
                            TextColor3 = window.theme.textColor,
                            Text = selected:map(function(value)
                                props.update(value)

                                return value
                            end),
                        },

                        Icon = { ImageColor3 = window.theme.schemeColor },
                    },
                },
            }))
        end,
    })
end

return (RoactHooks.new(Roact :: any)(Dropdown) :: any) :: RoactElementFn<props>
