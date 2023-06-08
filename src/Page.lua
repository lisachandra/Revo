local HttpService = cloneref(game:GetService("HttpService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local merge = require(script.Parent.merge)

local e = Roact.createElement

type props = {}

type internal = {
    ref: RoactRef<Types.Mainframe>,
    theme: Types.theme,
    location: string,
}

type styles = {
    sideTransparency: RoactBinding<number>,
}

local function Page(props: props & internal, hooks: RoactHooks.Hooks); print("Page")
    local Main = props.ref:getValue(); if not Main then
        return e("Frame", { Visible = false })
    end

    local elementLocations = hooks.useValue({} :: Dictionary<string>)

    local history = RoactRouter.useHistory(hooks)

    local elements = {}; for elementName, element in pairs((props :: any)[Roact.Children]) do
        elementLocations.value[elementName] = elementLocations.value[elementName] or `/{HttpService:GenerateGUID()}_tip`
        element.props = merge(element.props, {
            info = merge(element.props.info, {
                ref = props.ref,
                theme = props.theme,
                name = elementName,
                location = elementLocations.value[elementName],
            } :: Types.info),
        })
    end

    return e(Templates.Page, {
        Visible = history.location.path:find(props.location) and true or false,
        ScrollBarImageColor3 = Color3.fromRGB(
            (props.theme.schemeColor.R * 255) - 16,
            (props.theme.schemeColor.G * 255) - 15,
            (props.theme.schemeColor.B * 255) - 28
        ),
    }, elements)
end

return (RoactHooks.new(Roact :: any)(Page) :: any) :: RoactElementFn<props & internal>
