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

type props = {
    info: Types.info,
    initialValue: string?,

    options: { string },
    update: (value: string) -> (),
}

type styles = {
    background: RoactBinding<Color3>,
}

local function Dropdown(props: props, hooks: RoactHooks.Hooks)
    local ref = hooks.useValue(Roact.createRef())
    local opened = hooks.useValue(false)
    local absoluteContentSize = hooks.useValue(nil :: number?)

    local selected, updateSelected = hooks.useState(props.initialValue or props.info.name)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            canvasSize = UDim2.fromOffset(352, 33),
            background = props.info.theme.elementColor,
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        props.update(selected)
    end, { selected })

    local options = {}; for index, option in ipairs(props.options) do
        table.insert(options, Roact.createElement(Option, {
            theme = props.info.theme,
            option = option,
            order = index,
            select = updateSelected,
        }))
    end

    return Roact.createElement(Templates.Toggle, {
        BackgroundColor3 = props.info.theme.background,
        LayoutOrder = props.info.order,
    }, merge(options, {
        Open = {
            [Roact.Ref] = ref.value :: any,
            
            BackgroundColor3 = styles.background,

            [Roact.Event.MouseButton1Click] = function(_self: Frame)
                opened.value = not opened.value

                api.start({
                    canvasSize = UDim2.fromOffset(352, opened.value and absoluteContentSize.value or 33)
                })
            end,
            
            [Roact.Event.MouseEnter] = function(_self: Frame)
                api.start({
                    background = Color3.fromRGB(
                        (props.info.theme.elementColor.R * 255) + 8,
                        (props.info.theme.elementColor.G * 255) + 9,
                        (props.info.theme.elementColor.B * 255) + 10
                    ),
                }) 
            end,
    
            [Roact.Event.MouseLeave] = function(_self: Frame)
                api.start({
                    background = props.info.theme.elementColor,
                }) 
            end,

            [Roact.Children] = {
                Ripple = RoactTemplate.wrapped(Ripple, {
                    ref = ref.value,
                    theme = props.info.theme,
                }),
        
                Tip = RoactTemplate.wrapped(Tip, {
                    ref = props.info.ref,
                    description = props.info.description or "",
                    theme = props.info.theme,
                    opened = props.info.tip.opened,
                    update = props.info.tip.update,
                }),

                Selected = {
                    TextColor3 = props.info.theme.textColor,
                    Text = selected,
                },

                Icon = { ImageColor3 = props.info.theme.schemeColor },
            },
        },

        UIListLayout = {
            [Roact.Change.AbsoluteContentSize] = function(self: UIListLayout)
                absoluteContentSize.value = self.AbsoluteContentSize.Y
            end,
        },
    }))
end

return (RoactHooks.new(Roact :: any)(Dropdown) :: any) :: RoactElementFn<props>
