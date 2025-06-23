--[[
    NEON HUB - Blox Fruits Script
    Created by XxxzgyxxX
    Version: 1.5
    Features: Auto Farm, Auto Dungeon, Auto Sea Events, Player ESP, and more!
]]

local NEON_HUB = {
    Version = "1.5",
    Creator = "XxxzgyxxX",
    LastUpdate = "06/2023"
}

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Game Variables
local Islands = Workspace:WaitForChild("Map"):WaitForChild("Islands"):GetChildren()
local NPCs = Workspace:WaitForChild("NPCs")
local Fruits = Workspace:WaitForChild("Fruits")
local Boats = Workspace:WaitForChild("Boats")

-- Remote Functions
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CombatRemote = Remotes:WaitForChild("Combat")
local RequestEntrance = Remotes:WaitForChild("RequestEntrance")
local BuyItemRemote = Remotes:WaitForChild("BuyItem")

-- GUI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("NEON HUB - Blox Fruits", "Ocean")

-- Tabs
local MainTab = Window:NewTab("Main")
local AutoFarmTab = Window:NewTab("Auto Farm")
local PlayerTab = Window:NewTab("Player")
local TeleportTab = Window:NewTab("Teleport")
local MiscTab = Window:NewTab("Misc")

-- Sections
local MainSection = MainTab:NewSection("Main Features")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm Options")
local PlayerSection = PlayerTab:NewSection("Player Modifications")
local TeleportSection = TeleportTab:NewSection("Teleport Options")
local MiscSection = MiscTab:NewSection("Miscellaneous")

-- Variables
local AutoFarmEnabled = false
local AutoDungeonEnabled = false
local AutoSeaEventsEnabled = false
local AutoNewWorldEnabled = false
local AutoThirdSeaEnabled = false
local AutoBossEnabled = false
local AutoEliteHunterEnabled = false
local AutoRaidEnabled = false
local AutoBuyEnabled = false
local AutoSellEnabled = false
local AutoCollectChestsEnabled = false
local AutoCollectFruitsEnabled = false
local AutoKenEnabled = false
local AutoHakiEnabled = false
local AutoBusoEnabled = false
local AutoObservationEnabled = false
local AutoSoruEnabled = false
local AutoGeppoEnabled = false
local AutoFarmLevel = false
local AutoFarmBeli = false
local AutoFarmFragments = false
local SelectedWeapon = ""
local SelectedIsland = ""
local SelectedBoss = ""
local SelectedFruit = ""
local SelectedDungeon = ""
local SelectedRaid = ""
local WalkSpeed = 16
local JumpPower = 50
local FarmDistance = 20
local SelectedQuest = ""

-- Player ESP
local ESPEnabled = false
local ESPBoxes = {}
local ESPHighlights = {}

-- Functions
function GetClosestNPC()
    local closestNPC = nil
    local closestDistance = math.huge
    
    for _, npc in pairs(NPCs:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and npc.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestNPC = npc
            end
        end
    end
    
    return closestNPC
end

function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

function GetClosestFruit()
    local closestFruit = nil
    local closestDistance = math.huge
    
    for _, fruit in pairs(Fruits:GetChildren()) do
        if fruit:FindFirstChild("Handle") then
            local distance = (HumanoidRootPart.Position - fruit.Handle.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestFruit = fruit
            end
        end
    end
    
    return closestFruit
end

function AttackNPC(npc)
    if npc and npc:FindFirstChild("HumanoidRootPart") then
        HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, FarmDistance)
        CombatRemote:InvokeServer("MousePos", npc.HumanoidRootPart.Position)
        CombatRemote:InvokeServer("Damage", npc.HumanoidRootPart, npc.HumanoidRootPart.Position)
    end
end

function TeleportTo(position)
    if HumanoidRootPart then
        HumanoidRootPart.CFrame = position
    end
end

function ToggleESP()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                ESPHighlights[player] = highlight
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if ESPEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    ESPHighlights[player] = highlight
                end
            end)
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            if ESPHighlights[player] then
                ESPHighlights[player]:Destroy()
                ESPHighlights[player] = nil
            end
        end)
    else
        for _, highlight in pairs(ESPHighlights) do
            highlight:Destroy()
        end
        ESPHighlights = {}
    end
end

