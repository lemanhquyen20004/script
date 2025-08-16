-- 🌟 Blox Fruits Optimizer + Info + FPS + Toggle Button (Pro UI) 🌟

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

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
toggleMenuBtn.ZIndex = 3

-- ======= Frame Menu =======
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 190)
mainFrame.Position = UDim2.new(0, 80, 0, 15)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 2

-- Bo tròn + gradient
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50,50,50))
}
gradient.Rotation = 90
gradient.Parent = mainFrame

-- Shadow
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.BackgroundTransparency = 0.9
shadow.BorderSizePixel = 0
shadow.Position = UDim2.new(0,5,0,5)
shadow.ZIndex = 1
shadow.Parent = mainFrame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 15)
shadowCorner.Parent = shadow
local shadowGradient = Instance.new("UIGradient")
shadowGradient.Color = ColorSequence.new(Color3.fromRGB(0,0,0), Color3.fromRGB(30,30,30))
shadowGradient.Rotation = 0
shadowGradient.Parent = shadow

-- ======= Tiêu đề =======
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ Blox Fruits Optimizer"
title.TextColor3 = Color3.fromRGB(0, 255, 180)
title.Font = Enum.Font.Code
title.TextSize = 20
title.TextStrokeTransparency = 0.7
title.ZIndex = 3

-- ======= Nút bật/tắt tối ưu =======
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(1, -20, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 0, 45)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Code
toggleButton.TextSize = 16
toggleButton.Text = "🔴 Tối ưu: OFF"
toggleButton.AutoButtonColor = true
toggleButton.ZIndex = 3

local toggleBtnCorner = Instance.new("UICorner")
toggleBtnCorner.CornerRadius = UDim.new(0, 8)
toggleBtnCorner.Parent = toggleButton

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
        local tween = TweenService:Create(toggleButton,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(0,150,0)})
        tween:Play()
    else
        toggleButton.Text = "🔴 Tối ưu: OFF"
        local tween = TweenService:Create(toggleButton,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(150,0,0)})
        tween:Play()
    end
end)

-- ======= Info người chơi =======
local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = mainFrame
infoLabel.Size = UDim2.new(1, -20, 0, 60)
infoLabel.Position = UDim2.new(0, 10, 0, 90)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(220,220,220)
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 15
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.ZIndex = 3
infoLabel.TextStrokeTransparency = 0.6

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
fpsLabel.Size = UDim2.new(0, 130, 0, 30)
fpsLabel.Position = UDim2.new(1, -150, 0, 15)
fpsLabel.BackgroundTransparency = 0.25
fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
fpsLabel.TextColor3 = Color3.fromRGB(0,255,0)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 18
fpsLabel.Text = "FPS: ..."
fpsLabel.ZIndex = 3

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
    -- Animate icon màu sắc
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if mainFrame.Visible then
        TweenService:Create(toggleMenuBtn,tweenInfo,{ImageColor3 = Color3.fromRGB(0,255,180)}):Play()
    else
        TweenService:Create(toggleMenuBtn,tweenInfo,{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
    end
end)

print("✅ Menu Optimizer + Info + FPS Counter Loaded (Pro UI)")
