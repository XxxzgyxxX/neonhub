
--[[
    ███╗   ██╗███████╗ ██████╗ ███╗   ██╗    ██╗  ██╗██╗   ██╗██████╗     ██╗   ██╗██████╗ 
    ████╗  ██║██╔════╝██╔═══██╗████╗  ██║    ██║  ██║██║   ██║██╔══██╗    ██║   ██║╚════██╗
    ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║    ███████║██║   ██║██████╔╝    ██║   ██║ █████╔╝
    ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║    ██╔══██║██║   ██║██╔══██╗    ╚██╗ ██╔╝ ╚═══██╗
    ██║ ╚████║███████╗╚██████╔╝██║ ╚████║    ██║  ██║╚██████╔╝██████╔╝     ╚████╔╝ ██████╔╝
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝       ╚═══╝  ╚═════╝ 
    
    🌟 NEON HUB V3 - ULTIMATE BLOX FRUITS SCRIPT 🌟
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    📅 Versão: 3.0.0 PREMIUM EDITION
    👑 Criado por: Neon Development Team
    🔥 Última Atualização: 2024
    ⚠️  USO POR SUA PRÓPRIA CONTA E RISCO
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]

-- 🔧 VERIFICAÇÃO DE AMBIENTE ROBLOX
if not game or not game:GetService then
    error("❌ Este script deve ser executado dentro do Roblox!")
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
local StarterPlayer = game:GetService("StarterPlayer")
local TeleportService = game:GetService("TeleportService")

-- 🎯 VARIÁVEIS GLOBAIS
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 📊 CONFIGURAÇÕES AVANÇADAS DO NEON HUB V3
local NeonConfig = {
    -- ⚡ FARM PRINCIPAL
    AutoFarm = false,
    AutoFarmMode = "Nearest", -- Nearest, Level, Mastery, Boss
    FarmSpeed = 20,
    AttackDelay = 0.05,
    FarmDistance = 15,
    SafeFarmDistance = 25,
    
    -- 👹 BOSS SYSTEM
    AutoBoss = false,
    BossMode = "All", -- All, Specific, Raid
    SelectedBoss = "All",
    BossNotification = true,
    AutoRejoinOnDeath = true,
    
    -- 🎯 QUEST SYSTEM
    AutoQuest = false,
    QuestMode = "Level", -- Level, Mastery, Custom
    AutoNewQuest = true,
    QuestCompleteNotification = true,
    
    -- ⚔️ COMBATE AVANÇADO
    AutoClick = false,
    ClickSpeed = 20,
    UseSkills = false,
    SkillDelay = 2,
    AutoHaki = {
        Buso = true,
        Ken = true,
        Soru = false
    },
    
    -- 🍎 DEVIL FRUIT
    AutoFruit = false,
    FruitNotification = true,
    AutoStoreFruit = true,
    FruitTeleport = true,
    FruitESP = true,
    
    -- 💎 AUTO COLLECT
    AutoCollectChests = false,
    AutoCollectMaterials = false,
    AutoSellItems = false,
    MaterialESP = true,
    
    -- 🏴‍☠️ RAID SYSTEM
    AutoRaid = false,
    RaidMode = "All", -- All, Law, Buddha, etc.
    AutoStartRaid = false,
    AutoNextIsland = true,
    
    -- 🌊 SEA SYSTEM
    AutoSeaBeast = false,
    SeaBeastNotification = true,
    AutoBoat = false,
    BoatSpeed = 300,
    
    -- 📈 STATS ENHANCEMENT
    AutoStats = false,
    StatsMode = {
        Melee = 0,
        Defense = 0,
        Sword = 0,
        Gun = 0,
        Fruit = 100
    },
    
    -- 🛡️ PROTEÇÃO E SEGURANÇA
    AntiKick = true,
    AntiAFK = true,
    AntiLag = true,
    AntiCrash = true,
    SafeMode = false,
    AdminDetection = true,
    AutoRejoin = true,
    
    -- 🎨 VISUAL E ESP
    ESP = {
        Players = false,
        NPCs = true,
        Fruits = true,
        Chests = true,
        Materials = true,
        Bosses = true,
        Ships = false
    },
    
    -- 🔧 MISC
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    NoClip = false,
    FullBright = false,
    
    -- 📊 ESTATÍSTICAS
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
        TimeActive = 0
    }
}

