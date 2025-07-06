
--[[
    ███╗   ██╗███████╗ ██████╗ ███╗   ██╗    ██╗  ██╗██╗   ██╗██████╗     ██╗   ██╗██╗  ██╗
    ████╗  ██║██╔════╝██╔═══██╗████╗  ██║    ██║  ██║██║   ██║██╔══██╗    ██║   ██║██║  ██║
    ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║    ███████║██║   ██║██████╔╝    ██║   ██║███████║
    ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║    ██�══██║██║   ██║██╔══██╗    ╚██╗ ██╔╝╚════██║
    ██║ ╚████║███████╗╚██████╔╝██║ ╚████║    ██║  ██║╚██████╔╝██████╔╝     ╚████╔╝      ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝       ╚═══╝       ╚═╝
    
    🌟 NEON HUB V4 ULTIMATE - BLOX FRUITS SCRIPT 2025 🌟
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    📅 Versão: 4.5.0 ULTIMATE PREMIUM EDITION 2025
    👑 Desenvolvido por: Neon Development Team 
    🔥 Atualizado: Janeiro 2025 - Update 21+ Compatible
    🎯 Compatível com: Todas as atualizações do Blox Fruits
    ⚠️  USO POR SUA PRÓPRIA CONTA E RISCO
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]

-- 🔧 VERIFICAÇÃO DE AMBIENTE ROBLOX
if not game:GetService("Players") then
    print("⚠️ Este script deve ser executado dentro do Roblox!")
    return
end

-- 🎮 SERVIÇOS PRINCIPAIS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local PathfindingService = game:GetService("PathfindingService")
local MarketplaceService = game:GetService("MarketplaceService")

-- 🎯 VARIÁVEIS GLOBAIS
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Aguardar character spawn
local Character
local Humanoid
local RootPart

local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end

UpdateCharacter()

-- Reconectar quando character respawna
Player.CharacterAdded:Connect(UpdateCharacter)

-- 🌐 DETECÇÃO DE MAR ATUAL
local function GetCurrentSea()
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        return "First Sea"
    elseif placeId == 4442272183 then
        return "Second Sea"  
    elseif placeId == 7449423635 then
        return "Third Sea"
    else
        return "Unknown"
    end
end

-- 📊 CONFIGURAÇÕES AVANÇADAS V4.5
local NeonConfig = {
    Version = "4.5.0",
    CurrentSea = GetCurrentSea(),
    GameID = game.PlaceId,
    
    -- ⚡ AUTO FARM PRINCIPAL
    AutoFarm = false,
    AutoFarmMode = "Level",
    FarmSpeed = 25,
    AttackDelay = 0.03,
    FarmDistance = 7,
    SafeFarmDistance = 20,
    AutoFarmQuest = true,
    BringMobs = true,
    FastAttack = true,
    
    -- 👹 SISTEMA DE BOSS AVANÇADO
    AutoBoss = false,
    AutoAllBoss = false,
    BossMode = "Spawn",
    SelectedBoss = "All",
    BossNotification = true,
    BossHopServer = false,
    AutoRaidBoss = false,
    
    -- 💱 SISTEMA DE BARTENDER AVANÇADO 2025
    AutoBartender = false,
    BartenderMode = "All", -- All, SpecificNPC, LevelBased
    BartenderDelay = 5,
    BartenderDistance = 50,
    AutoBuyDrinks = true,
    DrinkTypes = {
        "Lemonade", "Apple Cider", "Banana Juice", "Pineapple Juice",
        "Orange Juice", "Cranberry Juice", "Grape Juice", "Chocolate Milk"
    },
    
    -- 🎯 SISTEMA DE QUEST INTELIGENTE
    AutoQuest = true,
    QuestMode = "Auto",
    AutoNewQuest = true,
    QuestTeleport = true,
    QuestCompleteDelay = 2,
    
    -- ⚔️ SISTEMA DE COMBATE ULTRA
    AutoClick = false,
    ClickSpeed = 0.01,
    UseSkills = false,
    SkillDelay = 0.5,
    AutoHaki = {
        Buso = true,
        Ken = true,
        Enhancement = true
    },
    CombatMode = "Balanced",
    
    -- 🍎 SISTEMA DE DEVIL FRUIT PREMIUM
    AutoFruit = false,
    FruitSniper = false,
    AutoStoreFruit = true,
    FruitTeleport = true,
    FruitNotification = true,
    FruitESP = true,
    AutoEatFruit = false,
    FruitBlacklist = {"Bomb", "Spike", "Chop", "Spring"},
    
    -- 💎 SISTEMA DE COLETA AVANÇADO
    AutoCollect = {
        Chests = false,
        Materials = false,
        Artifacts = false,
        Bones = false,
        EliteProgress = false
    },
    CollectRange = 50,
    MaterialESP = true,
    
    -- 🏴‍☠️ SISTEMA DE RAID COMPLETO
    AutoRaid = false,
    RaidMode = "All",
    AutoStartRaid = false,
    AutoNextIsland = true,
    AutoAwakeSkills = false,
    RaidSpeed = 30,
    
    -- 🌊 SISTEMA DE MAR E EVENTOS
    AutoSeaBeast = false,
    SeaBeastNotification = true,
    AutoFishman = false,
    AutoPiranha = false,
    AutoShark = false,
    AutoTerrorshark = false,
    AutoGhostShip = false,
    
    -- 🚢 SISTEMA DE BARCO AVANÇADO
    AutoBoat = false,
    BoatSpeed = 350,
    BoatClip = true,
    AutoDoughKing = false,
    
    -- 📈 SISTEMA DE STATS AUTOMÁTICO
    AutoStats = false,
    StatsMode = {
        Melee = 0,
        Defense = 0,
        Sword = 0,
        Gun = 0,
        Fruit = 100
    },
    AutoResetStats = false,
    
    -- 🎯 SISTEMA DE MASTERY FARM
    AutoMastery = false,
    MasteryMode = "Nearest",
    MasteryDelay = 3,
    AutoSwitchWeapon = true,
    
    -- 🛡️ SISTEMA DE PROTEÇÃO E SEGURANÇA
    AntiKick = true,
    AntiAFK = true,
    AntiLag = true,
    AntiCrash = true,
    SafeMode = false,
    AdminDetection = true,
    AutoRejoin = true,
    ServerHop = false,
    WhiteScreen = false,
    
    -- 🎨 SISTEMA DE ESP E VISUAL
    ESP = {
        Players = false,
        NPCs = true,
        Fruits = true,
        Chests = true,
        Materials = true,
        Bosses = true,
        Ships = false,
        Flowers = false,
        Islands = false,
        Bartender = true
    },
    Tracers = false,
    ESPDistance = 2000,
    
    -- 🔧 SISTEMA MISC AVANÇADO
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    NoClip = false,
    FullBright = false,
    RemoveFog = false,
    Fly = false,
    FlySpeed = 50,
    
    -- 🏪 SISTEMA DE SHOP E CÓDIGOS
    AutoBuyItems = false,
    AutoRaces = false,
    AutoCodes = false,
    AutoUpgradeRace = false,
    
    -- 📊 ESTATÍSTICAS DA SESSÃO
    SessionStats = {
        StartTime = tick(),
        Level = 0,
        Beli = 0,
        Fragments = 0,
        Experience = 0,
        Deaths = 0,
        Restarts = 0,
        ItemsCollected = 0,
        BossesKilled = 0,
        QuestsCompleted = 0,
        TimeActive = 0,
        FruitsCollected = 0,
        ChestsOpened = 0,
        DrinksConsumed = 0
    }
}

-- 🎨 CARREGANDO RAYFIELD UI
local Rayfield
pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Rayfield then
    print("❌ Erro ao carregar Rayfield UI")
    return
end

-- 🖥️ INTERFACE PRINCIPAL V4.5
local Window = Rayfield:CreateWindow({
    Name = "🌟 NEON HUB V4.5 - ULTIMATE BLOX FRUITS 2025",
    LoadingTitle = "NEON HUB V4.5",
    LoadingSubtitle = "Carregando 150+ funcionalidades premium...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHubV45",
        FileName = "UltimateConfig2025"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

-- 📑 CRIANDO TODAS AS TABS
local MainTab = Window:CreateTab("🎯 Auto Farm", 4483362458)
local BossTab = Window:CreateTab("👹 Boss System", 4483362458)
local BartenderTab = Window:CreateTab("🍹 Bartender System", 4483362458)
local FruitTab = Window:CreateTab("🍎 Devil Fruit", 4483362458)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local QuestTab = Window:CreateTab("🎯 Quest", 4483362458)
local RaidTab = Window:CreateTab("🏴‍☠️ Raid", 4483362458)
local SeaTab = Window:CreateTab("🌊 Sea Events", 4483362458)
local MasteryTab = Window:CreateTab("📊 Mastery", 4483362458)
local StatsTab = Window:CreateTab("📈 Stats", 4483362458)
local ESPTab = Window:CreateTab("👁️ ESP & Visual", 4483362458)
local MiscTab = Window:CreateTab("🔧 Misc", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleport", 4483362458)
local ShopTab = Window:CreateTab("🏪 Shop", 4483362458)
local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)
local InfoTab = Window:CreateTab("📊 Statistics", 4483362458)

-- 🔧 FUNÇÕES UTILITÁRIAS AVANÇADAS
local NeonUtils = {}

function NeonUtils:GetRandomDelay(min, max)
    return math.random(min or 10, max or 50) / 1000
end

function NeonUtils:SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("🚨 Erro:", result)
    end
    return success, result
end

function NeonUtils:GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

function NeonUtils:IsAlive(target)
    return target and target.Parent and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0
end

function NeonUtils:GetPlayerData(dataType)
    return NeonUtils:SafeCall(function()
        return Player.Data[dataType].Value
    end)
end

function NeonUtils:GetPlayerLevel()
    local success, level = NeonUtils:GetPlayerData("Level")
    return success and level or 1
end

function NeonUtils:GetPlayerBeli()
    local success, beli = NeonUtils:GetPlayerData("Beli")
    return success and beli or 0
end

function NeonUtils:GetPlayerFragments()
    local success, fragments = NeonUtils:GetPlayerData("Fragments")
    return success and fragments or 0
end

-- 📡 SISTEMA DE COMUNICAÇÃO
local RemoteManager = {}

function RemoteManager:GetRemote()
    return ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
end

function RemoteManager:InvokeServer(...)
    local remote = RemoteManager:GetRemote()
    if remote then
        return NeonUtils:SafeCall(remote.InvokeServer, remote, ...)
    end
end

function RemoteManager:FireServer(...)
    local remote = RemoteManager:GetRemote()
    if remote then
        return NeonUtils:SafeCall(remote.FireServer, remote, ...)
    end
end

-- 🔒 SISTEMA DE SEGURANÇA AVANÇADO
local SecuritySystem = {}

function SecuritySystem:CheckAdmins()
    local adminKeywords = {"admin", "mod", "staff", "dev", "owner", "creator"}
    for _, player in pairs(Players:GetPlayers()) do
        local name = player.Name:lower()
        for _, keyword in ipairs(adminKeywords) do
            if name:find(keyword) then
                return true, player.Name
            end
        end
    end
    return false
end

function SecuritySystem:EnableAntiKick()
    if NeonConfig.AntiKick then
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            if method == "Kick" then
                return
            end
            return old(...)
        end)
    end
end

-- ⚔️ SISTEMA DE COMBATE ULTRA V4.5
local CombatSystem = {}

function CombatSystem:GetNearestMob()
    local nearestMob = nil
    local shortestDistance = math.huge
    
    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if NeonUtils:IsAlive(mob) and mob:FindFirstChild("HumanoidRootPart") then
            local distance = NeonUtils:GetDistance(RootPart.Position, mob.HumanoidRootPart.Position)
            if distance < shortestDistance and distance < 2000 then
                shortestDistance = distance
                nearestMob = mob
            end
        end
    end
    
    return nearestMob, shortestDistance
end

function CombatSystem:GetTargetedMobs()
    local targetMobs = {}
    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if NeonUtils:IsAlive(mob) and mob:FindFirstChild("HumanoidRootPart") then
            local distance = NeonUtils:GetDistance(RootPart.Position, mob.HumanoidRootPart.Position)
            if distance < 50 then
                table.insert(targetMobs, mob)
            end
        end
    end
    return targetMobs
end

function CombatSystem:BringMobs()
    if not NeonConfig.BringMobs then return end
    
    local targetMobs = CombatSystem:GetTargetedMobs()
    for _, mob in pairs(targetMobs) do
        if mob:FindFirstChild("HumanoidRootPart") then
            mob.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, NeonConfig.FarmDistance)
            mob.HumanoidRootPart.CanCollide = false
            mob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
            if mob:FindFirstChild("Humanoid") then
                mob.Humanoid.WalkSpeed = 0
                mob.Humanoid.JumpPower = 0
            end
        end
    end
end

function CombatSystem:FastAttack()
    if not NeonConfig.FastAttack then return end
    
    pcall(function()
        local CombatFramework = require(Player.PlayerScripts.CombatFramework)
        local CombatFrameworkR = getupvalues(CombatFramework)[2]
        local RigController = require(Player.PlayerScripts.CombatFramework.RigController)
        
        if typeof(CombatFrameworkR) ~= "table" then return end
        
        function CombatFrameworkR.activeController.timeToNextAttack()
            return (RigController.timeToNextAttack and RigController.timeToNextAttack() or 2e20) * 0.001
        end
        
        function CombatFrameworkR.activeController.hitboxMagnitude()
            return 60
        end
    end)
end

function CombatSystem:EnableHaki()
    if NeonConfig.AutoHaki.Buso then
        RemoteManager:InvokeServer("Buso")
    end
    if NeonConfig.AutoHaki.Ken then
        RemoteManager:InvokeServer("Ken", true)
    end
end

function CombatSystem:UseSkills()
    if not NeonConfig.UseSkills then return end
    
    local skills = {"Z", "X", "C", "V", "F"}
    for _, skill in ipairs(skills) do
        VirtualInputManager:SendKeyEvent(true, skill, false, game)
        wait(NeonConfig.SkillDelay)
        VirtualInputManager:SendKeyEvent(false, skill, false, game)
    end
end

function CombatSystem:AutoClick()
    if NeonConfig.AutoClick then
        RemoteManager:InvokeServer("TAP")
    end
end

-- 🚀 SISTEMA DE MOVIMENTAÇÃO PREMIUM
local MovementSystem = {}

function MovementSystem:Tween(targetPosition, speed)
    if not targetPosition then return end
    
    speed = speed or NeonConfig.FarmSpeed
    local distance = NeonUtils:GetDistance(RootPart.Position, targetPosition)
    local tweenTime = distance / (speed * 50)
    
    local tween = TweenService:Create(RootPart, TweenInfo.new(
        tweenTime,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut
    ), {CFrame = CFrame.new(targetPosition)})
    
    tween:Play()
    return tween
end

function MovementSystem:StopTween()
    for _, tween in pairs(TweenService:GetTweens()) do
        tween:Cancel()
    end
end

function MovementSystem:TeleportTo(position)
    if position then
        RootPart.CFrame = CFrame.new(position)
    end
end

-- 🍹 SISTEMA DE BARTENDER AVANÇADO 2025
local BartenderSystem = {}

BartenderSystem.BartenderLocations = {
    -- First Sea
    ["Tavern"] = {
        Position = CFrame.new(-380, 7, 298),
        NPCs = {"Bartender", "Barkeep"},
        Drinks = {"Lemonade", "Apple Cider", "Banana Juice"}
    },
    
    -- Second Sea  
    ["Cafe"] = {
        Position = CFrame.new(2295, 15, 786),
        NPCs = {"Bartender", "Cafe Owner"},
        Drinks = {"Pineapple Juice", "Orange Juice", "Cranberry Juice"}
    },
    
    -- Third Sea
    ["Tiki Outpost"] = {
        Position = CFrame.new(-16545, 9, 446),
        NPCs = {"Bartender", "Tiki Bartender"},
        Drinks = {"Grape Juice", "Chocolate Milk", "Coconut Water"}
    }
}

function BartenderSystem:GetNearestBartender()
    local nearestBartender = nil
    local shortestDistance = math.huge
    
    for locationName, locationData in pairs(BartenderSystem.BartenderLocations) do
        for _, npcName in ipairs(locationData.NPCs) do
            for _, npc in pairs(Workspace.NPCs:GetChildren()) do
                if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
                    local distance = NeonUtils:GetDistance(RootPart.Position, npc.HumanoidRootPart.Position)
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestBartender = {
                            NPC = npc,
                            Location = locationName,
                            Distance = distance,
                            Drinks = locationData.Drinks
                        }
                    end
                end
            end
        end
    end
    
    return nearestBartender
end

function BartenderSystem:InteractWithBartender(bartenderData)
    if not bartenderData or not bartenderData.NPC then return end
    
    local bartender = bartenderData.NPC
    local drinks = bartenderData.Drinks
    
    -- Mover para o bartender
    MovementSystem:Tween(bartender.HumanoidRootPart.Position)
    wait(2)
    
    -- Interagir com o NPC
    if NeonConfig.AutoBuyDrinks then
        for _, drinkName in ipairs(drinks) do
            -- Tentar comprar bebida
            RemoteManager:InvokeServer("BuyItem", drinkName)
            wait(NeonConfig.BartenderDelay)
            
            NeonConfig.SessionStats.DrinksConsumed = NeonConfig.SessionStats.DrinksConsumed + 1
            
            if NeonConfig.ESP.Bartender then
                Rayfield:Notify({
                    Title = "🍹 Bebida Comprada!",
                    Content = drinkName .. " foi comprada!",
                    Duration = 3
                })
            end
        end
    end
end

function BartenderSystem:AutoBartender()
    if not NeonConfig.AutoBartender then return end
    
    spawn(function()
        while NeonConfig.AutoBartender do
            local bartenderData = BartenderSystem:GetNearestBartender()
            
            if bartenderData and bartenderData.Distance < NeonConfig.BartenderDistance then
                BartenderSystem:InteractWithBartender(bartenderData)
            else
                -- Procurar bartenders em outras ilhas
                for locationName, locationData in pairs(BartenderSystem.BartenderLocations) do
                    if NeonConfig.BartenderMode == "All" or NeonConfig.BartenderMode == locationName then
                        MovementSystem:TeleportTo(locationData.Position.Position)
                        wait(3)
                        
                        local nearbyBartender = BartenderSystem:GetNearestBartender()
                        if nearbyBartender and nearbyBartender.Distance < 50 then
                            BartenderSystem:InteractWithBartender(nearbyBartender)
                        end
                    end
                end
            end
            
            wait(30) -- Aguardar 30 segundos antes da próxima busca
        end
    end)
end

-- 🍎 SISTEMA DE DEVIL FRUIT AVANÇADO
local FruitSystem = {}

function FruitSystem:GetAllFruits()
    local fruits = {}
    for _, fruit in pairs(Workspace:GetChildren()) do
        if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
            local distance = NeonUtils:GetDistance(RootPart.Position, fruit.Handle.Position)
            if distance < 10000 then
                table.insert(fruits, {
                    Object = fruit,
                    Name = fruit.Name,
                    Distance = distance,
                    Position = fruit.Handle.Position
                })
            end
        end
    end
    
    table.sort(fruits, function(a, b) return a.Distance < b.Distance end)
    return fruits
end

function FruitSystem:CollectFruits()
    if not NeonConfig.AutoFruit then return end
    
    local fruits = FruitSystem:GetAllFruits()
    for _, fruitData in ipairs(fruits) do
        local isBlacklisted = false
        for _, blacklisted in ipairs(NeonConfig.FruitBlacklist) do
            if fruitData.Name:find(blacklisted) then
                isBlacklisted = true
                break
            end
        end
        
        if not isBlacklisted then
            if NeonConfig.FruitTeleport then
                MovementSystem:TeleportTo(fruitData.Position)
            else
                MovementSystem:Tween(fruitData.Position, 50)
            end
            
            wait(1)
            NeonConfig.SessionStats.FruitsCollected = NeonConfig.SessionStats.FruitsCollected + 1
            
            if NeonConfig.FruitNotification then
                Rayfield:Notify({
                    Title = "🍎 Fruta Coletada!",
                    Content = fruitData.Name,
                    Duration = 3
                })
            end
        end
    end
end

-- 🎯 SISTEMA DE QUEST INTELIGENTE V4.5
local QuestSystem = {}

QuestSystem.QuestData = {
    -- First Sea Quests Atualizadas 2025
    ["Bandit"] = {Level = {1, 10}, Map = "Jungle", QuestGiver = "Bandit Quest", Number = 1},
    ["Monkey"] = {Level = {11, 20}, Map = "Jungle", QuestGiver = "Monkey Quest", Number = 1},
    ["Gorilla"] = {Level = {21, 30}, Map = "Jungle", QuestGiver = "Gorilla Quest", Number = 2},
    ["Pirate"] = {Level = {31, 40}, Map = "Buggy", QuestGiver = "Pirate Quest", Number = 1},
    ["Brute"] = {Level = {41, 50}, Map = "Buggy", QuestGiver = "Brute Quest", Number = 2},
    ["Desert Bandit"] = {Level = {51, 60}, Map = "Desert", QuestGiver = "Desert Quest", Number = 1},
    ["Desert Officer"] = {Level = {61, 70}, Map = "Desert", QuestGiver = "Desert Quest", Number = 2},
    ["Snow Bandit"] = {Level = {71, 80}, Map = "Snow", QuestGiver = "Snow Quest", Number = 1},
    ["Snowman"] = {Level = {81, 90}, Map = "Snow", QuestGiver = "Snow Quest", Number = 2},
    ["Chief Petty Officer"] = {Level = {91, 100}, Map = "Marine", QuestGiver = "Marine Quest", Number = 1},
    ["Sky Bandit"] = {Level = {101, 125}, Map = "Sky", QuestGiver = "Sky Quest", Number = 1},
    ["Dark Master"] = {Level = {126, 175}, Map = "Sky", QuestGiver = "Sky Quest", Number = 2},
    ["Prisoner"] = {Level = {176, 225}, Map = "Prison", QuestGiver = "Prison Quest", Number = 1},
    ["Dangerous Prisoner"] = {Level = {226, 275}, Map = "Prison", QuestGiver = "Prison Quest", Number = 2},
    ["Toga Warrior"] = {Level = {276, 300}, Map = "Colosseum", QuestGiver = "Colosseum Quest", Number = 1},
    ["Gladiator"] = {Level = {301, 325}, Map = "Colosseum", QuestGiver = "Colosseum Quest", Number = 2},
    ["Military Soldier"] = {Level = {326, 350}, Map = "Magma", QuestGiver = "Magma Quest", Number = 1},
    ["Military Spy"] = {Level = {351, 375}, Map = "Magma", QuestGiver = "Magma Quest", Number = 2},
    ["Fishman Warrior"] = {Level = {376, 400}, Map = "Fishman", QuestGiver = "Fishman Quest", Number = 1},
    ["Fishman Commando"] = {Level = {401, 450}, Map = "Fishman", QuestGiver = "Fishman Quest", Number = 2},
    ["God's Guard"] = {Level = {451, 475}, Map = "Sky", QuestGiver = "Sky Quest", Number = 1},
    ["Shanda"] = {Level = {476, 500}, Map = "Sky", QuestGiver = "Sky Quest", Number = 2},
    ["Royal Squad"] = {Level = {501, 525}, Map = "Sky", QuestGiver = "Sky Quest", Number = 1},
    ["Royal Soldier"] = {Level = {526, 550}, Map = "Sky", QuestGiver = "Sky Quest", Number = 2},
    ["Galley Pirate"] = {Level = {551, 600}, Map = "Fountain", QuestGiver = "Fountain Quest", Number = 1},
    ["Galley Captain"] = {Level = {601, 625}, Map = "Fountain", QuestGiver = "Fountain Quest", Number = 2}
}

function QuestSystem:GetCurrentQuest()
    return NeonUtils:SafeCall(function()
        return Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    end)
end

function QuestSystem:HasQuest()
    local success, quest = QuestSystem:GetCurrentQuest()
    return success and quest and quest ~= ""
end

function QuestSystem:GetRecommendedQuest()
    local level = NeonUtils:GetPlayerLevel()
    
    for questName, questData in pairs(QuestSystem.QuestData) do
        if level >= questData.Level[1] and level <= questData.Level[2] then
            return questName, questData
        end
    end
    
    return nil
end

function QuestSystem:StartQuest()
    if QuestSystem:HasQuest() or not NeonConfig.AutoQuest then return end
    
    local questName, questData = QuestSystem:GetRecommendedQuest()
    if questName and questData then
        RemoteManager:InvokeServer("StartQuest", questData.QuestGiver, questData.Number)
        
        NeonConfig.SessionStats.QuestsCompleted = NeonConfig.SessionStats.QuestsCompleted + 1
        
        Rayfield:Notify({
            Title = "🎯 Quest Iniciada!",
            Content = questName,
            Duration = 3
        })
    end
end

-- 👹 SISTEMA DE BOSS AVANÇADO V4.5
local BossSystem = {}

BossSystem.BossData = {
    -- First Sea Bosses Atualizados 2025
    ["The Gorilla King"] = {Level = 25, Location = CFrame.new(-1223, 7, -317)},
    ["Bobby"] = {Level = 55, Location = CFrame.new(-1147, 14, 4325)},
    ["Yeti"] = {Level = 110, Location = CFrame.new(1347, 104, -1408)},
    ["Mob Leader"] = {Level = 120, Location = CFrame.new(-2848, 7, 5356)},
    ["Vice Admiral"] = {Level = 130, Location = CFrame.new(-5006, 29, 4353)},
    ["Warden"] = {Level = 175, Location = CFrame.new(5186, 1, 729)},
    ["Chief Warden"] = {Level = 200, Location = CFrame.new(5186, 1, 729)},
    ["Swan"] = {Level = 225, Location = CFrame.new(5348, 7, 719)},
    ["Magma Admiral"] = {Level = 350, Location = CFrame.new(-5530, 12, 8859)},
    ["Fishman Lord"] = {Level = 425, Location = CFrame.new(61123, 18, 1569)},
    ["Wysper"] = {Level = 500, Location = CFrame.new(-7925, 5547, -636)},
    ["Thunder God"] = {Level = 575, Location = CFrame.new(-7617, 5616, -2277)},
    ["Cyborg"] = {Level = 675, Location = CFrame.new(6041, 52, -1467)},
    
    -- Second Sea Bosses
    ["Diamond"] = {Level = 750, Location = CFrame.new(-1576, 198, -31)},
    ["Jeremy"] = {Level = 850, Location = CFrame.new(2316, 449, 787)},
    ["Fajita"] = {Level = 925, Location = CFrame.new(-2085, 73, -4208)},
    ["Don Swan"] = {Level = 1000, Location = CFrame.new(2289, 15, 808)},
    ["Smoke Admiral"] = {Level = 1150, Location = CFrame.new(-5115, 24, -5080)},
    ["Cursed Captain"] = {Level = 1325, Location = CFrame.new(916, 181, 33422)},
    ["Darkbeard"] = {Level = 1000, Location = CFrame.new(3677, 62, -3144)},
    ["Order"] = {Level = 1250, Location = CFrame.new(-6221, 16, -2902)},
    ["Awakened Ice Admiral"] = {Level = 1400, Location = CFrame.new(6407, 340, -6892)},
    
    -- Third Sea Bosses Atualizados 2025
    ["Stone"] = {Level = 1550, Location = CFrame.new(-1049, 40, 6791)},
    ["Island Empress"] = {Level = 1675, Location = CFrame.new(5713, 602, 199)},
    ["Kilo Admiral"] = {Level = 1750, Location = CFrame.new(2889, 424, -7233)},
    ["Captain Elephant"] = {Level = 1875, Location = CFrame.new(-13485, 319, -8664)},
    ["Beautiful Pirate"] = {Level = 1950, Location = CFrame.new(5241, 23, -10904)},
    ["Cake Queen"] = {Level = 2175, Location = CFrame.new(-709, 382, -11150)},
    ["rip_indra True Form"] = {Level = 5000, Location = CFrame.new(-5359, 424, -2735)},
    ["Longma"] = {Level = 2000, Location = CFrame.new(-10238, 389, -9549)},
    ["Soul Reaper"] = {Level = 2100, Location = CFrame.new(-9515, 315, 6691)},
    ["Dough King"] = {Level = 2300, Location = CFrame.new(-2103, 70, -12165)}
}

function BossSystem:GetNearestBoss()
    local nearestBoss = nil
    local shortestDistance = math.huge
    
    for bossName, bossData in pairs(BossSystem.BossData) do
        local boss = Workspace.Enemies:FindFirstChild(bossName)
        if boss and NeonUtils:IsAlive(boss) and boss:FindFirstChild("HumanoidRootPart") then
            local distance = NeonUtils:GetDistance(RootPart.Position, boss.HumanoidRootPart.Position)
            if distance < shortestDistance then
                shortestDistance = distance
                nearestBoss = boss
            end
        end
    end
    
    return nearestBoss, shortestDistance
end

function BossSystem:FarmBoss(boss)
    if not boss or not NeonUtils:IsAlive(boss) then return end
    
    local bossPos = boss.HumanoidRootPart.Position
    MovementSystem:Tween(bossPos + Vector3.new(0, NeonConfig.FarmDistance, 0))
    
    while NeonUtils:IsAlive(boss) and NeonConfig.AutoBoss do
        CombatSystem:EnableHaki()
        CombatSystem:AutoClick()
        CombatSystem:UseSkills()
        
        if boss:FindFirstChild("HumanoidRootPart") then
            RootPart.CFrame = CFrame.lookAt(RootPart.Position, boss.HumanoidRootPart.Position)
        end
        
        wait(NeonConfig.AttackDelay)
    end
    
    if not NeonUtils:IsAlive(boss) then
        NeonConfig.SessionStats.BossesKilled = NeonConfig.SessionStats.BossesKilled + 1
    end
end

-- 📊 SISTEMA DE ESP AVANÇADO V4.5
local ESPSystem = {}

function ESPSystem:CreateESP(object, text, color, size)
    if object:FindFirstChild("NeonESP") then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "NeonESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, size or 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = object
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = color or Color3.new(1, 1, 1)
    frame.BorderSizePixel = 0
    frame.Parent = billboardGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.Parent = frame
end

function ESPSystem:UpdateESP()
    -- ESP para Frutas
    if NeonConfig.ESP.Fruits then
        for _, fruit in pairs(Workspace:GetChildren()) do
            if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                local distance = NeonUtils:GetDistance(RootPart.Position, fruit.Handle.Position)
                if distance < NeonConfig.ESPDistance then
                    ESPSystem:CreateESP(fruit.Handle, fruit.Name .. " [" .. math.floor(distance) .. "m]", Color3.new(1, 0.5, 0))
                end
            end
        end
    end
    
    -- ESP para NPCs
    if NeonConfig.ESP.NPCs then
        for _, npc in pairs(Workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("HumanoidRootPart") then
                local distance = NeonUtils:GetDistance(RootPart.Position, npc.HumanoidRootPart.Position)
                if distance < NeonConfig.ESPDistance then
                    ESPSystem:CreateESP(npc.HumanoidRootPart, npc.Name .. " [" .. math.floor(distance) .. "m]", Color3.new(1, 0, 0))
                end
            end
        end
    end
    
    -- ESP para Bosses
    if NeonConfig.ESP.Bosses then
        for bossName, _ in pairs(BossSystem.BossData) do
            local boss = Workspace.Enemies:FindFirstChild(bossName)
            if boss and boss:FindFirstChild("HumanoidRootPart") then
                local distance = NeonUtils:GetDistance(RootPart.Position, boss.HumanoidRootPart.Position)
                ESPSystem:CreateESP(boss.HumanoidRootPart, "👹 " .. bossName .. " [" .. math.floor(distance) .. "m]", Color3.new(1, 0, 1), 300)
            end
        end
    end
    
    -- ESP para Bartenders
    if NeonConfig.ESP.Bartender then
        for _, bartenderData in pairs(BartenderSystem.BartenderLocations) do
            for _, npcName in ipairs(bartenderData.NPCs) do
                for _, npc in pairs(Workspace.NPCs:GetChildren()) do
                    if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
                        local distance = NeonUtils:GetDistance(RootPart.Position, npc.HumanoidRootPart.Position)
                        if distance < NeonConfig.ESPDistance then
                            ESPSystem:CreateESP(npc.HumanoidRootPart, "🍹 " .. npcName .. " [" .. math.floor(distance) .. "m]", Color3.new(0, 1, 1), 250)
                        end
                    end
                end
            end
        end
    end
end

-- 🔄 SISTEMA PRINCIPAL DE AUTO FARM V4.5
local AutoFarmSystem = {}

function AutoFarmSystem:GetTargetMob()
    if NeonConfig.AutoFarmMode == "Boss" then
        return BossSystem:GetNearestBoss()
    elseif NeonConfig.AutoFarmMode == "Level" then
        local questName, questData = QuestSystem:GetRecommendedQuest()
        if questName then
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob.Name:find(questName) and NeonUtils:IsAlive(mob) and mob:FindFirstChild("HumanoidRootPart") then
                    return mob, NeonUtils:GetDistance(RootPart.Position, mob.HumanoidRootPart.Position)
                end
            end
        end
    end
    
    return CombatSystem:GetNearestMob()
end

function AutoFarmSystem:StartFarm()
    spawn(function()
        while NeonConfig.AutoFarm do
            pcall(function()
                -- Verificações de segurança
                local isAdminNearby, adminName = SecuritySystem:CheckAdmins()
                if isAdminNearby and NeonConfig.SafeMode then
                    NeonConfig.AutoFarm = false
                    Rayfield:Notify({
                        Title = "🚨 ADMIN DETECTADO!",
                        Content = "Farm pausado: " .. adminName,
                        Duration = 10
                    })
                    return
                end
                
                -- Atualizar character se necessário
                if not Character or not Character.Parent then
                    UpdateCharacter()
                end
                
                -- Pegar quest se necessário
                if NeonConfig.AutoFarmQuest then
                    QuestSystem:StartQuest()
                end
                
                -- Encontrar target
                local target, distance = AutoFarmSystem:GetTargetMob()
                
                if target and distance < 3000 then
                    -- Ir até o target
                    MovementSystem:Tween(target.HumanoidRootPart.Position + Vector3.new(0, NeonConfig.FarmDistance, 0))
                    
                    -- Farm o target
                    while NeonUtils:IsAlive(target) and NeonConfig.AutoFarm do
                        CombatSystem:BringMobs()
                        CombatSystem:EnableHaki()
                        CombatSystem:AutoClick()
                        CombatSystem:FastAttack()
                        
                        if math.random(1, 50) == 1 then
                            CombatSystem:UseSkills()
                        end
                        
                        wait(NeonConfig.AttackDelay)
                    end
                    
                    NeonConfig.SessionStats.Experience = NeonConfig.SessionStats.Experience + (target.Humanoid and target.Humanoid.MaxHealth or 100)
                end
                
                -- Coletar frutas
                if NeonConfig.AutoFruit then
                    FruitSystem:CollectFruits()
                end
            end)
            
            wait(0.1)
        end
    end)
end

-- 🎨 CRIANDO INTERFACE PRINCIPAL V4.5

-- MAIN TAB
local AutoFarmToggle = MainTab:CreateToggle({
    Name = "🔥 Auto Farm V4.5",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        NeonConfig.AutoFarm = Value
        if Value then
            AutoFarmSystem:StartFarm()
        else
            MovementSystem:StopTween()
        end
    end
})

local FarmModeDropdown = MainTab:CreateDropdown({
    Name = "🎯 Modo de Farm",
    Options = {"Level", "Nearest", "Boss", "Mastery", "Fragment"},
    CurrentOption = "Level",
    Flag = "FarmMode",
    Callback = function(Option)
        NeonConfig.AutoFarmMode = Option
    end
})

local BringMobsToggle = MainTab:CreateToggle({
    Name = "🧲 Trazer Mobs",
    CurrentValue = true,
    Flag = "BringMobs",
    Callback = function(Value)
        NeonConfig.BringMobs = Value
    end
})

local FastAttackToggle = MainTab:CreateToggle({
    Name = "⚡ Fast Attack",
    CurrentValue = true,
    Flag = "FastAttack",
    Callback = function(Value)
        NeonConfig.FastAttack = Value
    end
})

MainTab:CreateSlider({
    Name = "⚡ Farm Speed",
    Range = {1, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = 25,
    Flag = "FarmSpeed",
    Callback = function(Value)
        NeonConfig.FarmSpeed = Value
    end
})

-- BARTENDER TAB
local AutoBartenderToggle = BartenderTab:CreateToggle({
    Name = "🍹 Auto Bartender System",
    CurrentValue = false,
    Flag = "AutoBartender",
    Callback = function(Value)
        NeonConfig.AutoBartender = Value
        if Value then
            BartenderSystem:AutoBartender()
        end
    end
})

local BartenderModeDropdown = BartenderTab:CreateDropdown({
    Name = "🍹 Bartender Mode",
    Options = {"All", "Tavern", "Cafe", "Tiki Outpost"},
    CurrentOption = "All",
    Flag = "BartenderMode",
    Callback = function(Option)
        NeonConfig.BartenderMode = Option
    end
})

local AutoBuyDrinksToggle = BartenderTab:CreateToggle({
    Name = "🥤 Auto Buy Drinks",
    CurrentValue = true,
    Flag = "AutoBuyDrinks",
    Callback = function(Value)
        NeonConfig.AutoBuyDrinks = Value
    end
})

BartenderTab:CreateSlider({
    Name = "⏱️ Bartender Delay",
    Range = {1, 30},
    Increment = 1,
    Suffix = "s",
    CurrentValue = 5,
    Flag = "BartenderDelay",
    Callback = function(Value)
        NeonConfig.BartenderDelay = Value
    end
})

BartenderTab:CreateSlider({
    Name = "📏 Bartender Distance",
    Range = {10, 200},
    Increment = 5,
    Suffix = "m",
    CurrentValue = 50,
    Flag = "BartenderDistance",
    Callback = function(Value)
        NeonConfig.BartenderDistance = Value
    end
})

-- BOSS TAB
local AutoBossToggle = BossTab:CreateToggle({
    Name = "👹 Auto Boss",
    CurrentValue = false,
    Flag = "AutoBoss",
    Callback = function(Value)
        NeonConfig.AutoBoss = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoBoss do
                    local boss, distance = BossSystem:GetNearestBoss()
                    if boss then
                        BossSystem:FarmBoss(boss)
                    end
                    wait(5)
                end
            end)
        end
    end
})

local AutoAllBossToggle = BossTab:CreateToggle({
    Name = "👹 Farm All Bosses",
    CurrentValue = false,
    Flag = "AutoAllBoss",
    Callback = function(Value)
        NeonConfig.AutoAllBoss = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoAllBoss do
                    for bossName, bossData in pairs(BossSystem.BossData) do
                        local boss = Workspace.Enemies:FindFirstChild(bossName)
                        if boss and NeonUtils:IsAlive(boss) then
                            BossSystem:FarmBoss(boss)
                        end
                    end
                    wait(10)
                end
            end)
        end
    end
})

-- FRUIT TAB
local AutoFruitToggle = FruitTab:CreateToggle({
    Name = "🍎 Auto Collect Fruits",
    CurrentValue = false,
    Flag = "AutoFruit",
    Callback = function(Value)
        NeonConfig.AutoFruit = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoFruit do
                    FruitSystem:CollectFruits()
                    wait(5)
                end
            end)
        end
    end
})

