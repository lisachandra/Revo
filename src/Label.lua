local Roact: Roact = require(script.Parent.Parent.Roact) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local e = Roact.createElement

type props = { info: Types.info }

local function Label(props: props)
    return e(Templates.Label, {
        BackgroundColor3 = props.info.theme.schemeColor,
        LayoutOrder = props.info.order,
    }, {
        Name = {
            TextColor3 = props.info.theme.textColor,
            Text = props.info.description,
        },
    })
end

return Label :: RoactElementFn<props>
