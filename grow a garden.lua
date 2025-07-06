
-- Neon Hub - Grow a Garden Script
-- Created By: _XzgyX_
-- Advanced script with game detection and complete automation

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Game Detection System
local function detectGame()
    local gameId = game.PlaceId
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(gameId).Name
    
    if string.find(gameName:lower(), "grow") and string.find(gameName:lower(), "garden") then
        return true, gameName
    end
    return false, gameName
end

-- Initialize UI
local isCorrectGame, gameName = detectGame()

local Window = Rayfield:CreateWindow({
    Name = "🌱 Neon Hub - Grow a Garden",
    LoadingTitle = "Neon Hub Loading...",
    LoadingSubtitle = "Created By _XzgyX_",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHub",
        FileName = "GrowAGarden"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = false
    },
    KeySystem = false
})

-- Game Status Check
local StatusTab = Window:CreateTab("🎮 Game Status", 4483362458)
local StatusSection = StatusTab:CreateSection("Detection Status")

StatusSection:CreateLabel("Game Name: " .. gameName)
StatusSection:CreateLabel("Status: " .. (isCorrectGame and "✅ Supported" or "❌ Not Supported"))

if not isCorrectGame then
    StatusSection:CreateLabel("⚠️ This script is designed for Grow a Garden!")
    return
end

-- Global Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Script Settings
local Settings = {
    AutoPlant = false,
    AutoWater = false,
    AutoHarvest = false,
    AutoSell = false,
    AutoBuy = false,
    AutoUpgrade = false,
    InfiniteWater = false,
    SpeedHack = false,
    TeleportToPlots = false,
    AutoCollectRewards = false,
    WalkSpeed = 16,
    JumpPower = 50,
    SelectedSeed = "Carrot",
    SelectedPlot = 1
}

-- Farming Functions
local function getPlayerPlots()
    local plots = {}
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in pairs(plotsFolder:GetChildren()) do
            if plot.Name:find(LocalPlayer.Name) then
                table.insert(plots, plot)
            end
        end
    end
    return plots
end

local function getSeeds()
    local seeds = {}
    local inventory = LocalPlayer:FindFirstChild("Inventory")
    if inventory then
        for _, seed in pairs(inventory:GetChildren()) do
            if seed.Name:find("Seed") then
                table.insert(seeds, seed.Name)
            end
        end
    end
    return seeds
end

local function plantSeed(plot, seedType)
    local remote = ReplicatedStorage:FindFirstChild("PlantSeed")
    if remote then
        remote:FireServer(plot, seedType)
    end
end

local function waterPlant(plot)
    local remote = ReplicatedStorage:FindFirstChild("WaterPlant")
    if remote then
        remote:FireServer(plot)
    end
end

local function harvestPlant(plot)
    local remote = ReplicatedStorage:FindFirstChild("HarvestPlant")
    if remote then
        remote:FireServer(plot)
    end
end

local function sellProduce()
    local remote = ReplicatedStorage:FindFirstChild("SellProduce")
    if remote then
        remote:FireServer()
    end
end

local function buySeeds(seedType, amount)
    local remote = ReplicatedStorage:FindFirstChild("BuySeeds")
    if remote then
        remote:FireServer(seedType, amount)
    end
end

local function upgradeTools()
    local remote = ReplicatedStorage:FindFirstChild("UpgradeTools")
    if remote then
        remote:FireServer()
    end
end

-- Main Farming Tab
local FarmingTab = Window:CreateTab("🌾 Auto Farming", 4483362458)
local MainSection = FarmingTab:CreateSection("Main Automation")

MainSection:CreateToggle({
    Name = "🌱 Auto Plant",
    CurrentValue = false,
    Flag = "AutoPlant",
    Callback = function(Value)
        Settings.AutoPlant = Value
    end,
})

MainSection:CreateToggle({
    Name = "💧 Auto Water",
    CurrentValue = false,
    Flag = "AutoWater",
    Callback = function(Value)
        Settings.AutoWater = Value
    end,
})

MainSection:CreateToggle({
    Name = "🌾 Auto Harvest",
    CurrentValue = false,
    Flag = "AutoHarvest",
    Callback = function(Value)
        Settings.AutoHarvest = Value
    end,
})

MainSection:CreateToggle({
    Name = "💰 Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(Value)
        Settings.AutoSell = Value
    end,
})

local SeedSection = FarmingTab:CreateSection("Seed Selection")

SeedSection:CreateDropdown({
    Name = "Select Seed Type",
    Options = {"Carrot", "Tomato", "Corn", "Wheat", "Pumpkin", "Strawberry"},
    CurrentOption = "Carrot",
    Flag = "SelectedSeed",
    Callback = function(Option)
        Settings.SelectedSeed = Option
    end,
})

-- Tools Tab
local ToolsTab = Window:CreateTab("🔧 Tools", 4483362458)
local ToolsSection = ToolsTab:CreateSection("Tool Automation")

ToolsSection:CreateToggle({
    Name = "🔄 Auto Upgrade Tools",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(Value)
        Settings.AutoUpgrade = Value
    end,
})

ToolsSection:CreateToggle({
    Name = "♾️ Infinite Water",
    CurrentValue = false,
    Flag = "InfiniteWater",
    Callback = function(Value)
        Settings.InfiniteWater = Value
    end,
})