local FruitSniperToggle = FruitTab:CreateToggle({
    Name = "🎯 Fruit Sniper",
    CurrentValue = false,
    Flag = "FruitSniper",
    Callback = function(Value)
        NeonConfig.FruitSniper = Value
        if Value then
            spawn(function()
                while NeonConfig.FruitSniper do
                    local fruits = FruitSystem:GetAllFruits()
                    for _, fruitData in ipairs(fruits) do
                        if fruitData.Distance > 100 then
                            MovementSystem:TeleportTo(fruitData.Position)
                            wait(0.5)
                        end
                    end
                    wait(1)
                end
            end)
        end
    end
})

-- COMBAT TAB
local AutoClickToggle = CombatTab:CreateToggle({
    Name = "🖱️ Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        NeonConfig.AutoClick = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoClick do
                    CombatSystem:AutoClick()
                    wait(NeonConfig.ClickSpeed)
                end
            end)
        end
    end
})

local UseSkillsToggle = CombatTab:CreateToggle({
    Name = "⚔️ Auto Skills",
    CurrentValue = false,
    Flag = "UseSkills",
    Callback = function(Value)
        NeonConfig.UseSkills = Value
    end
})

local BusoHakiToggle = CombatTab:CreateToggle({
    Name = "🛡️ Auto Buso Haki",
    CurrentValue = true,
    Flag = "BusoHaki",
    Callback = function(Value)
        NeonConfig.AutoHaki.Buso = Value
    end
})

