--[[
    ███╗   ██╗███████╗ ██████╗ ███╗   ██╗    ██╗  ██╗██╗   ██╗██████╗     ██╗   ██╗███████╗
    ████╗  ██║██╔════╝██╔═══██╗████╗  ██║    ██║  ██║██║   ██║██╔══██╗    ██║   ██║██╔════╝
    ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║    ███████║██║   ██║██████╔╝    ██║   ██║███████╗
    ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║    ██╔══██║██║   ██║██╔══██╗    ╚██╗ ██╔╝╚════██║
    ██║ ╚████║███████╗╚██████╔╝██║ ╚████║    ██║  ██║╚██████╔╝██████╔╝     ╚████╔╝ ███████║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝       ╚═══╝  ╚══════╝

    🌟 NEON HUB V5.0 - ULTIMATE BLOX FRUITS SCRIPT 2025 🌟
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    📅 Versão: 5.0.0 ULTIMATE PREMIUM EDITION 2025
    👑 Desenvolvido por: Neon Development Team 
    🔥 Atualizado: Janeiro 2025 - Sistema de Auto Farm Corrigido
    🎯 Compatível com: Update 21+ do Blox Fruits
    ⚠️  USO POR SUA PRÓPRIA CONTA E RISCO
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]

-- 🔧 VERIFICAÇÃO DE AMBIENTE ROBLOX CORRIGIDA
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = workspace or game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

-- 🎯 VARIÁVEIS GLOBAIS CORRIGIDAS
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Aguardar character spawn com timeout
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)

-- 🌐 DETECÇÃO DE MAR ATUALIZADA 2025
local function GetCurrentSea()
    local placeId = game.PlaceId
    local seaInfo = {
        [2753915549] = {Name = "First Sea", Level = {1, 700}},
        [4442272183] = {Name = "Second Sea", Level = {700, 1500}},
        [7449423635] = {Name = "Third Sea", Level = {1500, 2550}}
    }
    return seaInfo[placeId] or {Name = "Unknown", Level = {1, 100}}
end

local CurrentSeaData = GetCurrentSea()

-- 📊 CONFIGURAÇÕES CORRIGIDAS V5.0
local NeonConfig = {
    Version = "5.0.0",
    CurrentSea = CurrentSeaData.Name,
    SeaLevels = CurrentSeaData.Level,

    -- ⚡ AUTO FARM CORRIGIDO
    AutoFarm = false,
    AutoFarmMode = "Level",
    FarmSpeed = 30,
    AttackDelay = 0.01,
    FarmDistance = 8,
    BringMobs = true,
    FastAttack = true,
    AutoQuest = true,
    AutoRejoinOnDeath = true,
    SafeFarm = true,

    -- 🎯 SISTEMA DE QUEST AVANÇADO
    QuestData = {},
    CurrentQuest = nil,
    QuestCompleted = 0,

    -- ⚔️ SISTEMA DE COMBATE
    AutoClick = false,
    UseSkills = false,
    AutoHaki = true,
    SkillRotation = {"Z", "X", "C", "V"},

    -- 🍎 DEVIL FRUIT
    AutoFruit = false,
    FruitNotification = true,

    -- 👹 BOSS SYSTEM
    AutoBoss = false,
    SelectedBoss = "All",

    -- 🛡️ SEGURANÇA
    AntiKick = true,
    AntiAFK = true,
    SafeMode = false,

    -- 📊 ESTATÍSTICAS
    SessionStats = {
        StartTime = tick(),
        Experience = 0,
        Beli = 0,
        Level = 0,
        Deaths = 0,
        QuestsCompleted = 0,
        TimeActive = 0
    }
}

-- 🔧 FUNÇÕES UTILITÁRIAS AVANÇADAS
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("🚨 Erro capturado:", result)
    end
    return success, result
end

local function GetDistance(pos1, pos2)
    if not pos1 or not pos2 then return math.huge end
    return (Vector3.new(pos1.X, pos1.Y, pos1.Z) - Vector3.new(pos2.X, pos2.Y, pos2.Z)).Magnitude
end

local function IsAlive(target)
    return target and target.Parent and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0
end

local function UpdateCharacterReferences()
    if Player.Character then
        Character = Player.Character
        Humanoid = Character:FindFirstChild("Humanoid")
        RootPart = Character:FindFirstChild("HumanoidRootPart")
        return true
    end
    return false
end

-- 📡 SISTEMA DE REMOTES CORRIGIDO
local function GetRemote()
    local remote = nil
    SafeCall(function()
        if ReplicatedStorage:FindFirstChild("Remotes") then
            remote = ReplicatedStorage.Remotes:FindFirstChild("CommF_")
        end
    end)
    return remote