ToolsSection:CreateButton({
    Name = "🛒 Buy Seeds (x10)",
    Callback = function()
        buySeeds(Settings.SelectedSeed, 10)
    end,
})

-- Player Tab
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
local MovementSection = PlayerTab:CreateSection("Movement")

MovementSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        Settings.WalkSpeed = Value
        LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

MovementSection:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        Settings.JumpPower = Value
        LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

MovementSection:CreateToggle({
    Name = "🏃 Speed Hack",
    CurrentValue = false,
    Flag = "SpeedHack",
    Callback = function(Value)
        Settings.SpeedHack = Value
    end,
})

-- Teleport Tab
local TeleportTab = Window:CreateTab("🚀 Teleport", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Quick Teleports")

TeleportSection:CreateButton({
    Name = "📍 Teleport to Shop",
    Callback = function()
        local shop = Workspace:FindFirstChild("Shop")
        if shop then
            LocalPlayer.Character.HumanoidRootPart.CFrame = shop.CFrame
        end
    end,
})

TeleportSection:CreateButton({
    Name = "🏠 Teleport to Spawn",
    Callback = function()
        local spawn = Workspace:FindFirstChild("SpawnLocation")
        if spawn then
            LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame
        end
    end,
})

TeleportSection:CreateToggle({
    Name = "🌾 Auto Teleport to Plots",
    CurrentValue = false,
    Flag = "TeleportToPlots",
    Callback = function(Value)
        Settings.TeleportToPlots = Value
    end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("👁️ Visual", 4483362458)
local VisualSection = VisualTab:CreateSection("Visual Enhancements")

VisualSection:CreateButton({
    Name = "🌈 Rainbow Plants",
    Callback = function()
        for _, plot in pairs(getPlayerPlots()) do
            local plant = plot:FindFirstChild("Plant")
            if plant then
                local rainbow = coroutine.wrap(function()
                    while plant.Parent do
                        for i = 1, 10 do
                            plant.Color = Color3.fromHSV(i/10, 1, 1)
                            wait(0.1)
                        end
                    end
                end)
                rainbow()
            end
        end
    end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

MiscSection:CreateToggle({
    Name = "🎁 Auto Collect Rewards",
    CurrentValue = false,
    Flag = "AutoCollectRewards",
    Callback = function(Value)
        Settings.AutoCollectRewards = Value
    end,
})

MiscSection:CreateButton({
    Name = "💾 Save Configuration",
    Callback = function()
        Rayfield:Notify({
            Title = "Configuration Saved",
            Content = "Your settings have been saved!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Main Loop
spawn(function()
    while wait(1) do
        if Settings.AutoPlant or Settings.AutoWater or Settings.AutoHarvest then
            local plots = getPlayerPlots()
            
            for _, plot in pairs(plots) do
                pcall(function()
                    local plant = plot:FindFirstChild("Plant")
                    local soil = plot:FindFirstChild("Soil")
                    
                    if Settings.AutoPlant and soil and not plant then
                        if Settings.TeleportToPlots then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame
                            wait(0.5)
                        end
                        plantSeed(plot, Settings.SelectedSeed)
                    end
                    
                    if Settings.AutoWater and plant then
                        local needsWater = plant:FindFirstChild("NeedsWater")
                        if needsWater and needsWater.Value then
                            if Settings.TeleportToPlots then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame
                                wait(0.5)
                            end
                            waterPlant(plot)
                        end
                    end
                    
                    if Settings.AutoHarvest and plant then
                        local isReady = plant:FindFirstChild("IsReady")
                        if isReady and isReady.Value then
                            if Settings.TeleportToPlots then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame
                                wait(0.5)
                            end
                            harvestPlant(plot)
                        end
                    end
                end)
            end
        end
        
        if Settings.AutoSell then
            sellProduce()
        end
        
        if Settings.AutoUpgrade then
            upgradeTools()
        end
        
        if Settings.AutoCollectRewards then
            local rewards = Workspace:FindFirstChild("Rewards")
            if rewards then
                for _, reward in pairs(rewards:GetChildren()) do
                    if reward:FindFirstChild("Collect") then
                        reward.Collect:FireServer()
                    end
                end
            end
        end
    end
end)

-- Speed Hack Loop
spawn(function()
    while wait() do
        if Settings.SpeedHack and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Settings.WalkSpeed
                humanoid.JumpPower = Settings.JumpPower
            end
        end
    end
end)

-- Infinite Water Loop
spawn(function()
    while wait(0.1) do
        if Settings.InfiniteWater then
            local waterTool = LocalPlayer.Character:FindFirstChild("WateringCan")
            if waterTool then
                local water = waterTool:FindFirstChild("Water")
                if water then
                    water.Value = 100
                end
            end
        end
    end
end)

-- Success Notification
Rayfield:Notify({
    Title = "🌱 Neon Hub Loaded",
    Content = "Successfully loaded for " .. gameName,
    Duration = 5,
    Image = 4483362458
})

print("Neon Hub - Grow a Garden Script Loaded Successfully!")
print("Created By: _XzgyX_")
print("Game Detected: " .. gameName)