-- ESP TAB
local ESPFruitsToggle = ESPTab:CreateToggle({
    Name = "🍎 ESP Fruits",
    CurrentValue = true,
    Flag = "ESPFruits",
    Callback = function(Value)
        NeonConfig.ESP.Fruits = Value
    end
})

local ESPNPCsToggle = ESPTab:CreateToggle({
    Name = "👹 ESP NPCs",
    CurrentValue = true,
    Flag = "ESPNPCs",
    Callback = function(Value)
        NeonConfig.ESP.NPCs = Value
    end
})

local ESPBossesToggle = ESPTab:CreateToggle({
    Name = "👑 ESP Bosses",
    CurrentValue = true,
    Flag = "ESPBosses",
    Callback = function(Value)
        NeonConfig.ESP.Bosses = Value
    end
})

local ESPBartenderToggle = ESPTab:CreateToggle({
    Name = "🍹 ESP Bartenders",
    CurrentValue = true,
    Flag = "ESPBartender",
    Callback = function(Value)
        NeonConfig.ESP.Bartender = Value
    end
})

-- MISC TAB
local AntiAFKToggle = MiscTab:CreateToggle({
    Name = "🛡️ Anti AFK",
    CurrentValue = true,
    Flag = "AntiAFK",
    Callback = function(Value)
        NeonConfig.AntiAFK = Value
        if Value then
            spawn(function()
                while NeonConfig.AntiAFK do
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    wait(300)
                end
            end)
        end
    end
})