end

local function FireRemote(...)
    local remote = GetRemote()
    if remote then
        SafeCall(function()
            remote:InvokeServer(...)
        end)
    end
end

-- 🎯 SISTEMA DE QUEST ATUALIZADO 2025
local QuestSystem = {
    QuestData = {
        -- First Sea Atualizado
        ["Bandit"] = {Level = {1, 9}, QuestGiver = "Bandit Quest", Number = 1, Map = "Starter Island"},
        ["Monkey"] = {Level = {10, 14}, QuestGiver = "Monkey Quest", Number = 1, Map = "Jungle"},
        ["Gorilla"] = {Level = {15, 19}, QuestGiver = "Gorilla Quest", Number = 2, Map = "Jungle"},
        ["Pirate"] = {Level = {20, 29}, QuestGiver = "Pirate Quest", Number = 1, Map = "Pirate Village"},
        ["Brute"] = {Level = {30, 39}, QuestGiver = "Brute Quest", Number = 2, Map = "Pirate Village"},
        ["Desert Bandit"] = {Level = {40, 59}, QuestGiver = "Desert Quest", Number = 1, Map = "Desert"},
        ["Desert Officer"] = {Level = {60, 74}, QuestGiver = "Desert Quest", Number = 2, Map = "Desert"},
        ["Snow Bandit"] = {Level = {75, 89}, QuestGiver = "Snow Quest", Number = 1, Map = "Snow Island"},
        ["Snowman"] = {Level = {90, 99}, QuestGiver = "Snow Quest", Number = 2, Map = "Snow Island"},
        ["Chief Petty Officer"] = {Level = {100, 119}, QuestGiver = "Marine Quest", Number = 1, Map = "Marine Base"},
        ["Sky Bandit"] = {Level = {120, 149}, QuestGiver = "Sky Quest", Number = 1, Map = "Skypiea"},
        ["Dark Master"] = {Level = {150, 174}, QuestGiver = "Sky Quest", Number = 2, Map = "Skypiea"},
        ["Prisoner"] = {Level = {175, 189}, QuestGiver = "Prison Quest", Number = 1, Map = "Prison"},
        ["Dangerous Prisoner"] = {Level = {190, 249}, QuestGiver = "Prison Quest", Number = 2, Map = "Prison"},
        ["Toga Warrior"] = {Level = {250, 274}, QuestGiver = "Colosseum Quest", Number = 1, Map = "Colosseum"},
        ["Gladiator"] = {Level = {275, 299}, QuestGiver = "Colosseum Quest", Number = 2, Map = "Colosseum"},
        ["Military Soldier"] = {Level = {300, 324}, QuestGiver = "Magma Quest", Number = 1, Map = "Magma Village"},
        ["Military Spy"] = {Level = {325, 374}, QuestGiver = "Magma Quest", Number = 2, Map = "Magma Village"},
        ["Fishman Warrior"] = {Level = {375, 399}, QuestGiver = "Fishman Quest", Number = 1, Map = "Underwater City"},
        ["Fishman Commando"] = {Level = {400, 449}, QuestGiver = "Fishman Quest", Number = 2, Map = "Underwater City"},
        ["God's Guard"] = {Level = {450, 474}, QuestGiver = "Sky Quest", Number = 1, Map = "Skypiea"},
        ["Shanda"] = {Level = {475, 524}, QuestGiver = "Sky Quest", Number = 2, Map = "Skypiea"},
        ["Royal Squad"] = {Level = {525, 549}, QuestGiver = "Sky Quest", Number = 1, Map = "Skypiea"},
        ["Royal Soldier"] = {Level = {550, 624}, QuestGiver = "Sky Quest", Number = 2, Map = "Skypiea"},
        ["Galley Pirate"] = {Level = {625, 649}, QuestGiver = "Fountain Quest", Number = 1, Map = "Fountain City"},
        ["Galley Captain"] = {Level = {650, 699}, QuestGiver = "Fountain Quest", Number = 2, Map = "Fountain City"},

        -- Second Sea
        ["Raider"] = {Level = {700, 724}, QuestGiver = "Area1Quest", Number = 1, Map = "Kingdom of Rose"},
        ["Mercenary"] = {Level = {725, 774}, QuestGiver = "Area1Quest", Number = 2, Map = "Kingdom of Rose"},
        ["Swan Pirate"] = {Level = {775, 849}, QuestGiver = "Area2Quest", Number = 1, Map = "Cafe"},
        ["Factory Staff"] = {Level = {850, 899}, QuestGiver = "Area2Quest", Number = 2, Map = "Cafe"},
        ["Marine Lieutenant"] = {Level = {900, 949}, QuestGiver = "MarineQuest3", Number = 1, Map = "Marine Base G-2"},
        ["Marine Captain"] = {Level = {950, 974}, QuestGiver = "MarineQuest3", Number = 2, Map = "Marine Base G-2"},
        ["Zombie"] = {Level = {975, 999}, QuestGiver = "ZombieQuest", Number = 1, Map = "Graveyard Island"},
        ["Vampire"] = {Level = {1000, 1049}, QuestGiver = "ZombieQuest", Number = 2, Map = "Graveyard Island"},
        ["Snow Trooper"] = {Level = {1050, 1099}, QuestGiver = "SnowMountainQuest", Number = 1, Map = "Snow Mountain"},
        ["Winter Warrior"] = {Level = {1100, 1124}, QuestGiver = "SnowMountainQuest", Number = 2, Map = "Snow Mountain"},
        ["Lab Subordinate"] = {Level = {1125, 1174}, QuestGiver = "IceSideQuest", Number = 1, Map = "Ice Castle"},
        ["Horned Warrior"] = {Level = {1175, 1199}, QuestGiver = "IceSideQuest", Number = 2, Map = "Ice Castle"},
        ["Magma Ninja"] = {Level = {1200, 1249}, QuestGiver = "FireSideQuest", Number = 1, Map = "Fire Stock"},
        ["Lava Pirate"] = {Level = {1250, 1274}, QuestGiver = "FireSideQuest", Number = 2, Map = "Fire Stock"},
        ["Ship Deckhand"] = {Level = {1275, 1299}, QuestGiver = "ShipQuest1", Number = 1, Map = "Ship"},
        ["Ship Engineer"] = {Level = {1300, 1324}, QuestGiver = "ShipQuest1", Number = 2, Map = "Ship"},
        ["Ship Steward"] = {Level = {1325, 1349}, QuestGiver = "ShipQuest2", Number = 1, Map = "Ship"},
        ["Ship Officer"] = {Level = {1350, 1374}, QuestGiver = "ShipQuest2", Number = 2, Map = "Ship"},
        ["Arctic Warrior"] = {Level = {1375, 1424}, QuestGiver = "FrostQuest", Number = 1, Map = "Frost"},
        ["Snow Lurker"] = {Level = {1425, 1449}, QuestGiver = "FrostQuest", Number = 2, Map = "Frost"},
        ["Sea Soldier"] = {Level = {1450, 1499}, QuestGiver = "ForgottenQuest", Number = 1, Map = "Forgotten Island"},

        -- Third Sea
        ["Pirate Millionaire"] = {Level = {1500, 1524}, QuestGiver = "PiratePortQuest", Number = 1, Map = "Port Town"},
        ["Dragon Crew Warrior"] = {Level = {1525, 1574}, QuestGiver = "PiratePortQuest", Number = 2, Map = "Port Town"},
        ["Dragon Crew Archer"] = {Level = {1575, 1599}, QuestGiver = "PiratePortQuest", Number = 3, Map = "Port Town"},
        ["Female Islander"] = {Level = {1600, 1624}, QuestGiver = "AmazonQuest", Number = 1, Map = "Amazon"},
        ["Giant Islander"] = {Level = {1625, 1649}, QuestGiver = "AmazonQuest", Number = 2, Map = "Amazon"},
        ["Marine Commodore"] = {Level = {1650, 1699}, QuestGiver = "MarineTreeIsland", Number = 1, Map = "Marine Base G-5"},
        ["Marine Rear Admiral"] = {Level = {1700, 1724}, QuestGiver = "MarineTreeIsland", Number = 2, Map = "Marine Base G-5"},
        ["Fishman Raider"] = {Level = {1725, 1774}, QuestGiver = "DeepForestIsland3", Number = 1, Map = "Deep Forest"},
        ["Fishman Captain"] = {Level = {1775, 1799}, QuestGiver = "DeepForestIsland3", Number = 2, Map = "Deep Forest"},
        ["Forest Pirate"] = {Level = {1800, 1849}, QuestGiver = "DeepForestIsland", Number = 1, Map = "Deep Forest"},
        ["Mythological Pirate"] = {Level = {1850, 1899}, QuestGiver = "DeepForestIsland", Number = 2, Map = "Deep Forest"},
        ["Jungle Pirate"] = {Level = {1900, 1924}, QuestGiver = "DeepForestIsland2", Number = 1, Map = "Deep Forest"},
        ["Musketeer Pirate"] = {Level = {1925, 1974}, QuestGiver = "DeepForestIsland2", Number = 2, Map = "Deep Forest"},
        ["Reborn Skeleton"] = {Level = {1975, 1999}, QuestGiver = "HauntedQuest1", Number = 1, Map = "Haunted Castle"},
        ["Living Zombie"] = {Level = {2000, 2024}, QuestGiver = "HauntedQuest1", Number = 2, Map = "Haunted Castle"},
        ["Demonic Soul"] = {Level = {2025, 2049}, QuestGiver = "HauntedQuest2", Number = 1, Map = "Haunted Castle"},
        ["Posessed Mummy"] = {Level = {2050, 2074}, QuestGiver = "HauntedQuest2", Number = 2, Map = "Haunted Castle"},
        ["Peanut Scout"] = {Level = {2075, 2099}, QuestGiver = "NutsIslandQuest", Number = 1, Map = "Nut Island"},
        ["Peanut President"] = {Level = {2100, 2124}, QuestGiver = "NutsIslandQuest", Number = 2, Map = "Nut Island"},
        ["Ice Cream Chef"] = {Level = {2125, 2149}, QuestGiver = "IceCreamIslandQuest", Number = 1, Map = "Ice Cream Island"},
        ["Ice Cream Commander"] = {Level = {2150, 2199}, QuestGiver = "IceCreamIslandQuest", Number = 2, Map = "Ice Cream Island"},
        ["Cookie Crafter"] = {Level = {2200, 2224}, QuestGiver = "CakeQuest1", Number = 1, Map = "Cake Island"},
        ["Cake Guard"] = {Level = {2225, 2249}, QuestGiver = "CakeQuest1", Number = 2, Map = "Cake Island"},
        ["Baking Staff"] = {Level = {2250, 2274}, QuestGiver = "CakeQuest2", Number = 1, Map = "Cake Island"},
        ["Head Baker"] = {Level = {2275, 2299}, QuestGiver = "CakeQuest2", Number = 2, Map = "Cake Island"},
        ["Cocoa Warrior"] = {Level = {2300, 2324}, QuestGiver = "ChocQuest1", Number = 1, Map = "Chocolate Island"},
        ["Chocolate Bar Battler"] = {Level = {2325, 2349}, QuestGiver = "ChocQuest1", Number = 2, Map = "Chocolate Island"},
        ["Sweet Thief"] = {Level = {2350, 2374}, QuestGiver = "ChocQuest2", Number = 1, Map = "Chocolate Island"},
        ["Candy Rebel"] = {Level = {2375, 2399}, QuestGiver = "ChocQuest2", Number = 2, Map = "Chocolate Island"},
        ["Candy Pirate"] = {Level = {2400, 2424}, QuestGiver = "CandyQuest1", Number = 1, Map = "Candy Island"},
        ["Snow Demon"] = {Level = {2425, 2449}, QuestGiver = "CandyQuest1", Number = 2, Map = "Candy Island"},
        ["Isle Outlaw"] = {Level = {2450, 2474}, QuestGiver = "TikiQuest1", Number = 1, Map = "Tiki Outpost"},
        ["Island Boy"] = {Level = {2475, 2499}, QuestGiver = "TikiQuest1", Number = 2, Map = "Tiki Outpost"},
        ["Sun-kissed Warrior"] = {Level = {2500, 2524}, QuestGiver = "TikiQuest2", Number = 1, Map = "Tiki Outpost"},
        ["Isle Champion"] = {Level = {2525, 2550}, QuestGiver = "TikiQuest2", Number = 2, Map = "Tiki Outpost"}
    }
}

