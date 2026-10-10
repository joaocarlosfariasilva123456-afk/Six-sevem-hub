
-- SIX SEVEN HUB | Steal an Egg
-- Interface com botões ON/OFF e reabrir painel

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "SixSevenHub"
gui.ResetOnSpawn = false

local parent = player:WaitForChild("PlayerGui")
gui.Parent = parent

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(280, 340)
frame.Position = UDim2.new(0.5, -140, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 42)
title.BackgroundTransparency = 1
title.Text = "SIX SEVEN HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Permite arrastar o painel
local dragging, dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Botão flutuante para reabrir
local reopen = Instance.new("TextButton")
reopen.Size = UDim2.fromOffset(105, 38)
reopen.Position = UDim2.new(0, 12, 0.5, 0)
reopen.Text = "ABRIR HUB"
reopen.TextColor3 = Color3.new(1, 1, 1)
reopen.BackgroundColor3 = Color3.fromRGB(100, 60, 220)
reopen.Visible = false
reopen.Parent = gui
Instance.new("UICorner", reopen).CornerRadius = UDim.new(0, 9)

local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 34)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.Parent = frame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
    callback(button)
    return button
end

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = frame

title.LayoutOrder = 0
title.LayoutOrder = 0

local enabled = {}

local function addToggle(name)
    enabled[name] = false

    local button = makeButton("", function(btn)
        local function refresh()
            btn.Text = name .. ": " .. (enabled[name] and "ON" or "OFF")
            btn.BackgroundColor3 = enabled[name]
                and Color3.fromRGB(40, 145, 85)
                or Color3.fromRGB(55, 55, 70)
        end

        btn.Activated:Connect(function()
            enabled[name] = not enabled[name]
            refresh()
        end)

        refresh()
    end)

    button.LayoutOrder = #frame:GetChildren()
end

addToggle("ESP Eggs")
addToggle("Auto Collect Eggs")
addToggle("Auto Steal")
addToggle("Instant Steal V2")
addToggle("Auto Treadmill")
addToggle("Anti-AFK")

local close = makeButton("FECHAR PAINEL", function(btn)
    btn.Activated:Connect(function()
        frame.Visible = false
        reopen.Visible = true
    end)
end)
close.LayoutOrder = 99

reopen.Activated:Connect(function()
    frame.Visible = true
    reopen.Visible = false
end)