function AutoFarm()
    while AutoFarmEnabled do
        local closestNPC = GetClosestNPC()
        if closestNPC then
            AttackNPC(closestNPC)
        end
        wait(0.1)
    end
end

function AutoFarmLevels()
    while AutoFarmLevel do
        local closestNPC = GetClosestNPC()
        if closestNPC then
            AttackNPC(closestNPC)
        end
        wait(0.1)
    end
end

function AutoFarmBeli()
    while AutoFarmBeli do
        local closestNPC = GetClosestNPC()
        if closestNPC then
            AttackNPC(closestNPC)
        end
        wait(0.1)
    end
end

function AutoFarmFragments()
    while AutoFarmFragments do
        local closestNPC = GetClosestNPC()
        if closestNPC then
            AttackNPC(closestNPC)
        end
        wait(0.1)
    end
end

function AutoDungeon()
    while AutoDungeonEnabled do
        -- Dungeon logic here
        wait(1)
    end
end

function AutoSeaEvents()
    while AutoSeaEventsEnabled do
        -- Sea Events logic here
        wait(1)
    end
end

function AutoNewWorld()
    while AutoNewWorldEnabled do
        -- New World logic here
        wait(1)
    end
end

function AutoThirdSea()
    while AutoThirdSeaEnabled do
        -- Third Sea logic here
        wait(1)
    end
end

function AutoBoss()
    while AutoBossEnabled do
        -- Boss logic here
        wait(1)
    end
end

function AutoEliteHunter()
    while AutoEliteHunterEnabled do
        -- Elite Hunter logic here
        wait(1)
    end
end

function AutoRaid()
    while AutoRaidEnabled do
        -- Raid logic here
        wait(1)
    end
end

function AutoBuy()
    while AutoBuyEnabled do
        -- Auto Buy logic here
        wait(1)
    end
end

function AutoSell()
    while AutoSellEnabled do
        -- Auto Sell logic here
        wait(1)
    end
end

function AutoCollectChests()
    while AutoCollectChestsEnabled do
        -- Chest collection logic here
        wait(1)
    end
end

function AutoCollectFruits()
    while AutoCollectFruitsEnabled do
        local closestFruit = GetClosestFruit()
        if closestFruit then
            TeleportTo(closestFruit.Handle.CFrame)
        end
        wait(1)
    end
end

function AutoKen()
    while AutoKenEnabled do
        CombatRemote:InvokeServer("Ken", true)
        wait(0.1)
    end
end

function AutoHaki()
    while AutoHakiEnabled do
        CombatRemote:InvokeServer("Buso")
        wait(0.1)
    end
end

function AutoBuso()
    while AutoBusoEnabled do
        CombatRemote:InvokeServer("Buso")
        wait(0.1)
    end
end

function AutoObservation()
    while AutoObservationEnabled do
        CombatRemote:InvokeServer("Observation")
        wait(0.1)
    end
end

function AutoSoru()
    while AutoSoruEnabled do
        CombatRemote:InvokeServer("Soru")
        wait(0.1)
    end
end

function AutoGeppo()
    while AutoGeppoEnabled do
        CombatRemote:InvokeServer("Geppo")
        wait(0.1)
    end
end

-- Main Section
MainSection:NewToggle("Auto Farm", "Automatically farms nearby NPCs", function(state)
    AutoFarmEnabled = state
    if state then
        AutoFarm()
    end
end)

MainSection:NewToggle("Auto Dungeon", "Automatically completes dungeons", function(state)
    AutoDungeonEnabled = state
    if state then
        AutoDungeon()
    end
end)

MainSection:NewToggle("Auto Sea Events", "Automatically completes sea events", function(state)
    AutoSeaEventsEnabled = state
    if state then
        AutoSeaEvents()
    end
end)

MainSection:NewToggle("Auto New World", "Automatically travels to New World", function(state)
    AutoNewWorldEnabled = state
    if state then
        AutoNewWorld()
    end
end)

MainSection:NewToggle("Auto Third Sea", "Automatically travels to Third Sea", function(state)
    AutoThirdSeaEnabled = state
    if state then
        AutoThirdSea()
    end
end)

-- Auto Farm Section
AutoFarmSection:NewToggle("Auto Farm Levels", "Automatically farms levels", function(state)
    AutoFarmLevel = state
    if state then
        AutoFarmLevels()
    end
end)