function QuestSystem:GetPlayerLevel()
    local success, level = SafeCall(function()
        return Player.Data.Level.Value
    end)
    return success and level or 1
end

function QuestSystem:GetCurrentQuest()
    local success, quest = SafeCall(function()
        local questGui = PlayerGui:FindFirstChild("Main")
        if questGui and questGui:FindFirstChild("Quest") then
            local questContainer = questGui.Quest:FindFirstChild("Container")
            if questContainer and questContainer:FindFirstChild("QuestTitle") then
                return questContainer.QuestTitle:FindFirstChild("Title") and questContainer.QuestTitle.Title.Text or ""
            end
        end
        return ""
    end)
    return success and quest or ""
end

function QuestSystem:HasQuest()
    local quest = self:GetCurrentQuest()
    return quest and quest ~= ""
end

function QuestSystem:GetRecommendedQuest()
    local level = self:GetPlayerLevel()

    for questName, questData in pairs(self.QuestData) do
        if level >= questData.Level[1] and level <= questData.Level[2] then
            return questName, questData
        end
    end

    -- Se não encontrar quest específica, pegar a mais próxima
    for questName, questData in pairs(self.QuestData) do
        if level >= questData.Level[1] then
            return questName, questData
        end
    end

    return nil, nil
end

function QuestSystem:StartQuest()
    if self:HasQuest() then return true end

    local questName, questData = self:GetRecommendedQuest()
    if questName and questData then
        FireRemote("StartQuest", questData.QuestGiver, questData.Number)
        wait(1)

        if self:HasQuest() then
            NeonConfig.CurrentQuest = questName
            NeonConfig.SessionStats.QuestsCompleted = NeonConfig.SessionStats.QuestsCompleted + 1
            print("✅ Quest iniciada:", questName)
            return true
        end
    end

    return false
