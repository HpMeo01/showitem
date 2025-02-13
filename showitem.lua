local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local inventory = player.Backpack
local stats = player:FindFirstChild("leaderstats")

local function getInventoryItems()
    local items = {}
    for _, tool in pairs(inventory:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(items, tool.Name)
        end
    end
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(items, tool.Name)
        end
    end
    return items
end

local function getMastery()
    local masteryData = {}
    for _, tool in pairs(inventory:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Mastery") then
            masteryData[tool.Name] = tool.Mastery.Level.Value
        end
    end
    return masteryData
end

local function displayAccountInfo()
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.Players.LocalPlayer:FindFirstChild("PlayerGui") or game.CoreGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0, 0) -- Kéo lên trên cùng
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
    infoText.TextSize = 18
    infoText.TextWrapped = true
    infoText.TextScaled = false

    local level = stats and stats:FindFirstChild("Level") and stats.Level.Value or "N/A"
    local beli = stats and stats:FindFirstChild("Beli") and stats.Beli.Value or "N/A"
    local fragments = stats and stats:FindFirstChild("Fragments") and stats.Fragments.Value or "N/A"

    local items = getInventoryItems()
    local mastery = getMastery()
    
    local displayText = string.format(
        "Name: %s\nLevel: %s\nBeli: %s\nFragments: %s\n\nWeapons & Fruits:\n",
        player.Name,
        level,
        beli,
        fragments
    )

    for _, item in pairs(items) do
        local masteryLevel = mastery[item] or "No Mastery Data"
        displayText = displayText .. string.format("- %s (Mastery: %s)\n", item, masteryLevel)
    end

    infoText.Text = displayText
end

displayAccountInfo()
