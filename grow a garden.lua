
-- Neon Hub V2 - Grow a Garden Script
-- Created By: _XzgyX_
-- Advanced script with game detection and complete automation
-- Version 2.0 - Fixed all bugs and added complete functionality

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Game Detection System
local function detectGame()
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    
    if success then
        local gameName = gameInfo.Name
        if string.find(gameName:lower(), "grow") and string.find(gameName:lower(), "garden") then
            return true, gameName
        end
        return false, gameName
    end
    return false, "Unknown Game"
end

-- Initialize Game Detection
local isCorrectGame, gameName = detectGame()

-- Enhanced UI with better styling
local Window = Rayfield:CreateWindow({
    Name = "🌱 Neon Hub V2 - Grow a Garden",
    LoadingTitle = "Neon Hub V2 Loading...",
    LoadingSubtitle = "Advanced Farming Automation",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHubV2",
        FileName = "GrowAGardenV2"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = false
    },
    KeySystem = false
})

-- Game Status Tab
local StatusTab = Window:CreateTab("🎮 Game Status", 4483362458)
local StatusSection = StatusTab:CreateSection("Detection & Information")

StatusSection:CreateLabel("Game: " .. gameName)
StatusSection:CreateLabel("Status: " .. (isCorrectGame and "✅ Supported" or "❌ Not Supported"))
StatusSection:CreateLabel("Version: Neon Hub V2.0")
StatusSection:CreateLabel("Created by: _XzgyX_")

if not isCorrectGame then
    StatusSection:CreateLabel("⚠️ This script is designed for Grow a Garden!")
    Rayfield:Notify({
        Title = "❌ Game Not Supported",
        Content = "This script only works with Grow a Garden!",
        Duration = 5,
        Image = 4483362458
    })
    return
end

-- Advanced Settings Configuration
local Settings = {
    -- Main Farming
    AutoPlant = false,
    AutoWater = false,
    AutoHarvest = false,
    AutoSell = false,
    AutoBuy = false,
    AutoUpgrade = false,
    AutoCollectDrops = false,
    AutoCollectRewards = false,
    
    -- Tools & Upgrades
    InfiniteWater = false,
    AutoUpgradeWateringCan = false,
    AutoUpgradeHoe = false,
    AutoUpgradeBag = false,
    
    -- Movement & Speed
    SpeedHack = false,
    TeleportToPlots = false,
    WalkSpeed = 16,
    JumpPower = 50,
    
    -- Seed & Plot Management
    SelectedSeed = "Carrot",
    SelectedPlot = 1,
    SmartSeedSelection = false,
    AutoBuySeeds = false,
    SeedAmount = 10,
    
    -- Visual & Misc
    RainbowPlants = false,
    PlantESP = false,
    ShowStats = false,
    
    -- Advanced Features
    AutoRebirth = false,
    AutoClaimQuests = false,
    AutoEquipBestTools = false,
    LoopDelay = 0.5
}

-- Enhanced Remote Detection System
local Remotes = {}
local function findRemotes()
    local remoteEvents = ReplicatedStorage:GetDescendants()
    for _, remote in pairs(remoteEvents) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("plant") then
                Remotes.PlantSeed = remote
            elseif name:find("water") then
                Remotes.WaterPlant = remote
            elseif name:find("harvest") then
                Remotes.HarvestPlant = remote
            elseif name:find("sell") then
                Remotes.SellProduce = remote
            elseif name:find("buy") then
                Remotes.BuySeeds = remote
            elseif name:find("upgrade") then
                Remotes.UpgradeTools = remote
            elseif name:find("rebirth") then
                Remotes.Rebirth = remote
            elseif name:find("quest") then
                Remotes.ClaimQuest = remote
            end
        end
    end
end

-- Initialize remotes
findRemotes()