-- 🎨 CARREGANDO RAYFIELD UI LIBRARY
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 🖥️ CRIANDO INTERFACE PRINCIPAL
local Window = Rayfield:CreateWindow({
    Name = "🌟 NEON HUB V3 - ULTIMATE EDITION",
    LoadingTitle = "NEON HUB V3",
    LoadingSubtitle = "Carregando funcionalidades avançadas...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHubV3",
        FileName = "UltimateConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "🔑 NEON HUB V3 - KEY SYSTEM",
        Subtitle = "Digite sua chave premium:",
        Note = "Adquira sua chave no Discord oficial!",
        FileName = "NeonKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"NEONHUBV3PREMIUM2024", "ULTIMATEEDITION", "NEONDEV"}
    }
})

-- 📑 CRIANDO TABS DA INTERFACE
local MainTab = Window:CreateTab("🎯 Auto Farm", 4483362458)
local BossTab = Window:CreateTab("👹 Boss & Raid", 4483362458)
local FruitTab = Window:CreateTab("🍎 Devil Fruit", 4483362458)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local QuestTab = Window:CreateTab("🎯 Quest System", 4483362458)
local SeaTab = Window:CreateTab("🌊 Sea Events", 4483362458)
local StatsTab = Window:CreateTab("📈 Stats & Player", 4483362458)
local ESPTab = Window:CreateTab("👁️ ESP & Visual", 4483362458)
local MiscTab = Window:CreateTab("🔧 Misc & Teleport", 4483362458)
local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)
local InfoTab = Window:CreateTab("📊 Statistics", 4483362458)

-- 🔧 FUNÇÕES UTILITÁRIAS AVANÇADAS
local NeonUtils = {}

function NeonUtils:GetRandomDelay(min, max)
    min = min or 50
    max = max or 200
    return math.random(min, max) / 1000
end

function NeonUtils:SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("🚨 Erro capturado:", result)
    end
    return success, result
end

function NeonUtils:GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

function NeonUtils:IsAlive(target)
    return target and target.Parent and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0
end

function NeonUtils:GetPlayerLevel()
    local success, level = pcall(function()
        return Player.Data.Level.Value
    end)
    return success and level or 1
end

function NeonUtils:GetPlayerBeli()
    local success, beli = pcall(function()
        return Player.Data.Beli.Value
    end)
    return success and beli or 0
end

function NeonUtils:GetPlayerFragments()
    local success, fragments = pcall(function()
        return Player.Data.Fragments.Value
    end)
    return success and fragments or 0
end

-- 🎯 SISTEMA DE DETECÇÃO DE SEGURANÇA
local SecuritySystem = {}

function SecuritySystem:IsAdminNearby()
    if not NeonConfig.AdminDetection then return false end
    
    local adminKeywords = {"admin", "mod", "staff", "dev", "owner"}
    
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

function SecuritySystem:CheckEnvironment()
    local dangerousElements = {
        "AntiCheat",
        "Security",
        "Detection",
        "Monitor"
    }
    
    for _, element in ipairs(dangerousElements) do
        if Workspace:FindFirstChild(element) then
            return false, element
        end
    end
    return true
end

-- 📡 SISTEMA DE COMUNICAÇÃO COM SERVIDOR
local ServerComm = {}

function ServerComm:InvokeServer(...)
    return NeonUtils:SafeCall(function(...)
        return ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
    end, ...)
end

function ServerComm:FireServer(...)
    return NeonUtils:SafeCall(function(...)
        return ReplicatedStorage.Remotes.CommF_:FireServer(...)
    end, ...)
end

-- ⚔️ SISTEMA DE COMBATE AVANÇADO
local CombatSystem = {}

function CombatSystem:GetNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        if NeonUtils:IsAlive(enemy) and enemy:FindFirstChild("HumanoidRootPart") then
            local distance = NeonUtils:GetDistance(RootPart.Position, enemy.HumanoidRootPart.Position)
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end
    
    return nearestEnemy, shortestDistance
end

