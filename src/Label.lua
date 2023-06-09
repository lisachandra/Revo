local Roact: Roact = require(script.Parent.Parent.Roact) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local e = Roact.createElement

type props = { info: Types.Info }

local function Label(props: props)
    return e(Types.WindowContext.Consumer, {
        render = function(window)
            return e(Templates.Label, {
                BackgroundColor3 = window.theme.schemeColor,
                LayoutOrder = props.info.order,
            }, {
                Name = {
                    TextColor3 = window.theme.textColor,
                    Text = props.info.description,
                },
            })
        end,
    })
end

return Label :: RoactElementFn<props>
