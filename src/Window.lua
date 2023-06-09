local GuiService = cloneref(game:GetService("GuiService"))
local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))
local UserInputService = cloneref(game:GetService("UserInputService"))

local Roact: Roact = require(script.Parent.Parent.Roact) :: any
local RoactHooks = require(script.Parent.Parent.RoactHooks)
local RoactSpring = require(script.Parent.Parent.RoactSpring)
local RoactRouter: RoactRouter = require(script.Parent.Parent.RoactRouter) :: any
local RoactTemplate = require(script.Parent.RoactTemplate)

local Templates = require(script.Parent.Templates)
local Types = require(script.Parent.Types)

local Blur = require(script.Parent.Blur)
local Page = require(script.Parent.Page)
local Tab = require(script.Parent.Tab)

local merge = require(script.Parent.merge)

local e = Roact.createElement
local w = RoactTemplate.wrapped

type props = {
    visible: boolean,
    title: string,
    theme: Types.Theme,
    close: () -> (),
}

type styles = {
    position: RoactBinding<UDim2>,
}

local function Window(props: props, hooks: RoactHooks.Hooks)
    local _, render = hooks.useState(nil)
    
    local ref = hooks.useValue(Roact.createRef() :: RoactRef<Types.Mainframe>)
    local dragConnection = hooks.useValue(nil :: RBXScriptConnection?)

    local pageLocations = hooks.useValue({} :: Dictionary<string>)

    local styles: any, api = RoactSpring.useSpring(hooks, function()
        return {
            position = UDim2.fromScale(0.25, 0.25),
            config = RoactSpring.config.stiff :: any,
        }
    end)

    local styles: styles = styles

    hooks.useEffect(function()
        render()

        return function()
            if dragConnection.value then
                dragConnection.value:Disconnect()
                dragConnection.value = nil
            end
        end
    end, {})

    local pages, tabs = {}, {}; for pageName, page in pairs(props[Roact.Children]) do
        pageLocations.value[pageName] = pageLocations.value[pageName] or `/{HttpService:GenerateGUID()}`

        table.insert(pages, e(Page, {
            location = pageLocations.value[pageName]
        }))

        table.insert(tabs, e(Tab, {
            name = pageName,
            location = pageLocations.value[pageName],
        }))
    end

    return e(Types.WindowContext.Provider, {
        value = {
            theme = props.theme,
            ref = ref.value,
        },
    }, {
        Router = e(RoactRouter.Router, {}, {
            Window = e(Templates.Window, {
                [Roact.Ref] = ref.value :: any,
        
                Visible = props.visible,
                BackgroundColor3 = props.theme.background,
                Position = styles.position,
            }, {
                Header = {
                    BackgroundColor3 = props.theme.header,
        
                    [Roact.Children] = {
                        Title = { Text = props.title },
                        Coverup = { BackgroundColor3 = props.theme.header },
                        Close = {
                            [Roact.Event.MouseButton1Click] = props.close,
                        },
                    } :: any,
        
                    [Roact.Event.InputBegan] = function(_self: Frame, input: InputObject)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and not dragConnection.value then
                            dragConnection.value = RunService.Heartbeat:Connect(function()
                                local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset().Y)
        
                                api.start({
                                    position = UDim2.fromOffset(mousePos.X, mousePos.Y),
                                })
                            end)
                        end
                    end,
        
                    [Roact.Event.InputEnded] = function(_self: Frame, input: InputObject)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragConnection.value then
                            dragConnection.value:Disconnect()
                            dragConnection.value = nil
                        end
                    end,
                },
        
                Side = {
                    BackgroundColor3 = props.theme.header,
        
                    [Roact.Children] = {
                        Coverup = { BackgroundColor3 = props.theme.header },
                        Tabs = { [Roact.Children] = tabs },
                    },
                },
        
                Pages = {
                    [Roact.Children] = merge(pages, {
                        Blur = w(Blur, {
                            theme = props.theme,
                        }),
                    }),
                },
            }),
        })
    })
end

return (RoactHooks.new(Roact :: any)(Window) :: any) :: RoactElementFn<props>