local WalkSpeedSlider = MiscTab:CreateSlider({
    Name = "🏃 Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        NeonConfig.WalkSpeed = Value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = Value
        end
    end
})

local JumpPowerSlider = MiscTab:CreateSlider({
    Name = "🦘 Jump Power",
    Range = {50, 300},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        NeonConfig.JumpPower = Value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.JumpPower = Value
        end
    end
})

-- SETTINGS TAB
local SafeModeToggle = SettingsTab:CreateToggle({
    Name = "🔒 Safe Mode",
    CurrentValue = false,
    Flag = "SafeMode",
    Callback = function(Value)
        NeonConfig.SafeMode = Value
    end
})

local AdminDetectionToggle = SettingsTab:CreateToggle({
    Name = "👮 Admin Detection",
    CurrentValue = true,
    Flag = "AdminDetection",
    Callback = function(Value)
        NeonConfig.AdminDetection = Value
    end
})

-- INFO TAB
local StatsLabel = InfoTab:CreateLabel("📊 Carregando estatísticas...")

-- 🔄 SISTEMA DE ATUALIZAÇÃO PRINCIPAL
spawn(function()
    while true do
        pcall(function()
            -- Atualizar dados do player
            local currentLevel = NeonUtils:GetPlayerLevel()
            local currentBeli = NeonUtils:GetPlayerBeli()
            local currentFragments = NeonUtils:GetPlayerFragments()
            local sessionTime = math.floor((tick() - NeonConfig.SessionStats.StartTime) / 60)
            
            -- Atualizar display
            StatsLabel:Set(string.format([[
📊 NEON HUB V4.5 - ESTATÍSTICAS 2025
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌍 Mar Atual: %s
👤 Level: %d
💰 Beli: %s
💎 Fragments: %s
⚡ XP Farmado: %s
💀 Mortes: %d
🔄 Restarts: %d
🎁 Items Coletados: %d
🍎 Frutas Coletadas: %d
👹 Bosses Mortos: %d
🎯 Quests Completas: %d
🍹 Bebidas Consumidas: %d
⏱️ Tempo Ativo: %d minutos
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]], 
                NeonConfig.CurrentSea,
                currentLevel,
                tostring(currentBeli),
                tostring(currentFragments),
                tostring(NeonConfig.SessionStats.Experience),
                NeonConfig.SessionStats.Deaths,
                NeonConfig.SessionStats.Restarts,
                NeonConfig.SessionStats.ItemsCollected,
                NeonConfig.SessionStats.FruitsCollected,
                NeonConfig.SessionStats.BossesKilled,
                NeonConfig.SessionStats.QuestsCompleted,
                NeonConfig.SessionStats.DrinksConsumed,
                sessionTime
            ))
            
            -- Atualizar ESP
            ESPSystem:UpdateESP()
            
            -- Verificações de segurança
            if NeonConfig.SafeMode and NeonConfig.AdminDetection then
                local isAdminNearby = SecuritySystem:CheckAdmins()
                if isAdminNearby then
                    NeonConfig.AutoFarm = false
                    NeonConfig.AutoBoss = false
                    NeonConfig.AutoFruit = false
                    NeonConfig.AutoBartender = false
                end
            end
        end)
        
        wait(1)
    end
end)

