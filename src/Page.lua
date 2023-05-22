local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local merge = require(script.Parent.merge)

type props = {}

type internal = {
    ref: RoactRef<Frame & { Side: Frame & { Tabs: Frame }, Pages: Frame }>,
    theme: Types.theme,
    name: string,

    opened: boolean,
    open: () -> (),
}

type styles = {
    sideTransparency: RoactBinding<number>,
    canvasSize: RoactBinding<UDim2>,
}

local function Page(props: props & internal, hooks: RoactHooks.Hooks)
    local Main = props.ref:getValue()

    local styles: any, api = RoactSpring.useSpring(function()
        return {
            sideTransparency = 1,
            canvasSize = UDim2.fromOffset(352, 0),

            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        api.start({
            sideTransparency = props.opened and 0 or 1
        })
    end, { props.opened })

    return Roact.createFragment({
        Tab = Roact.createElement(Roact.Portal, {
            target = Main.Side.Tabs :: Instance,
        }, {
            Tab = Roact.createElement(Templates.Tab, {
                BackgroundColor3 = props.theme.schemeColor,
                TextColor3 = props.theme.textColor,
                BackgroundTransparency = styles.sideTransparency,
                Text = props.name,

                [Roact.Event.MouseButton1Click] = function(_self: TextButton)
                    if not props.opened then
                        props.open()
                    end
                end,
            })
        }),

        Page = Roact.createElement(Roact.Portal, {
            target = Main.Pages :: Instance,
        }, {
            Page = Roact.createElement(Templates.Page, {
                Visible = props.opened,
                BackgroundColor3 = props.theme.background,
                ScrollBarImageColor3 = Color3.fromRGB(
                    (props.theme.schemeColor.R * 255) - 16,
                    (props.theme.schemeColor.G * 255) - 15,
                    (props.theme.schemeColor.B * 255) - 28
                ),

                CanvasSize = styles.canvasSize,
            }, merge((props :: any)[Roact.Children], {
                UIListLayout = {
                    [Roact.Change.AbsoluteContentSize] = function(self: UIListLayout)
                        api.start({
                            canvasSize = UDim2.fromOffset(352, self.AbsoluteContentSize.Y),
                        })
                    end,
                }
            }))
        })
    })
end

return (RoactHooks.new(Roact :: any)(Page) :: any) :: RoactElementFn<props>