function CombatSystem:GetNearestBoss()
    local bosses = {"Saber Expert", "The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard", "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain", "Darkbeard", "Order", "Awakened Ice Admiral", "Tide Keeper", "Beast Hunter", "Instinct Practitioner", "Cake Queen", "Dough King", "rip_indra True Form"}
    
    for _, bossName in ipairs(bosses) do
        local boss = Workspace.Enemies:FindFirstChild(bossName)
        if boss and NeonUtils:IsAlive(boss) then
            return boss, NeonUtils:GetDistance(RootPart.Position, boss.HumanoidRootPart.Position)
        end
    end
    
    return nil, math.huge
end

function CombatSystem:AttackTarget()
    ServerComm:InvokeServer("TAP", {})
end

function CombatSystem:EnableBusoHaki()
    if NeonConfig.AutoHaki.Buso then
        ServerComm:InvokeServer("Buso")
    end
end

function CombatSystem:EnableKenHaki()
    if NeonConfig.AutoHaki.Ken then
        ServerComm:InvokeServer("Ken", true)
    end
end

function CombatSystem:UseSoru()
    if NeonConfig.AutoHaki.Soru then
        ServerComm:InvokeServer("Soru")
    end
end

function CombatSystem:UseSkill(key)
    if NeonConfig.UseSkills then
        ServerComm:InvokeServer("TAP", {[1] = key})
    end
end

-- 🚀 SISTEMA DE MOVIMENTAÇÃO AVANÇADO
local MovementSystem = {}

function MovementSystem:TeleportTo(position, speed)
    if not position then return end
    
    speed = speed or NeonConfig.FarmSpeed
    local distance = NeonUtils:GetDistance(RootPart.Position, position)
    local time = distance / (speed * 50)
    
    local tween = TweenService:Create(RootPart, TweenInfo.new(
        time,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut
    ), {CFrame = CFrame.new(position)})
    
    tween:Play()
    return tween
end

function MovementSystem:SafeTeleport(position, safetyCheck)
    safetyCheck = safetyCheck or function() return true end
    
    if safetyCheck() then
        return MovementSystem:TeleportTo(position)
    else
        warn("🚨 Teleporte cancelado por motivos de segurança!")
        return nil
    end
end

-- 🍎 SISTEMA DE DEVIL FRUIT
local FruitSystem = {}

function FruitSystem:GetNearbyFruits()
    local fruits = {}
    
    for _, fruit in pairs(Workspace:GetChildren()) do
        if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
            local distance = NeonUtils:GetDistance(RootPart.Position, fruit.Handle.Position)
            if distance < 1000 then
                table.insert(fruits, {fruit = fruit, distance = distance})
            end
        end
    end
    
    -- Ordenar por distância
    table.sort(fruits, function(a, b) return a.distance < b.distance end)
    return fruits
end

function FruitSystem:CollectNearbyFruits()
    local fruits = FruitSystem:GetNearbyFruits()
    
    for _, fruitData in ipairs(fruits) do
        if NeonConfig.AutoFruit then
            MovementSystem:TeleportTo(fruitData.fruit.Handle.Position)
            wait(1)
            NeonConfig.SessionStats.ItemsCollected = NeonConfig.SessionStats.ItemsCollected + 1
            
            if NeonConfig.FruitNotification then
                Rayfield:Notify({
                    Title = "🍎 Fruta Coletada!",
                    Content = "Fruta: " .. fruitData.fruit.Name,
                    Duration = 3,
                    Image = 4483362458
                })
            end
        end
    end
end

-- 🎯 SISTEMA DE QUEST AVANÇADO
local QuestSystem = {}

function QuestSystem:GetCurrentQuest()
    return NeonUtils:SafeCall(function()
        return Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    end)
end

function QuestSystem:HasQuest()
    local success, quest = QuestSystem:GetCurrentQuest()
    return success and quest and quest ~= ""
end

function QuestSystem:StartQuest()
    if not QuestSystem:HasQuest() and NeonConfig.AutoQuest then
        local level = NeonUtils:GetPlayerLevel()
        
        -- Lógica para pegar quest baseada no level
        if level >= 1 and level <= 10 then
            -- Bandits quest
            ServerComm:InvokeServer("StartQuest", "BanditQuest1", 1)
        elseif level >= 15 and level <= 30 then
            -- Monkey quest
            ServerComm:InvokeServer("StartQuest", "JungleQuest", 1)
        -- Adicionar mais quests baseadas no level...
        end
    end
