--// UI Setup
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
local PlayerGui = localPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportUI"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150) -- made taller to fit title
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false -- we’ll handle drag manually
frame.Parent = screenGui

-- UICorner for round edges
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Chubby Acorn Auto Tele"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.TextStrokeTransparency = 0.7
titleLabel.Parent = frame

-- On/Off Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 160, 0, 30)
toggleButton.Position = UDim2.new(0.5, -80, 0, 35)
toggleButton.Text = "ON"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Parent = frame

-- Exit Button
local exitButton = Instance.new("TextButton")
exitButton.Size = UDim2.new(0, 160, 0, 30)
exitButton.Position = UDim2.new(0.5, -80, 0, 75)
exitButton.Text = "EXIT"
exitButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.Parent = frame

-- Credit Label
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Text = "Made by: Lowkeysen"
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.TextScaled = true
credit.Parent = frame

--// Dragging Functionality
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

--// Teleport Logic
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild('HumanoidRootPart')

local queue = {}
local processing = false
local enabled = true -- ON/OFF state

local function teleportTo(inst)
    if not enabled then return end
    local target
    if inst:IsA('BasePart') then
        target = inst
    elseif inst:IsA('Model') then
        target = inst.PrimaryPart or inst:FindFirstChildWhichIsA('BasePart', true)
    end
    if target then
        humanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
    end
end

local function processQueue()
    if processing then return end
    processing = true
    while #queue > 0 and enabled do
        local inst = table.remove(queue, 1)
        if inst and inst.Parent then
            teleportTo(inst)
            task.wait(1)
        end
    end
    processing = false
end

-- Catch existing Acorn on start
for _, inst in ipairs(workspace:GetChildren()) do
    if inst.Name == 'Acorn' then
        table.insert(queue, inst)
    end
end
processQueue()

-- Queue up new ones as they spawn
workspace.ChildAdded:Connect(function(inst)
    if inst.Name == 'Acorn' then
        table.insert(queue, inst)
        processQueue()
    end
end)

--// UI Buttons Functions
toggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        processQueue()
    else
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)

exitButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