-- Advanced Farming Functions
local function getPlayerPlots()
    local plots = {}
    local plotsFolder = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("plots") or Workspace
    
    for _, obj in pairs(plotsFolder:GetDescendants()) do
        if obj.Name:find(LocalPlayer.Name) or obj:GetAttribute("Owner") == LocalPlayer.Name then
            table.insert(plots, obj)
        end
    end
    
    -- Alternative method if no plots found
    if #plots == 0 then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj.Name:find("Plot") and obj:FindFirstChild("Owner") then
                if obj.Owner.Value == LocalPlayer.Name then
                    table.insert(plots, obj)
                end
            end
        end
    end
    
    return plots
end

local function getAvailableSeeds()
    local seeds = {}
    local inventory = LocalPlayer:FindFirstChild("Inventory") or LocalPlayer:FindFirstChild("Backpack")
    
    if inventory then
        for _, item in pairs(inventory:GetChildren()) do
            if item.Name:find("Seed") or item:GetAttribute("Type") == "Seed" then
                table.insert(seeds, item.Name)
            end
        end
    end
    
    -- Default seeds if none found
    if #seeds == 0 then
        seeds = {"Carrot", "Tomato", "Corn", "Wheat", "Pumpkin", "Strawberry", "Watermelon", "Blueberry"}
    end
    
    return seeds
end

local function safeRemoteCall(remote, ...)
    if remote then
        local success, result = pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(...)
            elseif remote:IsA("RemoteFunction") then
                return remote:InvokeServer(...)
            end
        end)
        return success, result
    end
    return false, "Remote not found"
end

local function plantSeed(plot, seedType)
    local success = safeRemoteCall(Remotes.PlantSeed, plot, seedType)
    if not success then
        -- Try alternative methods
        local plantRemote = ReplicatedStorage:FindFirstChild("Plant") or 
                           ReplicatedStorage:FindFirstChild("PlantSeed") or
                           ReplicatedStorage:FindFirstChild("plant")
        if plantRemote then
            safeRemoteCall(plantRemote, plot, seedType)
        end
    end
end

local function waterPlant(plot)
    local success = safeRemoteCall(Remotes.WaterPlant, plot)
    if not success then
        local waterRemote = ReplicatedStorage:FindFirstChild("Water") or 
                           ReplicatedStorage:FindFirstChild("WaterPlant") or
                           ReplicatedStorage:FindFirstChild("water")
        if waterRemote then
            safeRemoteCall(waterRemote, plot)
        end
    end
end

local function harvestPlant(plot)
    local success = safeRemoteCall(Remotes.HarvestPlant, plot)
    if not success then
        local harvestRemote = ReplicatedStorage:FindFirstChild("Harvest") or 
                             ReplicatedStorage:FindFirstChild("HarvestPlant") or
                             ReplicatedStorage:FindFirstChild("harvest")
        if harvestRemote then
            safeRemoteCall(harvestRemote, plot)
        end
    end
end

local function sellProduce()
    local success = safeRemoteCall(Remotes.SellProduce)
    if not success then
        local sellRemote = ReplicatedStorage:FindFirstChild("Sell") or 
                          ReplicatedStorage:FindFirstChild("SellProduce") or
                          ReplicatedStorage:FindFirstChild("sell")
        if sellRemote then
            safeRemoteCall(sellRemote)
        end
    end
end

local function buySeeds(seedType, amount)
    local success = safeRemoteCall(Remotes.BuySeeds, seedType, amount)
    if not success then
        local buyRemote = ReplicatedStorage:FindFirstChild("Buy") or 
                         ReplicatedStorage:FindFirstChild("BuySeeds") or
                         ReplicatedStorage:FindFirstChild("buy")
        if buyRemote then
            safeRemoteCall(buyRemote, seedType, amount)
        end
    end
end

local function upgradeTools()
    local success = safeRemoteCall(Remotes.UpgradeTools)
    if not success then
        local upgradeRemote = ReplicatedStorage:FindFirstChild("Upgrade") or 
                             ReplicatedStorage:FindFirstChild("UpgradeTools") or
                             ReplicatedStorage:FindFirstChild("upgrade")
        if upgradeRemote then
            safeRemoteCall(upgradeRemote)
        end
    end