end

-- ⚔️ SISTEMA DE COMBATE CORRIGIDO
local CombatSystem = {}

function CombatSystem:GetNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge

    SafeCall(function()
        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
            if IsAlive(enemy) and enemy:FindFirstChild("HumanoidRootPart") then
                -- Verificar se é o inimigo da quest atual
                if NeonConfig.CurrentQuest and enemy.Name:find(NeonConfig.CurrentQuest) then
                    local distance = GetDistance(RootPart.Position, enemy.HumanoidRootPart.Position)
                    if distance < shortestDistance and distance < 2500 then
                        shortestDistance = distance
                        nearestEnemy = enemy
                    end
                end
            end
        end

        -- Se não encontrar inimigo da quest, pegar qualquer um próximo
        if not nearestEnemy then
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if IsAlive(enemy) and enemy:FindFirstChild("HumanoidRootPart") then
                    local distance = GetDistance(RootPart.Position, enemy.HumanoidRootPart.Position)
                    if distance < shortestDistance and distance < 1000 then
                        shortestDistance = distance
                        nearestEnemy = enemy
                    end
                end
            end
        end
    end)

    return nearestEnemy, shortestDistance
end

function CombatSystem:BringMobs()
    if not NeonConfig.BringMobs or not RootPart then return end

    SafeCall(function()
        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
            if IsAlive(enemy) and enemy:FindFirstChild("HumanoidRootPart") then
                local distance = GetDistance(RootPart.Position, enemy.HumanoidRootPart.Position)
                if distance < 350 then
                    enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    enemy.HumanoidRootPart.Transparency = 1
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, NeonConfig.FarmDistance)

                    if enemy:FindFirstChild("Humanoid") then
                        enemy.Humanoid.WalkSpeed = 0
                        enemy.Humanoid.JumpPower = 0
                    end
                end
            end
        end
    end)
