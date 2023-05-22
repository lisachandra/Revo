local Roact: Roact = require(script.Parent.Parent.Roact) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

type props = Types.info & { name: string }

local function Label(props: props)
    return Roact.createElement(Templates.Label, {
        BackgroundColor3 = props.theme.schemeColor,
        TextColor3 = props.theme.textColor,
        Text = props.name,
        LayoutOrder = props.order,
    })
end

return Label :: RoactElementFn<props>
