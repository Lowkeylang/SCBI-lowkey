--// Grow a Garden Ultra Low GFX (Individual Toggles + Reflection)
--// Made by: Lowkeysen

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LowGFX_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
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

-- Button creator
local function createButton(yPos, text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 260, 0, 35)
	btn.Position = UDim2.new(0.5, -130, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = text .. " ❌"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextScaled = true
	btn.Parent = frame
	return btn
end

-- Buttons
local shadowBtn    = createButton(40, "Shadows")
local textureBtn   = createButton(80, "Textures")
local animBtn      = createButton(120, "Animations")
local petsBtn      = createButton(160, "Pets & Plants")
local weatherBtn   = createButton(200, "Weather")
local reflectBtn   = createButton(240, "Reflections")

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

--// Toggle States
local toggles = {
	shadow = false,
	texture = false,
	anim = false,
	pets = false,
	weather = false,
	reflect = false
}

--// Functions
local function toggleShadows(state)
	Lighting.GlobalShadows = not state
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CastShadow = not state
		end
	end
end

local function toggleTextures(state)
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
			if state then obj:Destroy() end
		elseif obj:IsA("MeshPart") then
			if state then obj.TextureID = "" obj.Material = Enum.Material.SmoothPlastic end
		elseif obj:IsA("Part") then
			if state then obj.Material = Enum.Material.SmoothPlastic end
		end
	end
end

local function toggleAnimations(state)
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Animator") or obj:IsA("AnimationController") then
			if state then obj:Destroy() end
		end
	end
end

local function togglePets(state)
	for _, obj in pairs(workspace:GetChildren()) do
		if obj:IsA("Model") or obj:IsA("Folder") then
			local name = string.lower(obj.Name)
			if name:find("pet") or name:find("plant") or name:find("tree") or name:find("flower") then
				if state then obj:Destroy() end
			end
		end
	end
end

local function toggleWeather(state)
	for _, v in pairs(Lighting:GetChildren()) do
		if v:IsA("Atmosphere") or v:IsA("Clouds") then
			if state then v:Destroy() end
		end
	end
	for _, obj in pairs(workspace:GetChildren()) do
		local name = string.lower(obj.Name)
		if name:find("rain") or name:find("snow") or name:find("storm") or name:find("weather") or name:find("cloud") then
			if state then obj:Destroy() end
		end
	end
end

local function toggleReflections(state)
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Reflectance = state and 0 or obj.Reflectance
		end
	end
end

--// Hook up buttons
shadowBtn.MouseButton1Click:Connect(function()
	toggles.shadow = not toggles.shadow
	toggleShadows(toggles.shadow)
	shadowBtn.Text = "Shadows " .. (toggles.shadow and "✅" or "❌")
end)

textureBtn.MouseButton1Click:Connect(function()
	toggles.texture = not toggles.texture
	toggleTextures(toggles.texture)
	textureBtn.Text = "Textures " .. (toggles.texture and "✅" or "❌")
end)

animBtn.MouseButton1Click:Connect(function()
	toggles.anim = not toggles.anim
	toggleAnimations(toggles.anim)
	animBtn.Text = "Animations " .. (toggles.anim and "✅" or "❌")
end)

petsBtn.MouseButton1Click:Connect(function()
	toggles.pets = not toggles.pets
	togglePets(toggles.pets)
	petsBtn.Text = "Pets & Plants " .. (toggles.pets and "✅" or "❌")
end)

weatherBtn.MouseButton1Click:Connect(function()
	toggles.weather = not toggles.weather
	toggleWeather(toggles.weather)
	weatherBtn.Text = "Weather " .. (toggles.weather and "✅" or "❌")
end)

reflectBtn.MouseButton1Click:Connect(function()
	toggles.reflect = not toggles.reflect
	toggleReflections(toggles.reflect)
	reflectBtn.Text = "Reflections " .. (toggles.reflect and "✅" or "❌")
end)

exitBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)