end

function CombatSystem:EnableHaki()
    if NeonConfig.AutoHaki then
        SafeCall(function()
            FireRemote("Buso")
        end)
    end
end

function CombatSystem:Attack()
    if NeonConfig.AutoClick then
        SafeCall(function()
            FireRemote("TAP")
        end)
    end
end

function CombatSystem:UseSkills()
    if not NeonConfig.UseSkills then return end

    SafeCall(function()
        for _, skill in ipairs(NeonConfig.SkillRotation) do
            VirtualInputManager:SendKeyEvent(true, skill, false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, skill, false, game)
            wait(0.5)
        end
    end)
end

function CombatSystem:FastAttack()
    if not NeonConfig.FastAttack then return end

    SafeCall(function()
        local CombatFramework = debug.getupvalues(require(Player.PlayerScripts.CombatFramework))
        local CombatFrameworkR = CombatFramework[2]

        if CombatFrameworkR then
            local RigController = debug.getupvalues(CombatFrameworkR.activeController)
            if RigController then
                RigController.timeToNextAttack = function() return 0 end
                RigController.focusStart = function() return true end
                RigController.hitboxMagnitude = function() return 100 end
            end
        end
    end)
end

-- 🚀 SISTEMA DE MOVIMENTAÇÃO CORRIGIDO
local MovementSystem = {}

function MovementSystem:TeleportTo(position)
    if not position or not RootPart then return end

    SafeCall(function()
        RootPart.CFrame = CFrame.new(position)
    end)
end

function MovementSystem:TweenTo(position, speed)
    if not position or not RootPart then return end

    speed = speed or NeonConfig.FarmSpeed
    local distance = GetDistance(RootPart.Position, position)
    local tweenTime = distance / speed

    SafeCall(function()
        local tween = TweenService:Create(RootPart, TweenInfo.new(
            tweenTime,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.InOut
        ), {CFrame = CFrame.new(position)})

        tween:Play()
        return tween
    end)
end

function MovementSystem:StopTween()
    SafeCall(function()
        RootPart.Anchored = true
        wait(0.1)
        RootPart.Anchored = false
    end)
end

-- 🎯 SISTEMA DE AUTO FARM PRINCIPAL V5.0
local AutoFarmSystem = {}

