-- KitsuneHub.lua
-- UI demonstrativa para uso no seu proprio projeto no Roblox Studio.
-- Coloque como LocalScript em StarterPlayer > StarterPlayerScripts.
-- Este arquivo cria apenas um painel visual; nao implementa cheats/exploits.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "KitsuneHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(520, 330)
main.Position = UDim2.new(0.5, -260, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
main.BorderSizePixel = 0
main.Visible = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(151, 80, 255)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 46)
title.Position = UDim2.fromOffset(16, 0)
title.BackgroundTransparency = 1
title.Text = "KITSUNE HUB"
title.TextColor3 = Color3.fromRGB(255, 153, 60)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 30)
close.Position = UDim2.new(1, -44, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(53, 38, 69)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Parent = main
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)
close.Activated:Connect(function() main.Visible = false end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 145, 1, -58)
sidebar.Position = UDim2.fromOffset(10, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 24, 43)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 5)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 8)
sidePadding.PaddingLeft = UDim.new(0, 7)
sidePadding.PaddingRight = UDim.new(0, 7)
sidePadding.Parent = sidebar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -170, 1, -62)
content.Position = UDim2.fromOffset(160, 52)
content.BackgroundTransparency = 1
content.Parent = main

local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(1, 0, 0, 30)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = "Home"
pageTitle.TextColor3 = Color3.new(1, 1, 1)
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextSize = 18
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local description = Instance.new("TextLabel")
description.Size = UDim2.new(1, -8, 0, 60)
description.Position = UDim2.fromOffset(0, 36)
description.BackgroundTransparency = 1
description.Text = "Interface visual de demonstracao. Use este painel no seu proprio jogo."
description.TextWrapped = true
description.TextColor3 = Color3.fromRGB(198, 190, 210)
description.Font = Enum.Font.Gotham
description.TextSize = 13
description.TextXAlignment = Enum.TextXAlignment.Left
description.TextYAlignment = Enum.TextYAlignment.Top
description.Parent = content

local pages = {
    "Home", "Halloween", "Murderer", "Sheriff", "Innocent",
    "Visuals", "Dropkick", "Fling", "Teleport", "Player",
    "Farm", "Server", "Settings"
}

local pageButtons = {}
for index, pageName in ipairs(pages) do
    local button = Instance.new("TextButton")
    button.Name = pageName .. "Button"
    button.Size = UDim2.new(1, 0, 0, 25)
    button.BackgroundColor3 = Color3.fromRGB(44, 34, 60)
    button.BorderSizePixel = 0
    button.Text = pageName
    button.TextColor3 = Color3.fromRGB(235, 228, 245)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.LayoutOrder = index
    button.Parent = sidebar
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    button.Activated:Connect(function()
        pageTitle.Text = pageName
        if pageName == "Home" then
            description.Text = "Bem-vindo ao Kitsune Hub! Esta e uma interface visual para seu proprio projeto."
        else
            description.Text = "Aba " .. pageName .. ": adicione aqui recursos legitimos do seu proprio jogo."
        end
        for _, other in ipairs(pageButtons) do
            other.BackgroundColor3 = Color3.fromRGB(44, 34, 60)
        end
        button.BackgroundColor3 = Color3.fromRGB(106, 57, 160)
    end)

    table.insert(pageButtons, button)
end

local floating = Instance.new("TextButton")
floating.Name = "KitsuneToggle"
floating.Size = UDim2.fromOffset(48, 48)
floating.Position = UDim2.new(0, 18, 0.5, -24)
floating.BackgroundColor3 = Color3.fromRGB(106, 57, 160)
floating.Text = "狐"
floating.TextColor3 = Color3.new(1, 1, 1)
floating.Font = Enum.Font.GothamBold
floating.TextSize = 23
floating.Parent = gui
Instance.new("UICorner", floating).CornerRadius = UDim.new(1, 0)

floating.Activated:Connect(function()
    main.Visible = not main.Visible
end)

-- Arrastar o painel com mouse ou toque.
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
