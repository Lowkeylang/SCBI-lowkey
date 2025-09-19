--// Grow a Garden Super Low Graphics Script
--// Optimized for Delta Executor
--// Made by: Lowkeysen

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--// GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LowGFX_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🌱 Grow a Garden | Low GFX"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 40)
btn.Position = UDim2.new(0.5, -100, 0.5, -20)
btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btn.Text = "Enable Super Low Graphics"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextScaled = true
btn.Parent = frame

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 50, 0, 30)
exitBtn.Position = UDim2.new(1, -55, 0, 5)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.Text = "X"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.TextScaled = true
exitBtn.Parent = frame

--// Functions
local function applyLowGFX()
    -- Lighting
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.EnvironmentDiffuseScale = 0
    
    -- Remove post effects
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end

    -- Remove textures & decals
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
        end
    end
    
    -- Simplify terrain
    if workspace:FindFirstChildOfClass("Terrain") then
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        workspace.Terrain.WaterTransparency = 1
        workspace.Terrain.WaterReflectance = 0
    end

    -- Lower rendering (pixel look)
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

-- Button connections
btn.MouseButton1Click:Connect(function()
    applyLowGFX()
    btn.Text = "✅ Low Graphics Applied"
end)

exitBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