AutoFarmSystem.Running = false

function AutoFarmSystem:Start()
    if self.Running then return end
    self.Running = true

    spawn(function()
        while NeonConfig.AutoFarm and self.Running do
            SafeCall(function()
                -- Atualizar referências do character
                if not UpdateCharacterReferences() then
                    wait(2)
                    return
                end

                -- Iniciar quest se necessário
                if NeonConfig.AutoQuest and not QuestSystem:HasQuest() then
                    QuestSystem:StartQuest()
                    wait(2)
                end

                -- Encontrar inimigo
                local enemy, distance = CombatSystem:GetNearestEnemy()

                if enemy and distance < 2000 then
                    -- Ir até o inimigo
                    local enemyPos = enemy.HumanoidRootPart.Position
                    local farmPos = enemyPos + Vector3.new(0, NeonConfig.FarmDistance, 0)

                    if distance > 20 then
                        MovementSystem:TweenTo(farmPos, NeonConfig.FarmSpeed)
                        wait(distance / NeonConfig.FarmSpeed)
                    end

                    -- Loop de ataque
                    local attackStartTime = tick()
                    while IsAlive(enemy) and NeonConfig.AutoFarm and (tick() - attackStartTime) < 30 do
                        if not UpdateCharacterReferences() then break end

                        -- Manter posição
                        if GetDistance(RootPart.Position, farmPos) > 10 then
                            MovementSystem:TeleportTo(farmPos)
                        end

                        -- Trazer mobs
                        CombatSystem:BringMobs()

                        -- Combate
                        CombatSystem:EnableHaki()
                        CombatSystem:Attack()
                        CombatSystem:FastAttack()

                        -- Olhar para o inimigo
                        if enemy:FindFirstChild("HumanoidRootPart") then
                            RootPart.CFrame = CFrame.lookAt(RootPart.Position, enemy.HumanoidRootPart.Position)
                        end

                        -- Skills ocasionalmente
                        if math.random(1, 100) <= 5 then
                            CombatSystem:UseSkills()
                        end

                        wait(NeonConfig.AttackDelay)
                    end

                    -- Atualizar XP
                    if not IsAlive(enemy) then
                        NeonConfig.SessionStats.Experience = NeonConfig.SessionStats.Experience + 50
                    end

                else
                    -- Não há inimigos próximos, procurar
                    print("🔍 Procurando inimigos...")
                    wait(3)
                end
            end)

            wait(0.5)
        end

        self.Running = false
    end)
end

function AutoFarmSystem:Stop()
    self.Running = false
    MovementSystem:StopTween()
end

-- 🍎 SISTEMA DE DEVIL FRUIT
local FruitSystem = {}

function FruitSystem:GetNearestFruit()
    local nearestFruit = nil
    local shortestDistance = math.huge

    SafeCall(function()
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj.Name:find("Fruit") and obj:FindFirstChild("Handle") then
                local distance = GetDistance(RootPart.Position, obj.Handle.Position)
                if distance < shortestDistance and distance < 5000 then
                    shortestDistance = distance
                    nearestFruit = obj
                end
            end
        end
    end)

    return nearestFruit, shortestDistance
end

function FruitSystem:CollectFruits()
    if not NeonConfig.AutoFruit then return end

    spawn(function()
        while NeonConfig.AutoFruit do
            local fruit, distance = self:GetNearestFruit()

            if fruit and distance < 1000 then
                MovementSystem:TeleportTo(fruit.Handle.Position)
                wait(1)

                if NeonConfig.FruitNotification then
                    print("🍎 Fruta coletada:", fruit.Name)
                end
            end

            wait(5)
        end
    end)
end

-- 🛡️ SISTEMA DE SEGURANÇA
local SecuritySystem = {}

function SecuritySystem:EnableAntiKick()
    if NeonConfig.AntiKick then
        SafeCall(function()
            local mt = getrawmetatable(game)
            local namecall = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return namecall(...)
            end)
        end)
    end
end

function SecuritySystem:EnableAntiAFK()
    if NeonConfig.AntiAFK then
        spawn(function()
            while NeonConfig.AntiAFK do
                SafeCall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                wait(180) -- 3 minutos
            end
        end)
    end
end

-- 📊 SISTEMA DE ESTATÍSTICAS
local StatsSystem = {}

