local RejoinTime = 10
local TS = game:GetService("TeleportService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Screen GUI
local sg = Instance.new("ScreenGui")
sg.Name = "RejoinGui"
sg.ResetOnSpawn = false
sg.Parent = lp:WaitForChild("PlayerGui")

-- Toggle Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 130, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = "🔴 Rejoin Off"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Parent = sg

-- Rounded Corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = btn

-- Outline
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Transparency = 0.3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = btn

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ZIndex = btn.ZIndex - 1
shadow.Parent = btn

-- Rejoin Logic
local on = false
local co = nil

local function rejoin()
    TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end

local function start()
    if co then return end
    on = true
    co = coroutine.create(function()
        while on do
            task.wait(RejoinTime)
            rejoin()
        end
    end)
    coroutine.resume(co)
end

local function stop()
    if co then
        on = false
        coroutine.close(co)
        co = nil
    end
end

local function toggle()
    if on then
        stop()
        btn.Text = "🔴 Rejoin Off"
        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        TS:SetTeleportSetting("RejoinEnabled", false)
    else
        start()
        btn.Text = "🟢 Rejoin On"
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        TS:SetTeleportSetting("RejoinEnabled", true)
    end
end

btn.MouseButton1Click:Connect(toggle)

if TS:GetTeleportSetting("RejoinEnabled") == true then
    start()
    btn.Text = "🟢 Rejoin On"
    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end

TS.TeleportInitFailed:Connect(function()
    TS:SetTeleportSetting("RejoinEnabled", on)
end)

-- Dragging
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    btn.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = btn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

btn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
