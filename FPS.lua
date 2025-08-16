-- 🌟 Blox Fruits Optimizer + Menu Info + FPS Counter
-- Script an toàn, chỉ tối ưu game và hiển thị thông tin

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ Blox Fruits Optimizer"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.Code
title.TextSize = 16

-- Nút bật/tắt tối ưu
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(1, -20, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Code
toggleButton.TextSize = 14
toggleButton.Text = "🔴 Tối ưu: OFF"

local optimized = false
local function optimizeGame(on)
    if on then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

        for _,v in pairs(Lighting:GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") then
                v:Destroy()
            end
        end

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("MeshPart") or obj:IsA("Part") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            end
        end
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        Lighting.GlobalShadows = true
    end
end

toggleButton.MouseButton1Click:Connect(function()
    optimized = not optimized
    optimizeGame(optimized)
    if optimized then
        toggleButton.Text = "🟢 Tối ưu: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    else
        toggleButton.Text = "🔴 Tối ưu: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    end
end)

-- Thông tin người chơi
local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = mainFrame
infoLabel.Size = UDim2.new(1, -20, 0, 50)
infoLabel.Position = UDim2.new(0, 10, 0, 80)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 14
infoLabel.TextWrapped = true

RunService.RenderStepped:Connect(function()
    local userName = player.Name
    local serverID = game.JobId ~= "" and game.JobId or "N/A"
    local playerCount = #Players:GetPlayers()
    infoLabel.Text = "👤 User: " .. userName .. "\n🆔 Server: " .. serverID .. "\n👥 Players: " .. playerCount
end)

-- FPS Counter
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent = screenGui
fpsLabel.Size = UDim2.new(0, 150, 0, 30)
fpsLabel.Position = UDim2.new(1, -160, 0, 10) -- góc phải trên
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
fpsLabel.TextColor3 = Color3.new(0, 1, 0)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 18
fpsLabel.Text = "FPS: ..."

local lastUpdate = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastUpdate >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(frameCount)
        frameCount = 0
        lastUpdate = now
    end
end)

print("✅ Menu Optimizer + Info + FPS Counter Loaded")
