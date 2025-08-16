\-- 🌟 Blox Fruits Optimizer + Info + FPS + Toggle Button (Giao diện đẹp) 🌟

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ======= GUI chính =======
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ======= Nút ảnh để bật/tắt menu =======
local toggleMenuBtn = Instance.new("ImageButton")
toggleMenuBtn.Parent = screenGui
toggleMenuBtn.Size = UDim2.new(0, 50, 0, 50)
toggleMenuBtn.Position = UDim2.new(0, 15, 0, 15)
toggleMenuBtn.BackgroundTransparency = 1
toggleMenuBtn.Image = "rbxassetid://6031091004" -- icon ⚙
toggleMenuBtn.ScaleType = Enum.ScaleType.Fit
toggleMenuBtn.ImageColor3 = Color3.fromRGB(0, 255, 0)

-- ======= Frame Menu =======
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 280, 0, 180)
mainFrame.Position = UDim2.new(0, 80, 0, 15)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 2

-- Shadow / Round effect (simulated)
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- ======= Tiêu đề =======
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ Blox Fruits Optimizer"
title.TextColor3 = Color3.fromRGB(0, 255, 128)
title.Font = Enum.Font.Code
title.TextSize = 18
title.TextStrokeTransparency = 0.6

-- ======= Nút bật/tắt tối ưu =======
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(1, -20, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 0, 45)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Code
toggleButton.TextSize = 15
toggleButton.Text = "🔴 Tối ưu: OFF"
toggleButton.AutoButtonColor = true

local optimized = false
local function optimizeGame(on)
    if on then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5)
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
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        toggleButton.Text = "🔴 Tối ưu: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- ======= Info người chơi =======
local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = mainFrame
infoLabel.Size = UDim2.new(1, -20, 0, 55)
infoLabel.Position = UDim2.new(0, 10, 0, 90)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 14
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Cập nhật info mỗi 1 giây (ít tốn tài nguyên hơn)
spawn(function()
    while true do
        local userName = player.Name
        local serverID = game.JobId ~= "" and game.JobId or "N/A"
        local playerCount = #Players:GetPlayers()
        infoLabel.Text = "👤 User: "..userName.."\n🆔 Server: "..serverID.."\n👥 Players: "..playerCount
        wait(1)
    end
end)

-- ======= FPS Counter =======
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent = screenGui
fpsLabel.Size = UDim2.new(0, 120, 0, 30)
fpsLabel.Position = UDim2.new(1, -140, 0, 15)
fpsLabel.BackgroundTransparency = 0.25
fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
fpsLabel.TextColor3 = Color3.fromRGB(0,255,0)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 18
fpsLabel.Text = "FPS: ..."
fpsLabel.ZIndex = 2

local lastUpdate = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastUpdate >= 1 then
        fpsLabel.Text = "FPS: "..tostring(frameCount)
        frameCount = 0
        lastUpdate = now
    end
end)

-- ======= Toggle Menu =======
toggleMenuBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    -- Đổi màu icon khi menu mở/đóng
    if mainFrame.Visible then
        toggleMenuBtn.ImageColor3 = Color3.fromRGB(0,255,128)
    else
        toggleMenuBtn.ImageColor3 = Color3.fromRGB(255,255,255)
    end
end)

print("✅ Menu Optimizer + Info + FPS Counter Loaded (Giao diện đẹp)")
