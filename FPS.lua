-- Gui cơ bản
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomMenu"
screenGui.Parent = playerGui

-- Khung menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Tiêu đề (có thể kéo)
local title = Instance.new("TextLabel")
title.Text = "Menu Tối Ưu"
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Icon bật/tắt menu
local toggleIcon = Instance.new("ImageButton")
toggleIcon.Size = UDim2.new(0, 40, 0, 40)
toggleIcon.Position = UDim2.new(1, -40, 0, 0)
toggleIcon.Image = "rbxassetid://114173553491760" -- link ảnh bạn đưa, đã upload lên Roblox
toggleIcon.BackgroundTransparency = 1
toggleIcon.Parent = frame

local menuVisible = true
toggleIcon.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
end)

-- Drag & Drop Menu
local dragging = false
local dragInput, mousePos, framePos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = frame.Position

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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Nút Bật/Tắt tối ưu
local toggleButton = Instance.new("TextButton")
toggleButton.Text = "Tối Ưu: OFF"
toggleButton.Size = UDim2.new(1, -20, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Parent = frame

local isOptimized = false
toggleButton.MouseButton1Click:Connect(function()
    isOptimized = not isOptimized
    if isOptimized then
        toggleButton.Text = "Tối Ưu: ON"
    else
        toggleButton.Text = "Tối Ưu: OFF"
    end
end)

-- Thông tin người chơi
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 60)
infoLabel.Position = UDim2.new(0, 10, 0, 80)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextWrapped = true
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextSize = 16
infoLabel.Parent = frame

-- Cập nhật thông tin
local function updateInfo()
    local serverId = game.JobId
    local playersCount = #Players:GetPlayers()
    infoLabel.Text = "Tên: "..player.Name.."\nID Server: "..serverId.."\nSố Players: "..playersCount
end

RunService.RenderStepped:Connect(updateInfo)

-- Hiển thị FPS
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 100, 0, 30)
fpsLabel.Position = UDim2.new(1, -110, 0, 10)
fpsLabel.BackgroundTransparency = 0.5
fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.TextSize = 18
fpsLabel.Parent = screenGui

local lastTime = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastTime >= 1 then
        fpsLabel.Text = "FPS: "..frameCount
        frameCount = 0
        lastTime = now
    end
end)
