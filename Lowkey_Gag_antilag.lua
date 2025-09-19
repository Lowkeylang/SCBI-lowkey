-- LOW-GRAPHICS MODE (for client-side performance)
-- Usage:
-- 1) Paste this as a LocalScript in StarterPlayerScripts (or run with your executor)
-- 2) Press RightControl (RCtrl) to toggle Low Graphics ON/OFF
-- 3) The script tries to be non-destructive and provides a revert

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local lowGraphics = false

-- Tables to store previous states for revert
local prev = {
    Lighting = {},
    Decals = {},
    PartMaterials = {},
    ParticleEmitters = {},
    Effects = {},
    GuiEnabled = {}
}

-- Utility safe setter
local function safeSet(obj, prop, val)
    pcall(function() obj[prop] = val end)
end

-- Apply low-graphics changes
local function applyLowGraphics()
    -- Lighting
    prev.Lighting.GlobalShadows = Lighting.GlobalShadows
    safeSet(Lighting, "GlobalShadows", false)

    -- Turn down ambient/outdoor etc and reduce brightness
    prev.Lighting.Ambient = Lighting.Ambient
    prev.Lighting.OutdoorAmbient = Lighting.OutdoorAmbient
    prev.Lighting.Brightness = Lighting.Brightness
    prev.Lighting.FogEnd = Lighting.FogEnd
    prev.Lighting.FogStart = Lighting.FogStart

    safeSet(Lighting, "Ambient", Color3.fromRGB(110,110,110))
    safeSet(Lighting, "OutdoorAmbient", Color3.fromRGB(100,100,100))
    safeSet(Lighting, "Brightness", 1)
    safeSet(Lighting, "FogStart", 1000)
    safeSet(Lighting, "FogEnd", 10000)

    -- Disable post-processing / effects (Blur, Bloom, ColorCorrection, SunRays, DepthOfField)
    for _, eff in ipairs(Lighting:GetChildren()) do
        if eff:IsA("BloomEffect") or eff:IsA("BlurEffect")
           or eff:IsA("ColorCorrectionEffect") or eff:IsA("SunRaysEffect")
           or eff:IsA("DepthOfFieldEffect") then
            prev.Effects[eff] = eff.Enabled
            safeSet(eff, "Enabled", false)
        end
    end

    -- Decals & Textures: hide them (makes scene flat, reduces texture fetch)
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("Decal") or d:IsA("Texture") then
            -- store original transparency
            prev.Decals[d] = d.Transparency
            safeSet(d, "Transparency", 1)
        end
    end

    -- Simplify parts' materials and remove fancy meshes where possible
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            prev.PartMaterials[part] = {Material = part.Material, Reflectance = part.Reflectance}
            safeSet(part, "Material", Enum.Material.SmoothPlastic)
            safeSet(part, "Reflectance", 0)
        end
    end

    -- Disable particle emitters
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            prev.ParticleEmitters[obj] = obj.Enabled
            safeSet(obj, "Enabled", false)
        end
        if obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Sparkles") then
            prev.ParticleEmitters[obj] = obj.Enabled
            safeSet(obj, "Enabled", false)
        end
    end

    -- Reduce terrain detail if possible (non-destructive)
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            -- store water/decals settings where possible
            prev.Lighting.TerrainDecoration = true -- placeholder note
            -- try to make terrain flat-ish by reducing detail (best-effort)
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 0.9
        end
    end)

    -- Hide heavy GUI elements (non-essential)
    for _, gui in ipairs(LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") then
            prev.GuiEnabled[gui] = gui.Enabled
            -- Heuristic: hide GUIs with many children (likely HUDs / maps)
            if #gui:GetChildren() > 4 then
                safeSet(gui, "Enabled", false)
            end
        end
    end

    -- Lower the rendering fidelity via StarterGui SetCore (best-effort; may be restricted)
    pcall(function()
        StarterGui:SetCore("GraphicsQualityLevel", 1) -- try to request lowest quality
    end)

    -- Optional: cap or lower physics by using RunService to slow certain updates (conservative)
    -- This block doesn't kill game logic, it's only an extra drop in client workload:
    -- We will not change global simulation but we avoid heavy RenderStepped tasks by reducing frequency of some client updates.
    -- (Left as comment for safety)

    lowGraphics = true
    print("[LowGraphics] Enabled: heavy visual features disabled for smoother performance.")
end

-- Revert changes (attempt)
local function revertLowGraphics()
    -- Lighting
    if prev.Lighting.GlobalShadows ~= nil then
        safeSet(Lighting, "GlobalShadows", prev.Lighting.GlobalShadows)
    end
    if prev.Lighting.Ambient then safeSet(Lighting, "Ambient", prev.Lighting.Ambient) end
    if prev.Lighting.OutdoorAmbient then safeSet(Lighting, "OutdoorAmbient", prev.Lighting.OutdoorAmbient) end
    if prev.Lighting.Brightness then safeSet(Lighting, "Brightness", prev.Lighting.Brightness) end
    if prev.Lighting.FogStart then safeSet(Lighting, "FogStart", prev.Lighting.FogStart) end
    if prev.Lighting.FogEnd then safeSet(Lighting, "FogEnd", prev.Lighting.FogEnd) end

    -- Effects
    for eff, wasEnabled in pairs(prev.Effects) do
        if eff and eff.Parent then
            safeSet(eff, "Enabled", wasEnabled)
        end
    end

    -- Decals
    for d, trans in pairs(prev.Decals) do
        if d and d.Parent then
            safeSet(d, "Transparency", trans or 0)
        end
    end

    -- Parts
    for part, props in pairs(prev.PartMaterials) do
        if part and part.Parent then
            safeSet(part, "Material", props.Material or Enum.Material.Plastic)
            safeSet(part, "Reflectance", props.Reflectance or 0)
        end
    end

    -- Particle emitters
    for obj, enabled in pairs(prev.ParticleEmitters) do
        if obj and obj.Parent then
            safeSet(obj, "Enabled", enabled)
        end
    end

    -- GUIs
    for gui, wasEnabled in pairs(prev.GuiEnabled) do
        if gui and gui.Parent then
            safeSet(gui, "Enabled", wasEnabled)
        end
    end

    -- Attempt to lift graphics request
    pcall(function()
        StarterGui:SetCore("GraphicsQualityLevel", 10)
    end)

    lowGraphics = false
    print("[LowGraphics] Reverted: original client visual settings restored (best-effort).")
end

-- Toggle function
local function toggleLowGraphics()
    if lowGraphics then
        revertLowGraphics()
    else
        applyLowGraphics()
    end
end

-- Keybind: RightControl toggles low graphics
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleLowGraphics()
    end
end)

-- Immediately enable if you want automatic low graphics on script run:
-- toggleLowGraphics()

-- Print short usage instructions
print("Low Graphics script loaded. Press RightControl (RCtrl) to toggle Low Graphics mode ON/OFF.")
