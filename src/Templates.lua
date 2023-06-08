local RoactTemplate = require(script.Parent.RoactTemplate)
local Roact: Roact = require(script.Parent.Parent.Roact) :: any

local TemplateFolder = game:GetObjects("rbxassetid://13475443187")[1]

local Templates = {}; for _index, ui in ipairs(TemplateFolder:GetChildren()) do
    Templates[ui.Name] = RoactTemplate.fromInstance(Roact, ui)
end

return Templates
