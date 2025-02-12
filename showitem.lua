local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local inventory = player.Backpack
local stats = player:FindFirstChild("leaderstats")

local function getInventoryItems()
    local items = {}
    for _, item in pairs(inventory:GetChildren()) do
        table.insert(items, item.Name)
    end
    return items
end

local function getMastery()
    local masteryData = {}
    for _, tool in pairs(inventory:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Mastery") then
            masteryData[tool.Name] = tool.Mastery.Value
        end
    end
    return masteryData
end

local function displayAccountInfo()
    local gui = Instance.new("ScreenGui", game.CoreGui)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0.2, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "ACCOUNT INFO"
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22

    local infoText = Instance.new("TextLabel", frame)
    infoText.Position = UDim2.new(0, 10, 0, 50)
    infoText.Size = UDim2.new(1, -20, 0, 300)
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top
    infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoText.Font = Enum.Font.SourceSans
    infoText.TextSize = 18
    infoText.TextWrapped = true

    local items = getInventoryItems()
    local mastery = getMastery()
    
    local displayText = string.format(
        "Name: %s\nLevel: %d\nBeli: %s\nFragments: %s\n\nWeapons & Fruits:\n",
        player.Name,
        stats.Level.Value,
        stats.Beli.Value,
        stats.Fragments.Value
    )

    for _, item in pairs(items) do
        local masteryLevel = mastery[item] or "None"
        displayText = displayText .. string.format("- %s (Mastery: %s)\n", item, masteryLevel)
    end

    infoText.Text = displayText
end

displayAccountInfo()
