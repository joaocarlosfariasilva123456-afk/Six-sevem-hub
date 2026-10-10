
-- SIX SEVEN HUB | ESP EGGS
-- Base para um projeto próprio no Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SixSevenHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(220, 120)
frame.Position = UDim2.new(0.5, -110, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -35, 0, 30)
title.Text = "SIX SEVEN HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "X"
close.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 40)
toggle.Position = UDim2.fromOffset(10, 45)
toggle.Text = "ESP EGGS: OFF"
toggle.Parent = frame

local reopen = Instance.new("TextButton")
reopen.Size = UDim2.fromOffset(100, 35)
reopen.Position = UDim2.new(0, 10, 1, -45)
reopen.Text = "ABRIR HUB"
reopen.Visible = false
reopen.Parent = gui

local enabled = false
local highlights = {}

local function clearESP()
    for egg, highlight in pairs(highlights) do
        if highlight then
            highlight:Destroy()
        end
        highlights[egg] = nil
    end
end

local function updateESP()
    clearESP()
    if not enabled then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:GetAttribute("IsEgg") == true
            and (obj:IsA("Model") or obj:IsA("BasePart")) then

            local h = Instance.new("Highlight")
            h.Name = "SixSevenEggESP"
            h.Adornee = obj
            h.FillTransparency = 0.85
            h.OutlineColor = Color3.fromRGB(0, 255, 0)
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = gui
            highlights[obj] = h
        end
    end
end

toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggle.Text = enabled and "ESP EGGS: ON" or "ESP EGGS: OFF"
    updateESP()
end)

close.MouseButton1Click:Connect(function()
    frame.Visible = false
    reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
    frame.Visible = true
    reopen.Visible = false
end)