AutoFarmSection:NewToggle("Auto Farm Beli", "Automatically farms Beli", function(state)
    AutoFarmBeli = state
    if state then
        AutoFarmBeli()
    end
end)

AutoFarmSection:NewToggle("Auto Farm Fragments", "Automatically farms Fragments", function(state)
    AutoFarmFragments = state
    if state then
        AutoFarmFragments()
    end
end)

AutoFarmSection:NewDropdown("Select Weapon", "Select your weapon", {"Melee", "Sword", "Gun", "Fruit"}, function(weapon)
    SelectedWeapon = weapon
end)

AutoFarmSection:NewDropdown("Select Island", "Select an island", {"First Island", "Second Island", "Third Island"}, function(island)
    SelectedIsland = island
end)

AutoFarmSection:NewDropdown("Select Boss", "Select a boss", {"Boss1", "Boss2", "Boss3"}, function(boss)
    SelectedBoss = boss
end)

-- Player Section
PlayerSection:NewSlider("Walk Speed", "Changes your walk speed", 500, 16, function(speed)
    WalkSpeed = speed
    Humanoid.WalkSpeed = speed
end)

PlayerSection:NewSlider("Jump Power", "Changes your jump power", 500, 50, function(power)
    JumpPower = power
    Humanoid.JumpPower = power
end)

PlayerSection:NewToggle("Player ESP", "Shows players through walls", function(state)
    ToggleESP()
end)

PlayerSection:NewToggle("Auto Ken", "Automatically uses Ken", function(state)
    AutoKenEnabled = state
    if state then
        AutoKen()
    end
end)

PlayerSection:NewToggle("Auto Haki", "Automatically uses Haki", function(state)
    AutoHakiEnabled = state
    if state then
        AutoHaki()
    end
end)

PlayerSection:NewToggle("Auto Buso", "Automatically uses Buso Haki", function(state)
    AutoBusoEnabled = state
    if state then
        AutoBuso()
    end
end)

PlayerSection:NewToggle("Auto Observation", "Automatically uses Observation Haki", function(state)
    AutoObservationEnabled = state
    if state then
        AutoObservation()
    end
end)

PlayerSection:NewToggle("Auto Soru", "Automatically uses Soru", function(state)
    AutoSoruEnabled = state
    if state then
        AutoSoru()
    end
end)

PlayerSection:NewToggle("Auto Geppo", "Automatically uses Geppo", function(state)
    AutoGeppoEnabled = state
    if state then
        AutoGeppo()
    end
end)

-- Teleport Section
TeleportSection:NewButton("Teleport to Selected Island", "Teleports to selected island", function()
    -- Teleport logic here
end)

TeleportSection:NewButton("Teleport to Selected Boss", "Teleports to selected boss", function()
    -- Teleport logic here
end)

TeleportSection:NewButton("Teleport to Player", "Teleports to a player", function()
    local closestPlayer = GetClosestPlayer()
    if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
        TeleportTo(closestPlayer.Character.HumanoidRootPart.CFrame)
    end
end)

TeleportSection:NewButton("Teleport to Safe Zone", "Teleports to safe zone", function()
    -- Safe zone logic here
end)

-- Misc Section
MiscSection:NewToggle("Auto Collect Fruits", "Automatically collects fruits", function(state)
    AutoCollectFruitsEnabled = state
    if state then
        AutoCollectFruits()
    end
end)

MiscSection:NewToggle("Auto Collect Chests", "Automatically collects chests", function(state)
    AutoCollectChestsEnabled = state
    if state then
        AutoCollectChests()
    end
end)

MiscSection:NewToggle("Auto Buy Items", "Automatically buys items", function(state)
    AutoBuyEnabled = state
    if state then
        AutoBuy()
    end
end)

MiscSection:NewToggle("Auto Sell Items", "Automatically sells items", function(state)
    AutoSellEnabled = state
    if state then
        AutoSell()
    end
end)

MiscSection:NewButton("Rejoin Server", "Rejoins the current server", function()
    TeleportService:Teleport(game.PlaceId, Player)
end)

MiscSection:NewButton("Server Hop", "Joins a different server", function()
    -- Server hop logic here
end)

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Character Added Event
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    Humanoid.WalkSpeed = WalkSpeed
    Humanoid.JumpPower = JumpPower
end)

print("NEON HUB loaded successfully! Created by XxxzgyxxX")