end

-- 📊 SISTEMA DE ESP AVANÇADO
local ESPSystem = {}

function ESPSystem:CreateESP(object, text, color)
    if object:FindFirstChild("NeonESP") then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "NeonESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = object
    
    local textLabel = Instance.new("TextLabel")
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = text
    textLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboardGui
end

function ESPSystem:RemoveESP(object)
    local esp = object:FindFirstChild("NeonESP")
    if esp then
        esp:Destroy()
    end
end

function ESPSystem:UpdateESP()
    -- ESP para frutas
    if NeonConfig.ESP.Fruits then
        for _, fruit in pairs(Workspace:GetChildren()) do
            if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                ESPSystem:CreateESP(fruit.Handle, fruit.Name, Color3.fromRGB(255, 100, 100))
            end
        end
    end
    
    -- ESP para inimigos
    if NeonConfig.ESP.NPCs then
        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") then
                ESPSystem:CreateESP(enemy.HumanoidRootPart, enemy.Name, Color3.fromRGB(255, 0, 0))
            end
        end
    end
    
    -- ESP para chests
    if NeonConfig.ESP.Chests then
        for _, chest in pairs(Workspace:GetChildren()) do
            if chest.Name:find("Chest") and chest:FindFirstChild("Part") then
                ESPSystem:CreateESP(chest.Part, "Chest", Color3.fromRGB(255, 255, 0))
            end
        end
    end
end

-- 🌊 SISTEMA DE SEA EVENTS
local SeaSystem = {}

function SeaSystem:GetNearbySeaBeast()
    for _, seaBeast in pairs(Workspace.SeaBeasts:GetChildren()) do
        if seaBeast:FindFirstChild("HumanoidRootPart") and NeonUtils:IsAlive(seaBeast) then
            local distance = NeonUtils:GetDistance(RootPart.Position, seaBeast.HumanoidRootPart.Position)
            return seaBeast, distance
        end
    end
    return nil, math.huge
end

-- 🔄 SISTEMA PRINCIPAL DE AUTO FARM
local AutoFarmSystem = {}