function StatsSystem:UpdateStats()
    spawn(function()
        while true do
            SafeCall(function()
                local currentLevel = QuestSystem:GetPlayerLevel()
                local sessionTime = math.floor((tick() - NeonConfig.SessionStats.StartTime) / 60)

                NeonConfig.SessionStats.Level = currentLevel
                NeonConfig.SessionStats.TimeActive = sessionTime

                -- Log de estatísticas a cada 5 minutos
                if sessionTime % 5 == 0 and sessionTime > 0 then
                    print(string.format([[
🌟 NEON HUB V5.0 - ESTATÍSTICAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌍 Mar: %s
👤 Level: %d
⚡ XP Farmado: %d
🎯 Quests: %d
⏱️ Tempo: %d min
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]], 
                        NeonConfig.CurrentSea,
                        currentlevel,
                        NeonConfig.SessionStats.Experience,
                        NeonConfig.SessionStats.QuestsCompleted,
                        sessionTime
                    ))
                end
            end)

            wait(60) -- Atualizar a cada minuto
        end
    end)
end

-- 🎮 SISTEMA DE UI SIMPLES
local function CreateSimpleUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NeonHubV5"
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    Title.Text = "🌟 NEON HUB V5.0"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Auto Farm Toggle
    local AutoFarmButton = Instance.new("TextButton")
    AutoFarmButton.Name = "AutoFarmButton"
    AutoFarmButton.Size = UDim2.new(0.9, 0, 0, 40)
    AutoFarmButton.Position = UDim2.new(0.05, 0, 0, 40)
    AutoFarmButton.BackgroundColor3 = NeonConfig.AutoFarm and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    AutoFarmButton.Text = "🔥 Auto Farm: " .. (NeonConfig.AutoFarm and "ON" or "OFF")
    AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
    AutoFarmButton.TextScaled = true
    AutoFarmButton.Font = Enum.Font.Gotham
    AutoFarmButton.Parent = MainFrame

    AutoFarmButton.MouseButton1Click:Connect(function()
        NeonConfig.AutoFarm = not NeonConfig.AutoFarm
        AutoFarmButton.BackgroundColor3 = NeonConfig.AutoFarm and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        AutoFarmButton.Text = "🔥 Auto Farm: " .. (NeonConfig.AutoFarm and "ON" or "OFF")

        if NeonConfig.AutoFarm then
            AutoFarmSystem:Start()
        else
            AutoFarmSystem:Stop()
        end
    end)

    -- Auto Quest Toggle
    local AutoQuestButton = Instance.new("TextButton")
    AutoQuestButton.Name = "AutoQuestButton"
    AutoQuestButton.Size = UDim2.new(0.9, 0, 0, 40)
    AutoQuestButton.Position = UDim2.new(0.05, 0, 0, 90)
    AutoQuestButton.BackgroundColor3 = NeonConfig.AutoQuest and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    AutoQuestButton.Text = "🎯 Auto Quest: " .. (NeonConfig.AutoQuest and "ON" or "OFF")
    AutoQuestButton.TextColor3 = Color3.new(1, 1, 1)
    AutoQuestButton.TextScaled = true
    AutoQuestButton.Font = Enum.Font.Gotham
    AutoQuestButton.Parent = MainFrame

    AutoQuestButton.MouseButton1Click:Connect(function()
        NeonConfig.AutoQuest = not NeonConfig.AutoQuest
        AutoQuestButton.BackgroundColor3 = NeonConfig.AutoQuest and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        AutoQuestButton.Text = "🎯 Auto Quest: " .. (NeonConfig.AutoQuest and "ON" or "OFF")
    end)

    -- Auto Fruit Toggle
    local AutoFruitButton = Instance.new("TextButton")
    AutoFruitButton.Name = "AutoFruitButton"
    AutoFruitButton.Size = UDim2.new(0.9, 0, 0, 40)
    AutoFruitButton.Position = UDim2.new(0.05, 0, 0, 140)
    AutoFruitButton.BackgroundColor3 = NeonConfig.AutoFruit and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    AutoFruitButton.Text = "🍎 Auto Fruit: " .. (NeonConfig.AutoFruit and "ON" or "OFF")
    AutoFruitButton.TextColor3 = Color3.new(1, 1, 1)
    AutoFruitButton.TextScaled = true
    AutoFruitButton.Font = Enum.Font.Gotham
    AutoFruitButton.Parent = MainFrame

    AutoFruitButton.MouseButton1Click:Connect(function()
        NeonConfig.AutoFruit = not NeonConfig.AutoFruit
        AutoFruitButton.BackgroundColor3 = NeonConfig.AutoFruit and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        AutoFruitButton.Text = "🍎 Auto Fruit: " .. (NeonConfig.AutoFruit and "ON" or "OFF")

        if NeonConfig.AutoFruit then
            FruitSystem:CollectFruits()
        end
    end)

    -- Bring Mobs Toggle
    local BringMobsButton = Instance.new("TextButton")
    BringMobsButton.Name = "BringMobsButton"
    BringMobsButton.Size = UDim2.new(0.9, 0, 0, 40)
    BringMobsButton.Position = UDim2.new(0.05, 0, 0, 190)
    BringMobsButton.BackgroundColor3 = NeonConfig.BringMobs and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    BringMobsButton.Text = "🧲 Bring Mobs: " .. (NeonConfig.BringMobs and "ON" or "OFF")
    BringMobsButton.TextColor3 = Color3.new(1, 1, 1)
    BringMobsButton.TextScaled = true
    BringMobsButton.Font = Enum.Font.Gotham
    BringMobsButton.Parent = MainFrame

    BringMobsButton.MouseButton1Click:Connect(function()
        NeonConfig.BringMobs = not NeonConfig.BringMobs
        BringMobsButton.BackgroundColor3 = NeonConfig.BringMobs and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        BringMobsButton.Text = "🧲 Bring Mobs: " .. (NeonConfig.BringMobs and "ON" or "OFF")
    end)

    -- Fast Attack Toggle
    local FastAttackButton = Instance.new("TextButton")
    FastAttackButton.Name = "FastAttackButton"
    FastAttackButton.Size = UDim2.new(0.9, 0, 0, 40)
    FastAttackButton.Position = UDim2.new(0.05, 0, 0, 240)
    FastAttackButton.BackgroundColor3 = NeonConfig.FastAttack and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    FastAttackButton.Text = "⚡ Fast Attack: " .. (NeonConfig.FastAttack and "ON" or "OFF")
    FastAttackButton.TextColor3 = Color3.new(1, 1, 1)
    FastAttackButton.TextScaled = true
    FastAttackButton.Font = Enum.Font.Gotham
    FastAttackButton.Parent = MainFrame

    FastAttackButton.MouseButton1Click:Connect(function()
        NeonConfig.FastAttack = not NeonConfig.FastAttack
        FastAttackButton.BackgroundColor3 = NeonConfig.FastAttack and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        FastAttackButton.Text = "⚡ Fast Attack: " .. (NeonConfig.FastAttack and "ON" or "OFF")
    end)

    -- Status Label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(0.9, 0, 0, 80)
    StatusLabel.Position = UDim2.new(0.05, 0, 0, 290)
    StatusLabel.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    StatusLabel.Text = "📊 Carregando..."
    StatusLabel.TextColor3 = Color3.new(1, 1, 1)
    StatusLabel.TextScaled = true
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Parent = MainFrame

    -- Atualizar status
    spawn(function()
        while ScreenGui.Parent do
            SafeCall(function()
                local level = QuestSystem:GetPlayerLevel()
                local sessionTime = math.floor((tick() - NeonConfig.SessionStats.StartTime) / 60)

                StatusLabel.Text = string.format([[📊 Level: %d
🌍 Mar: %s
⏱️ Tempo: %d min
🎯 Quest: %s]], 
                    level,
                    NeonConfig.CurrentSea,
                    sessionTime,
                    NeonConfig.CurrentQuest or "Nenhuma"
                )
            end)
            wait(1)
        end
    end)

    return ScreenGui