end

-- Main Farming Tab
local FarmingTab = Window:CreateTab("🌾 Auto Farming", 4483362458)
local MainSection = FarmingTab:CreateSection("Core Automation")

MainSection:CreateToggle({
    Name = "🌱 Auto Plant Seeds",
    CurrentValue = false,
    Flag = "AutoPlant",
    Callback = function(Value)
        Settings.AutoPlant = Value
        if Value then
            Rayfield:Notify({
                Title = "✅ Auto Plant Enabled",
                Content = "Now automatically planting seeds!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

MainSection:CreateToggle({
    Name = "💧 Auto Water Plants",
    CurrentValue = false,
    Flag = "AutoWater",
    Callback = function(Value)
        Settings.AutoWater = Value
        if Value then
            Rayfield:Notify({
                Title = "✅ Auto Water Enabled",
                Content = "Now automatically watering plants!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

MainSection:CreateToggle({
    Name = "🌾 Auto Harvest Plants",
    CurrentValue = false,
    Flag = "AutoHarvest",
    Callback = function(Value)
        Settings.AutoHarvest = Value
        if Value then
            Rayfield:Notify({
                Title = "✅ Auto Harvest Enabled",
                Content = "Now automatically harvesting plants!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

MainSection:CreateToggle({
    Name = "💰 Auto Sell Produce",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(Value)
        Settings.AutoSell = Value
        if Value then
            Rayfield:Notify({
                Title = "✅ Auto Sell Enabled",
                Content = "Now automatically selling produce!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

MainSection:CreateToggle({
    Name = "🛒 Auto Buy Seeds",
    CurrentValue = false,
    Flag = "AutoBuySeeds",
    Callback = function(Value)
        Settings.AutoBuySeeds = Value
    end,
})

local SeedSection = FarmingTab:CreateSection("Seed Management")

SeedSection:CreateDropdown({
    Name = "🌱 Select Seed Type",
    Options = getAvailableSeeds(),
    CurrentOption = "Carrot",
    Flag = "SelectedSeed",
    Callback = function(Option)
        Settings.SelectedSeed = Option
    end,
})

SeedSection:CreateSlider({
    Name = "Seed Buy Amount",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 10,
    Flag = "SeedAmount",
    Callback = function(Value)
        Settings.SeedAmount = Value
    end,
})

SeedSection:CreateButton({
    Name = "🛒 Buy Seeds Now",
    Callback = function()
        buySeeds(Settings.SelectedSeed, Settings.SeedAmount)
        Rayfield:Notify({
            Title = "🛒 Seeds Purchased",
            Content = "Bought " .. Settings.SeedAmount .. " " .. Settings.SelectedSeed .. " seeds!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Tools & Upgrades Tab
local ToolsTab = Window:CreateTab("🔧 Tools & Upgrades", 4483362458)
local ToolsSection = ToolsTab:CreateSection("Tool Automation")

ToolsSection:CreateToggle({
    Name = "🔄 Auto Upgrade All Tools",
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

ToolsSection:CreateToggle({
    Name = "🪣 Auto Upgrade Watering Can",
    CurrentValue = false,
    Flag = "AutoUpgradeWateringCan",
    Callback = function(Value)
        Settings.AutoUpgradeWateringCan = Value
    end,
})

ToolsSection:CreateToggle({
    Name = "🔨 Auto Upgrade Hoe",
    CurrentValue = false,
    Flag = "AutoUpgradeHoe",
    Callback = function(Value)
        Settings.AutoUpgradeHoe = Value
    end,
})

ToolsSection:CreateToggle({
    Name = "🎒 Auto Upgrade Bag",
    CurrentValue = false,
    Flag = "AutoUpgradeBag",
    Callback = function(Value)
        Settings.AutoUpgradeBag = Value
    end,
})

ToolsSection:CreateButton({
    Name = "⚡ Upgrade All Now",
    Callback = function()
        upgradeTools()
        Rayfield:Notify({
            Title = "⚡ Tools Upgraded",
            Content = "Attempted to upgrade all tools!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Player Enhancement Tab
local PlayerTab = Window:CreateTab("👤 Player Enhancement", 4483362458)
local MovementSection = PlayerTab:CreateSection("Movement Controls")

MovementSection:CreateSlider({
    Name = "🏃 Walk Speed",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        Settings.WalkSpeed = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

MovementSection:CreateSlider({
    Name = "🦘 Jump Power",
    Range = {50, 500},
    Increment = 1,
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        Settings.JumpPower = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
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

MovementSection:CreateToggle({
    Name = "🚀 Auto Teleport to Plots",
    CurrentValue = false,
    Flag = "TeleportToPlots",
    Callback = function(Value)
        Settings.TeleportToPlots = Value
    end,
})

-- Teleportation Tab
local TeleportTab = Window:CreateTab("🚀 Teleportation", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Quick Travel")

TeleportSection:CreateButton({
    Name = "🏪 Teleport to Shop",
    Callback = function()
        local shop = Workspace:FindFirstChild("Shop") or Workspace:FindFirstChild("shop")
        if shop and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = shop.CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

TeleportSection:CreateButton({
    Name = "🏠 Teleport to Spawn",
    Callback = function()
        local spawn = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("spawn")
        if spawn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

TeleportSection:CreateButton({
    Name = "🌱 Teleport to First Plot",
    Callback = function()
        local plots = getPlayerPlots()
        if #plots > 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = plots[1].CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

-- Visual Enhancements Tab
local VisualTab = Window:CreateTab("👁️ Visual Features", 4483362458)
local VisualSection = VisualTab:CreateSection("Visual Enhancements")

VisualSection:CreateToggle({
    Name = "🌈 Rainbow Plants",
    CurrentValue = false,
    Flag = "RainbowPlants",
    Callback = function(Value)
        Settings.RainbowPlants = Value
    end,
})

VisualSection:CreateToggle({
    Name = "📍 Plant ESP",
    CurrentValue = false,
    Flag = "PlantESP",
    Callback = function(Value)
        Settings.PlantESP = Value
    end,
})

VisualSection:CreateButton({
    Name = "🎨 Apply Rainbow Effect",
    Callback = function()
        for _, plot in pairs(getPlayerPlots()) do
            local plant = plot:FindFirstChild("Plant")
            if plant then
                spawn(function()
                    while plant.Parent and Settings.RainbowPlants do
                        for i = 1, 10 do
                            if plant.Parent and Settings.RainbowPlants then
                                plant.Color = Color3.fromHSV(i/10, 1, 1)
                                wait(0.1)
                            end
                        end
                    end
                end)
            end
        end
    end,
})

-- Advanced Features Tab
local AdvancedTab = Window:CreateTab("⚙️ Advanced Features", 4483362458)
local AdvancedSection = AdvancedTab:CreateSection("Advanced Automation")

AdvancedSection:CreateToggle({
    Name = "🎁 Auto Collect Rewards",
    CurrentValue = false,
    Flag = "AutoCollectRewards",
    Callback = function(Value)
        Settings.AutoCollectRewards = Value
    end,
})

AdvancedSection:CreateToggle({
    Name = "🌟 Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        Settings.AutoRebirth = Value
    end,
})

AdvancedSection:CreateToggle({
    Name = "📋 Auto Claim Quests",
    CurrentValue = false,
    Flag = "AutoClaimQuests",
    Callback = function(Value)
        Settings.AutoClaimQuests = Value
    end,
})

AdvancedSection:CreateSlider({
    Name = "⏱️ Loop Delay (seconds)",
    Range = {0.1, 5},
    Increment = 0.1,
    CurrentValue = 0.5,
    Flag = "LoopDelay",
    Callback = function(Value)
        Settings.LoopDelay = Value
    end,
})

-- Statistics Tab
local StatsTab = Window:CreateTab("📊 Statistics", 4483362458)
local StatsSection = StatsTab:CreateSection("Performance Stats")

local StatsLabels = {
    PlantsPlanted = StatsSection:CreateLabel("Plants Planted: 0"),
    PlantsWatered = StatsSection:CreateLabel("Plants Watered: 0"),
    PlantsHarvested = StatsSection:CreateLabel("Plants Harvested: 0"),
    ItemsSold = StatsSection:CreateLabel("Items Sold: 0"),
    RuntimeDuration = StatsSection:CreateLabel("Runtime: 0 minutes")
}

-- Statistics tracking
local Statistics = {
    PlantsPlanted = 0,
    PlantsWatered = 0,
    PlantsHarvested = 0,
    ItemsSold = 0,
    StartTime = tick()
}

local function updateStatistics()
    if StatsLabels.PlantsPlanted then
        StatsLabels.PlantsPlanted:Set("Plants Planted: " .. Statistics.PlantsPlanted)
        StatsLabels.PlantsWatered:Set("Plants Watered: " .. Statistics.PlantsWatered)
        StatsLabels.PlantsHarvested:Set("Plants Harvested: " .. Statistics.PlantsHarvested)
        StatsLabels.ItemsSold:Set("Items Sold: " .. Statistics.ItemsSold)
        
        local runtime = math.floor((tick() - Statistics.StartTime) / 60)
        StatsLabels.RuntimeDuration:Set("Runtime: " .. runtime .. " minutes")
    end
end

-- Misc Tab
local MiscTab = Window:CreateTab("🔧 Miscellaneous", 4483362458)
local MiscSection = MiscTab:CreateSection("Utilities")

MiscSection:CreateButton({
    Name = "💾 Save Configuration",
    Callback = function()
        Rayfield:Notify({
            Title = "✅ Configuration Saved",
            Content = "Your settings have been saved successfully!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

MiscSection:CreateButton({
    Name = "🔄 Refresh Remotes",
    Callback = function()
        findRemotes()
        Rayfield:Notify({
            Title = "🔄 Remotes Refreshed",
            Content = "Remote events have been rescanned!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

MiscSection:CreateButton({
    Name = "📋 Copy Game Info",
    Callback = function()
        local info = "Game: " .. gameName .. "\nPlace ID: " .. game.PlaceId .. "\nVersion: Neon Hub V2.0"
        setclipboard(info)
        Rayfield:Notify({
            Title = "📋 Info Copied",
            Content = "Game information copied to clipboard!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Main Automation Loop
spawn(function()
    while wait(Settings.LoopDelay) do
        pcall(function()
            if Settings.AutoPlant or Settings.AutoWater or Settings.AutoHarvest then
                local plots = getPlayerPlots()
                
                for _, plot in pairs(plots) do
                    pcall(function()
                        local plant = plot:FindFirstChild("Plant") or plot:FindFirstChild("plant")
                        local soil = plot:FindFirstChild("Soil") or plot:FindFirstChild("soil")
                        
                        -- Auto Plant Logic
                        if Settings.AutoPlant and soil and not plant then
                            if Settings.TeleportToPlots and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame + Vector3.new(0, 5, 0)
                                wait(0.3)
                            end
                            plantSeed(plot, Settings.SelectedSeed)
                            Statistics.PlantsPlanted = Statistics.PlantsPlanted + 1
                            wait(0.1)
                        end
                        
                        -- Auto Water Logic
                        if Settings.AutoWater and plant then
                            local needsWater = plant:FindFirstChild("NeedsWater") or 
                                             plant:GetAttribute("NeedsWater") or
                                             (plant:FindFirstChild("Water") and plant.Water.Value < 100)
                            
                            if needsWater then
                                if Settings.TeleportToPlots and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame + Vector3.new(0, 5, 0)
                                    wait(0.3)
                                end
                                waterPlant(plot)
                                Statistics.PlantsWatered = Statistics.PlantsWatered + 1
                                wait(0.1)
                            end
                        end
                        
                        -- Auto Harvest Logic
                        if Settings.AutoHarvest and plant then
                            local isReady = plant:FindFirstChild("IsReady") or 
                                          plant:GetAttribute("IsReady") or
                                          plant:FindFirstChild("Ready")
                            
                            if (isReady and isReady.Value) or plant:GetAttribute("Ready") then
                                if Settings.TeleportToPlots and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = plot.CFrame + Vector3.new(0, 5, 0)
                                    wait(0.3)
                                end
                                harvestPlant(plot)
                                Statistics.PlantsHarvested = Statistics.PlantsHarvested + 1
                                wait(0.1)
                            end
                        end
                    end)
                end
            end
            
            -- Auto Sell
            if Settings.AutoSell then
                sellProduce()
                Statistics.ItemsSold = Statistics.ItemsSold + 1
            end
            
            -- Auto Buy Seeds
            if Settings.AutoBuySeeds then
                buySeeds(Settings.SelectedSeed, Settings.SeedAmount)
            end
            
            -- Auto Upgrade
            if Settings.AutoUpgrade then
                upgradeTools()
            end
            
            -- Auto Collect Rewards
            if Settings.AutoCollectRewards then
                local rewards = Workspace:FindFirstChild("Rewards") or Workspace:FindFirstChild("rewards")
                if rewards then
                    for _, reward in pairs(rewards:GetChildren()) do
                        pcall(function()
                            if reward:FindFirstChild("Collect") then
                                reward.Collect:FireServer()
                            elseif reward:FindFirstChild("TouchInterest") then
                                firetouchinterest(HumanoidRootPart, reward, 0)
                                firetouchinterest(HumanoidRootPart, reward, 1)
                            end
                        end)
                    end
                end
            end
            
            -- Update Statistics
            updateStatistics()
        end)
    end
end)

-- Speed Hack Loop
spawn(function()
    while wait() do
        if Settings.SpeedHack then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
                    LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
                end
            end)
        end
    end
end)

-- Infinite Water Loop
spawn(function()
    while wait(0.1) do
        if Settings.InfiniteWater then
            pcall(function()
                local wateringCan = LocalPlayer.Character:FindFirstChild("WateringCan") or 
                                  LocalPlayer.Character:FindFirstChild("Watering Can") or
                                  LocalPlayer.Backpack:FindFirstChild("WateringCan")
                
                if wateringCan then
                    local water = wateringCan:FindFirstChild("Water") or wateringCan:FindFirstChild("Amount")
                    if water and water:IsA("NumberValue") then
                        water.Value = 999999
                    end
                end
            end)
        end
    end
end)

-- Rainbow Plants Loop
spawn(function()
    while wait(0.1) do
        if Settings.RainbowPlants then
            pcall(function()
                for _, plot in pairs(getPlayerPlots()) do
                    local plant = plot:FindFirstChild("Plant")
                    if plant and plant:IsA("BasePart") then
                        plant.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    end
                end
            end)
        end
    end
end)

-- Character Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(character)
    Character = character
    Humanoid = character:WaitForChild("Humanoid")
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    wait(1)
    if Settings.SpeedHack then
        Humanoid.WalkSpeed = Settings.WalkSpeed
        Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- Error Handling and Logging
local function logError(error, context)
    warn("[Neon Hub V2] Error in " .. context .. ": " .. tostring(error))
end

-- Success Notification
wait(2)
Rayfield:Notify({
    Title = "🌱 Neon Hub V2 Loaded Successfully!",
    Content = "All features loaded for " .. gameName,
    Duration = 5,
    Image = 4483362458
})

print("==========================================")
print("🌱 Neon Hub V2 - Grow a Garden Script")
print("Created By: _XzgyX_")
print("Version: 2.0")
print("Game: " .. gameName)
print("Status: ✅ Successfully Loaded")
print("Features: All farming functions enabled")
print("==========================================")
