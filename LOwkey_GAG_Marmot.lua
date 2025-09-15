local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild('HumanoidRootPart')

local queue = {}
local processing = false

local function teleportTo(inst)
    local target
    if inst:IsA('BasePart') then
        target = inst
    elseif inst:IsA('Model') then
        target = inst.PrimaryPart
            or inst:FindFirstChildWhichIsA('BasePart', true)
    end
    if target then
        humanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
    end
end

local function processQueue()
    if processing then
        return
    end
    processing = true
    while #queue > 0 do
        local inst = table.remove(queue, 1)
        if inst and inst.Parent then
            teleportTo(inst)
            task.wait(1)
        end
    end
    processing = false
end

-- Catch existing mounds on start
for _, inst in ipairs(workspace:GetChildren()) do
    if inst.Name == 'Marmot Mound' then
        table.insert(queue, inst)
    end
end
processQueue()

-- Queue up new ones as they spawn
workspace.ChildAdded:Connect(function(inst)
    if inst.Name == 'Marmot Mound' then
        table.insert(queue, inst)
        processQueue()
    end
end)