end

-- 🚀 INICIALIZAÇÃO DO SISTEMA
local function Initialize()
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🌟 NEON HUB V5.0 - INICIALIZANDO SISTEMA DE AUTO FARM CORRIGIDO")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📅 Versão: " .. NeonConfig.Version)
    print("🌍 Mar Atual: " .. NeonConfig.CurrentSea)
    print("🎯 Níveis Suportados: " .. NeonConfig.SeaLevels[1] .. " - " .. NeonConfig.SeaLevels[2])
    print("👤 Level Atual: " .. QuestSystem:GetPlayerLevel())

    -- Ativar sistemas de segurança
    SecuritySystem:EnableAntiKick()
    SecuritySystem:EnableAntiAFK()

    -- Iniciar sistema de estatísticas
    StatsSystem:UpdateStats()

    -- Criar interface
    CreateSimpleUI()

    -- Reconectar eventos do character
    Player.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        Humanoid = Character:WaitForChild("Humanoid", 10)
        RootPart = Character:WaitForChild("HumanoidRootPart", 10)

        print("🔄 Character recarregado - Referências atualizadas")

        -- Reiniciar auto farm se estava ativo
        if NeonConfig.AutoFarm then
            wait(3)
            AutoFarmSystem:Start()
        end
    end)

    print("✅ NEON HUB V5.0 CARREGADO COM SUCESSO!")
    print("🚀 Sistema de Auto Farm Avançado Ativado")
    print("🛡️ Sistemas de Segurança: ATIVO")
    print("⚠️  AVISO: Use por sua própria conta e risco!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- Inicializar o sistema
Initialize()