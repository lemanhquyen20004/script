local Webhook_URL = "https://discord.com/api/webhooks/1410565696651399318/a6LgFUADXgbnq4NcPZspAWqYHCivwW93Zkfvsf6akJb23_CJ1ia3dpXvqB7dP-km_Z4N"
local HttpService = game:GetService("HttpService")

-- Hàm chọn màu theo rarity
local function GetColorByRarity(rarity)
    local colors = {
        ["Common"] = 8421504,
        ["Uncommon"] = 3066993,
        ["Rare"] = 3447003,
        ["Epic"] = 10181046,
        ["Legendary"] = 15844367,
        ["Mythical"] = 15158332
    }
    return colors[rarity] or 0 -- mặc định = đen nếu không có
end

-- Hàm gửi webhook
local function SendWebhook(player, itemName, itemValue, rarity)
    local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=420&height=420&format=png"
    local time = os.date("%Y-%m-%d %H:%M:%S")

    local data = {
        ["username"] = "Case Opening Bot",
        ["embeds"] = {{
            ["title"] = "📦 Case Opened!",
            ["color"] = GetColorByRarity(rarity), -- màu theo độ hiếm
            ["thumbnail"] = {["url"] = avatarUrl},
            ["fields"] = {
                {
                    ["name"] = "👤 Người chơi",
                    ["value"] = player.Name .. " (ID: " .. player.UserId .. ")",
                    ["inline"] = false
                },
                {
                    ["name"] = "🎁 Item Nhận",
                    ["value"] = "**" .. itemName .. "**",
                    ["inline"] = true
                },
                {
                    ["name"] = "⭐ Độ hiếm",
                    ["value"] = rarity,
                    ["inline"] = true
                },
                {
                    ["name"] = "💰 Giá trị",
                    ["value"] = tostring(itemValue) .. " Coins",
                    ["inline"] = true
                },
                {
                    ["name"] = "⏰ Thời gian",
                    ["value"] = time,
                    ["inline"] = false
                }
            }
        }}
    }

    local jsonData = HttpService:JSONEncode(data)
    local requestFunc = (syn and syn.request) or (http_request) or (request)
    if requestFunc then
        requestFunc({
            Url = Webhook_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    else
        warn("Executor không hỗ trợ gửi HTTP request.")
    end
end

-- Ví dụ test
local player = game.Players.LocalPlayer
SendWebhook(player, "Golden Dragon Knife", 50000, "Legendary")