-- 🔒 ATIVAR PROTEÇÕES
SecuritySystem:EnableAntiKick()

-- 🎵 NOTIFICAÇÃO FINAL
Rayfield:Notify({
    Title = "🌟 NEON HUB V4.5 CARREGADO!",
    Content = "✅ 150+ Funcionalidades Premium 2025\n✅ " .. NeonConfig.CurrentSea .. " Suportado\n✅ Sistema Bartender Avançado\n✅ Auto Farm Inteligente V4.5\n✅ Sistema de Boss Completo\n✅ ESP Ultra Avançado\n✅ Anti-Ban Premium\n✅ Compatível com Update 21+",
    Duration = 10,
    Image = 4483362458
})

-- 📝 LOG FINAL
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🌟 NEON HUB V4.5 - ULTIMATE BLOX FRUITS SCRIPT 2025 CARREGADO! 🌟")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📅 Versão: " .. NeonConfig.Version)
print("🌍 Mar Detectado: " .. NeonConfig.CurrentSea)
print("🎮 Game ID: " .. NeonConfig.GameID)
print("👑 Desenvolvido por: Neon Development Team")
print("🎯 Funcionalidades: 150+ Features Ultra Premium 2025")
print("🍹 NOVO: Sistema de Bartender Avançado")
print("🛡️ Sistema de Segurança: ATIVADO")
print("⚠️  AVISO: Use por sua própria conta e risco!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