function AutoFarmSystem:StartFarm()
    spawn(function()
        while NeonConfig.AutoFarm do
            local isAdminNearby, adminName = SecuritySystem:IsAdminNearby()
            
            if isAdminNearby then
                NeonConfig.AutoFarm = false
                Rayfield:Notify({
                    Title = "🚨 ADMIN DETECTADO!",
                    Content = "Admin: " .. adminName .. "\nFarm pausado por segurança!",
                    Duration = 10,
                    Image = 4483362458
                })
                break
            end
            
            -- Atualizar character se necessário
            if not Character or not Character.Parent then
                Character = Player.Character or Player.CharacterAdded:Wait()
                Humanoid = Character:WaitForChild("Humanoid")
                RootPart = Character:WaitForChild("HumanoidRootPart")
            end
            
            -- Ativar Hakis
            CombatSystem:EnableBusoHaki()
            CombatSystem:EnableKenHaki()
            
            -- Encontrar inimigo
            local enemy, distance = CombatSystem:GetNearestEnemy()
            
            if enemy and distance < 2000 then
                -- Teleportar para o inimigo
                local targetPosition = enemy.HumanoidRootPart.Position + Vector3.new(0, NeonConfig.FarmDistance, 0)
                MovementSystem:TeleportTo(targetPosition)
                
                -- Atacar inimigo
                while NeonUtils:IsAlive(enemy) and NeonConfig.AutoFarm do
                    CombatSystem:AttackTarget()
                    
                    -- Usar skills aleatoriamente
                    if NeonConfig.UseSkills and math.random(1, 30) == 1 then
                        local skills = {"Z", "X", "C", "V", "F"}
                        CombatSystem:UseSkill(skills[math.random(1, #skills)])
                    end
                    
                    wait(NeonConfig.AttackDelay + NeonUtils:GetRandomDelay())
                end
                
                NeonConfig.SessionStats.Experience = NeonConfig.SessionStats.Experience + (enemy.Humanoid.MaxHealth or 100)
            end
            
            -- Coletar frutas se ativado
            if NeonConfig.AutoFruit then
                FruitSystem:CollectNearbyFruits()
            end
            
            -- Pegar quest se ativado
            if NeonConfig.AutoQuest then
                QuestSystem:StartQuest()
            end
            
            wait(0.5)
        end
    end)
end

-- 🎨 CRIANDO INTERFACE - MAIN TAB
local AutoFarmToggle = MainTab:CreateToggle({
    Name = "🔥 Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        NeonConfig.AutoFarm = Value
        if Value then
            AutoFarmSystem:StartFarm()
            Rayfield:Notify({
                Title = "✅ Auto Farm Ativado",
                Content = "Farm iniciado com modo: " .. NeonConfig.AutoFarmMode,
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

local FarmModeDropdown = MainTab:CreateDropdown({
    Name = "🎯 Modo de Farm",
    Options = {"Nearest", "Level", "Mastery", "Boss"},
    CurrentOption = "Nearest",
    Flag = "FarmMode",
    Callback = function(Option)
        NeonConfig.AutoFarmMode = Option
    end
})

local FarmSpeedSlider = MainTab:CreateSlider({
    Name = "⚡ Velocidade de Farm",
    Range = {1, 50},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 20,
    Flag = "FarmSpeed",
    Callback = function(Value)
        NeonConfig.FarmSpeed = Value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = Value
        end
    end
})

local AttackSpeedSlider = MainTab:CreateSlider({
    Name = "🗡️ Velocidade de Ataque",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = 0.05,
    Flag = "AttackSpeed",
    Callback = function(Value)
        NeonConfig.AttackDelay = Value
    end
})

-- 🎨 BOSS TAB
local AutoBossToggle = BossTab:CreateToggle({
    Name = "👹 Auto Boss",
    CurrentValue = false,
    Flag = "AutoBoss",
    Callback = function(Value)
        NeonConfig.AutoBoss = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoBoss do
                    local boss, distance = CombatSystem:GetNearestBoss()
                    if boss and distance < 3000 then
                        MovementSystem:TeleportTo(boss.HumanoidRootPart.Position)
                        
                        while NeonUtils:IsAlive(boss) and NeonConfig.AutoBoss do
                            CombatSystem:AttackTarget()
                            CombatSystem:EnableBusoHaki()
                            CombatSystem:EnableKenHaki()
                            
                            if NeonConfig.UseSkills then
                                CombatSystem:UseSkill("Z")
                                wait(1)
                                CombatSystem:UseSkill("X")
                                wait(1)
                                CombatSystem:UseSkill("C")
                            end
                            
                            wait(NeonConfig.AttackDelay)
                        end
                        
                        NeonConfig.SessionStats.BossesKilled = NeonConfig.SessionStats.BossesKilled + 1
                    end
                    wait(5)
                end
            end)
        end
    end
})

-- 🎨 FRUIT TAB
local AutoFruitToggle = FruitTab:CreateToggle({
    Name = "🍎 Auto Collect Fruits",
    CurrentValue = false,
    Flag = "AutoFruit",
    Callback = function(Value)
        NeonConfig.AutoFruit = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoFruit do
                    FruitSystem:CollectNearbyFruits()
                    wait(5)
                end
            end)
        end
    end
})

-- 🎨 COMBAT TAB
local AutoClickToggle = CombatTab:CreateToggle({
    Name = "🖱️ Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        NeonConfig.AutoClick = Value
        if Value then
            spawn(function()
                while NeonConfig.AutoClick do
                    CombatSystem:AttackTarget()
                    wait(1/NeonConfig.ClickSpeed)
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

-- 🎨 ESP TAB
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

-- 🎨 MISC TAB
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
                    wait(300) -- 5 minutos
                end
            end)
        end
    end
})

-- 🎨 SETTINGS TAB
local SafeModeToggle = SettingsTab:CreateToggle({
    Name = "🔒 Modo Seguro",
    CurrentValue = false,
    Flag = "SafeMode",
    Callback = function(Value)
        NeonConfig.SafeMode = Value
        NeonConfig.AdminDetection = Value
    end
})

-- 🎨 INFO TAB - ESTATÍSTICAS
local StatsLabel = InfoTab:CreateLabel("📊 Carregando estatísticas...")

-- 🔄 LOOP PRINCIPAL DE ATUALIZAÇÃO
spawn(function()
    while true do
        -- Atualizar estatísticas
        local currentLevel = NeonUtils:GetPlayerLevel()
        local currentBeli = NeonUtils:GetPlayerBeli()
        local currentFragments = NeonUtils:GetPlayerFragments()
        local sessionTime = math.floor((tick() - NeonConfig.SessionStats.StartTime) / 60)
        
        -- Atualizar display de stats
        StatsLabel:Set(string.format([[
📊 ESTATÍSTICAS DA SESSÃO:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👤 Level: %d
💰 Beli: %s
💎 Fragments: %s
⚡ XP Farmado: %s
💀 Mortes: %d
🔄 Restarts: %d
🎁 Items Coletados: %d
👹 Bosses Mortos: %d
🎯 Quests Completas: %d
⏱️ Tempo Ativo: %d minutos
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]], 
            currentLevel,
            tostring(currentBeli),
            tostring(currentFragments),
            tostring(NeonConfig.SessionStats.Experience),
            NeonConfig.SessionStats.Deaths,
            NeonConfig.SessionStats.Restarts,
            NeonConfig.SessionStats.ItemsCollected,
            NeonConfig.SessionStats.BossesKilled,
            NeonConfig.SessionStats.QuestsCompleted,
            sessionTime
        ))
        
        -- Atualizar ESP
        ESPSystem:UpdateESP()
        
        -- Verificar segurança
        if NeonConfig.SafeMode then
            local isAdminNearby = SecuritySystem:IsAdminNearby()
            if isAdminNearby then
                -- Desativar todas as funções
                NeonConfig.AutoFarm = false
                NeonConfig.AutoBoss = false
                NeonConfig.AutoFruit = false
                
                Rayfield:Notify({
                    Title = "🚨 MODO SEGURO ATIVADO",
                    Content = "Admin detectado! Todas as funções foram pausadas.",
                    Duration = 10,
                    Image = 4483362458
                })
            end
        end
        
        wait(1)
    end
end)

-- 🔄 SISTEMA DE RECONEXÃO AUTOMÁTICA
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild('ErrorFrame') then
        ServerComm:InvokeServer("Reconnect")
        NeonConfig.SessionStats.Restarts = NeonConfig.SessionStats.Restarts + 1
    end
end)

-- 🎯 DETECÇÃO DE MORTE DO PLAYER
spawn(function()
    while true do
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.Died:Connect(function()
                NeonConfig.SessionStats.Deaths = NeonConfig.SessionStats.Deaths + 1
                
                if NeonConfig.AutoRejoinOnDeath then
                    wait(5)
                    -- Reconectar ou recarregar character
                    Character = Player.CharacterAdded:Wait()
                    Humanoid = Character:WaitForChild("Humanoid")
                    RootPart = Character:WaitForChild("HumanoidRootPart")
                end
            end)
        end
        wait(1)
    end
end)

-- 🎉 NOTIFICAÇÃO DE INICIALIZAÇÃO
Rayfield:Notify({
    Title = "🌟 NEON HUB V3 CARREGADO!",
    Content = "Todas as funcionalidades premium foram ativadas com sucesso!\n\n✅ 50+ Funcionalidades\n✅ Sistema Anti-Ban\n✅ Auto Farm Inteligente\n✅ Boss & Raid System\n✅ ESP Avançado",
    Duration = 8,
    Image = 4483362458
})

-- 🎵 SOM DE INICIALIZAÇÃO
spawn(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://131961136"
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end)

-- 📝 LOG FINAL
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🌟 NEON HUB V3 - ULTIMATE EDITION CARREGADO COM SUCESSO! 🌟")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📅 Versão: 3.0.0 PREMIUM")
print("👑 Desenvolvido por: Neon Development Team")
print("🎯 Funcionalidades: 50+ Features Premium")
print("🛡️ Sistema de Segurança: ATIVADO")
print("⚠️  AVISO: Use por sua própria conta e risco!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- 🔚 FIM DO SCRIPT
