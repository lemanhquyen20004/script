-- 🌟 FPS Boost Script cho Roblox
-- Giúp giảm lag, tối ưu hiệu suất khi chơi Blox Fruits

local lighting = game:GetService("Lighting")

-- Tắt các hiệu ứng nặng
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
lighting.GlobalShadows = false
lighting.FogEnd = 100000
lighting.Brightness = 1
lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

-- Xóa hiệu ứng không cần thiết
for _,v in pairs(lighting:GetChildren()) do
    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") then
        v:Destroy()
    end
end

-- Ẩn cỏ cây & chi tiết nhỏ
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("MeshPart") or obj:IsA("Part") then
        obj.Material = Enum.Material.Plastic
        obj.Reflectance = 0
    end
end

print("✅ FPS Boost Script Loaded - Chơi mượt hơn rồi!")
