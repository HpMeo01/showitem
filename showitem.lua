local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local inventory = player.Backpack

local function getWeaponsAndMastery()
    local weapons = {}
    for _, tool in pairs(inventory:GetChildren()) do
        if tool:IsA("Tool") then
            local mastery = tool:FindFirstChild("Mastery") and tool.Mastery.Level.Value or "None"
            weapons[tool.Name] = mastery
        end
    end
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            local mastery = tool:FindFirstChild("Mastery") and tool.Mastery.Level.Value or "None"
            weapons[tool.Name] = mastery
        end
    end
    return weapons
end

local function getFruits()
    local fruits = {}
    for _, item in pairs(inventory:GetChildren()) do
        if item:IsA("Tool") and item:FindFirstChild("Fruit") then
            fruits[item.Name] = (fruits[item.Name] or 0) + 1
        end
    end
    return fruits
end

local function getAccessories()
    local accessories = {}
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Accessory") then
            table.insert(accessories, item.Name)
        end
    end
    return accessories
end

local function displayAccountInfo()
    local gui = Instance.new("ScreenGui", game.CoreGui)

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 600, 0, 500)
    frame.Position = UDim2.new(0.5, -300, 0.1, 0)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 2

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "ACCOUNT INFO"
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22
    title.BackgroundTransparency = 1

    local infoText = Instance.new("TextLabel", frame)
    infoText.Position = UDim2.new(0, 10, 0, 50)
    infoText.Size = UDim2.new(1, -20, 1, -60)
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top
    infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoText.Font = Enum.Font.SourceSans
    infoText.TextSize = 16
    infoText.BackgroundTransparency = 1
    infoText.TextWrapped = true

    local stats = player:FindFirstChild("leaderstats") or {}
    local beli = stats:FindFirstChild("Beli") and stats.Beli.Value or "N/A"
    local fragments = stats:FindFirstChild("Fragments") and stats.Fragments.Value or "N/A"

    local weapons = getWeaponsAndMastery()
    local fruits = getFruits()
    local accessories = getAccessories()

    local displayText = string.format(
        "Tên: %s\nBeli: %s\nFragments: %s\n\n🎯 Vũ khí, Súng, Võ:\n",
        player.Name, beli, fragments
    )

    for name, mastery in pairs(weapons) do
        displayText = displayText .. string.format("- %s (Mastery: %s)\n", name, mastery)
    end

    displayText = displayText .. "\n🍏 Trái ác quỷ trong rương:\n"
    for name, count in pairs(fruits) do
        displayText = displayText .. string.format("- %s (x%d)\n", name, count)
    end

    displayText = displayText .. "\n🎭 Phụ kiện sở hữu:\n"
    for _, acc in pairs(accessories) do
        displayText = displayText .. "- " .. acc .. "\n"
    end

    infoText.Text = displayText
end

displayAccountInfo()
