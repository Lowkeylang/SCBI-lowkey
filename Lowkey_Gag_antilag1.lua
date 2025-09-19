--// Grow a Garden Ultra Low GFX (Truly Moveable UI)
--// Made by: Lowkeysen

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LowGFX_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🌱 Grow a Garden | Ultra Low GFX"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 240, 0, 50)
btn.Position = UDim2.new(0.5, -120, 0.5, -25)
btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btn.Text = "Enable Ultra Low Graphics"
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

--// Manual Drag System
local dragging, dragInput, dragStart, startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

--// Functions
local function applyUltraLowGFX()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.EnvironmentDiffuseScale = 0
    
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") 
            or obj:IsA("Fire") or obj:IsA("Smoke") 
            or obj:IsA("Sparkles") or obj:IsA("Explosion") 
            or obj:IsA("Beam") then
            obj.Enabled = false
        elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("Part") then
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("SurfaceAppearance") then
            obj:Destroy()
        end
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character
            if char then
                for _, anim in pairs(char:GetDescendants()) do
                    if anim:IsA("Animator") or anim:IsA("AnimationController") then
                        anim:Destroy()
                    end
                end
            end
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Animator") or obj:IsA("AnimationController") then
            obj:Destroy()
        end
    end

    if workspace:FindFirstChildOfClass("Terrain") then
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        workspace.Terrain.WaterTransparency = 1
        workspace.Terrain.WaterReflectance = 0
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

-- Button actions
btn.MouseButton1Click:Connect(function()
    applyUltraLowGFX()
    btn.Text = "✅ Ultra Low GFX Applied"
end)

exitBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
