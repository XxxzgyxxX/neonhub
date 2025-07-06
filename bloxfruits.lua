
--[[
    Neon Hub v2 - Advanced Auto Farm Script for Blox Fruits
    Created with Rayfield UI Library
    Warning: Use at your own risk - may violate Roblox ToS
]]

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- Variáveis Globais
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Configurações do Script
local Config = {
    AutoFarm = false,
    AutoBoss = false,
    AutoRaid = false,
    AutoQuest = false,
    AutoStats = false,
    AutoCollect = false,
    AntiAFK = false,
    SafeMode = false,
    FarmSpeed = 16,
    AttackDelay = 0.1,
    TweenSpeed = 300,
    
    -- Configurações de Proteção
    AntiAdmin = true,
    RandomMovement = true,
    HumanBehavior = true,
    
    -- Configurações de Combate
    UseKenHaki = true,
    UseBusoHaki = true,
    AutoHeal = true,
    AutoBuffs = true,
    
    -- Configurações de Farm
    FarmMode = "Level",
    SelectedBoss = "All",
    SelectedFruit = "All",
    FarmDistance = 10,
    
    -- Estatísticas
    Stats = {
        XP = 0,
        Beli = 0,
        Items = 0,
        Deaths = 0,
        SessionTime = 0
    }
}

-- Carregando Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Criando a Interface
local Window = Rayfield:CreateWindow({
    Name = "Neon Hub v2 - Blox Fruits",
    LoadingTitle = "Neon Hub v2",
    LoadingSubtitle = "by Advanced Scripts",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("🎯 Auto Farm", 4483362458)
local BossTab = Window:CreateTab("👹 Boss Farm", 4483362458)
local CollectTab = Window:CreateTab("💎 Auto Collect", 4483362458)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local MiscTab = Window:CreateTab("🔧 Misc", 4483362458)
local StatsTab = Window:CreateTab("📊 Stats", 4483362458)

-- Funções Utilitárias
local function GetRandomDelay()
    return math.random(50, 200) / 1000
end

local function IsPlayerSafe()
    if not Config.AntiAdmin then return true end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower():find("admin") or player.Name:lower():find("mod") then
            return false
        end
    end
    return true
end

local function GetNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
            if enemy.Humanoid.Health > 0 then
                local distance = (RootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = enemy
                end
            end
        end
    end
    
    return nearestEnemy, shortestDistance
end

local function TeleportTo(position)
    if not position then return end
    
    local tween = TweenService:Create(RootPart, TweenInfo.new(
        (RootPart.Position - position).Magnitude / Config.TweenSpeed,
        Enum.EasingStyle.Linear
    ), {CFrame = CFrame.new(position)})
    
    tween:Play()
    tween.Completed:Wait()
end

local function UseAbility(abilityName)
    local args = {
        [1] = abilityName,
        [2] = true
    }
    
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end)
end

local function AttackEnemy()
    local args = {
        [1] = "TAP",
        [2] = {}
    }
    
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end)
end

local function EnableBusoHaki()
    if Config.UseBusoHaki then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end)
    end
end

local function EnableKenHaki()
    if Config.UseKenHaki then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ken", true)
        end)
    end
end

local function AutoHeal()
    if Config.AutoHeal and Character:FindFirstChild("Humanoid") then
        if Character.Humanoid.Health < Character.Humanoid.MaxHealth * 0.5 then
            -- Usar frutas ou itens de cura
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Heal")
            end)
        end
    end
end

local function CollectItems()
    if not Config.AutoCollect then return end
    
    for _, item in pairs(Workspace:GetChildren()) do
        if item.Name:find("Fruit") or item.Name:find("Chest") then
            if item:FindFirstChild("Handle") or item:FindFirstChild("Part") then
                local itemPosition = item:FindFirstChild("Handle") and item.Handle.Position or item:FindFirstChild("Part").Position
                if (RootPart.Position - itemPosition).Magnitude < 50 then
                    TeleportTo(itemPosition)
                    wait(0.5)
                    Config.Stats.Items = Config.Stats.Items + 1
                end
            end
        end
    end
end

-- Farm Principal
local function StartAutoFarm()
    spawn(function()
        while Config.AutoFarm do
            if not IsPlayerSafe() then
                Config.AutoFarm = false
                Rayfield:Notify({
                    Title = "⚠️ Aviso de Segurança",
                    Content = "Admin detectado! Farm pausado.",
                    Duration = 5,
                    Image = 4483362458
                })
                break
            end
            
            local enemy, distance = GetNearestEnemy()
            
            if enemy and distance < 2000 then
                -- Teleportar para o inimigo
                TeleportTo(enemy.HumanoidRootPart.Position + Vector3.new(0, Config.FarmDistance, 0))
                
                -- Ativar Hakis
                EnableBusoHaki()
                EnableKenHaki()
                
                -- Atacar
                while enemy and enemy.Parent and enemy.Humanoid.Health > 0 and Config.AutoFarm do
                    AttackEnemy()
                    
                    -- Usar habilidades aleatoriamente
                    if math.random(1, 10) == 1 then
                        UseAbility("Z")
                    elseif math.random(1, 15) == 1 then
                        UseAbility("X")
                    elseif math.random(1, 20) == 1 then
                        UseAbility("C")
                    end
                    
                    AutoHeal()
                    wait(Config.AttackDelay + GetRandomDelay())
                end
                
                Config.Stats.XP = Config.Stats.XP + enemy.Humanoid.MaxHealth
            end
            
            CollectItems()
            wait(0.5)
        end
    end)
end

-- Interface Principal
local FarmToggle = MainTab:CreateToggle({
    Name = "🔥 Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        Config.AutoFarm = Value
        if Value then
            StartAutoFarm()
            Rayfield:Notify({
                Title = "✅ Auto Farm Ativado",
                Content = "Farm iniciado com sucesso!",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "❌ Auto Farm Desativado",
                Content = "Farm pausado.",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

local SpeedSlider = MainTab:CreateSlider({
    Name = "⚡ Velocidade de Farm",
    Range = {1, 50},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 16,
    Flag = "FarmSpeed",
    Callback = function(Value)
        Config.FarmSpeed = Value
        if Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = Value
        end
    end
})

local AttackDelaySlider = MainTab:CreateSlider({
    Name = "🗡️ Delay de Ataque",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = 0.1,
    Flag = "AttackDelay",
    Callback = function(Value)
        Config.AttackDelay = Value
    end
})

-- Boss Farm
local BossToggle = BossTab:CreateToggle({
    Name = "👹 Auto Boss",
    CurrentValue = false,
    Flag = "AutoBoss",
    Callback = function(Value)
        Config.AutoBoss = Value
        if Value then
            spawn(function()
                while Config.AutoBoss do
                    -- Lógica para farm de boss
                    for _, boss in pairs(Workspace.Enemies:GetChildren()) do
                        if boss.Name:find("Boss") or boss.Name:find("Raid") then
                            if boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                                TeleportTo(boss.HumanoidRootPart.Position)
                                
                                while boss.Humanoid.Health > 0 and Config.AutoBoss do
                                    AttackEnemy()
                                    EnableBusoHaki()
                                    EnableKenHaki()
                                    AutoHeal()
                                    wait(Config.AttackDelay)
                                end
                                
                                Config.Stats.XP = Config.Stats.XP + boss.Humanoid.MaxHealth * 2
                            end
                        end
                    end
                    wait(5)
                end
            end)
        end
    end
})

-- Auto Collect
local CollectToggle = CollectTab:CreateToggle({
    Name = "💎 Auto Collect Items",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(Value)
        Config.AutoCollect = Value
        if Value then
            spawn(function()
                while Config.AutoCollect do
                    CollectItems()
                    wait(2)
                end
            end)
        end
    end
})

-- Combat Settings
local BusoToggle = CombatTab:CreateToggle({
    Name = "🛡️ Auto Buso Haki",
    CurrentValue = true,
    Flag = "UseBusoHaki",
    Callback = function(Value)
        Config.UseBusoHaki = Value
    end
})

local KenToggle = CombatTab:CreateToggle({
    Name = "👁️ Auto Ken Haki",
    CurrentValue = true,
    Flag = "UseKenHaki",
    Callback = function(Value)
        Config.UseKenHaki = Value
    end
})

local HealToggle = CombatTab:CreateToggle({
    Name = "❤️ Auto Heal",
    CurrentValue = true,
    Flag = "AutoHeal",
    Callback = function(Value)
        Config.AutoHeal = Value
    end
})

-- Misc Settings
local AntiAFKToggle = MiscTab:CreateToggle({
    Name = "🎮 Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        Config.AntiAFK = Value
        if Value then
            spawn(function()
                while Config.AntiAFK do
                    VirtualInputManager:SendKeyEvent(true, "W", false, game)
                    wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, "W", false, game)
                    wait(math.random(30, 60))
                end
            end)
        end
    end
})

local SafeModeToggle = MiscTab:CreateToggle({
    Name = "🔒 Modo Seguro",
    CurrentValue = false,
    Flag = "SafeMode",
    Callback = function(Value)
        Config.SafeMode = Value
        Config.AntiAdmin = Value
        Config.RandomMovement = Value
        Config.HumanBehavior = Value
    end
})

-- Stats Display
local StatsLabel = StatsTab:CreateLabel("📊 Estatísticas da Sessão")

spawn(function()
    while true do
        StatsLabel:Set(string.format([[
📊 Estatísticas da Sessão:
💫 XP Farmado: %d
💰 Beli Ganho: %d
💎 Items Coletados: %d
💀 Mortes: %d
⏱️ Tempo de Sessão: %d minutos
]], Config.Stats.XP, Config.Stats.Beli, Config.Stats.Items, Config.Stats.Deaths, Config.Stats.SessionTime))
        
        Config.Stats.SessionTime = Config.Stats.SessionTime + 1
        wait(60)
    end
end)

-- Botão de Reset Stats
local ResetStatsButton = StatsTab:CreateButton({
    Name = "🔄 Reset Estatísticas",
    Callback = function()
        Config.Stats = {
            XP = 0,
            Beli = 0,
            Items = 0,
            Deaths = 0,
            SessionTime = 0
        }
        
        Rayfield:Notify({
            Title = "🔄 Stats Resetadas",
            Content = "Todas as estatísticas foram resetadas!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

-- Detecção de Morte
Character.Humanoid.Died:Connect(function()
    Config.Stats.Deaths = Config.Stats.Deaths + 1
    wait(5)
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Notificação de Inicialização
Rayfield:Notify({
    Title = "🌟 Neon Hub v2 Carregado!",
    Content = "Todas as funções foram carregadas com sucesso!",
    Duration = 5,
    Image = 4483362458
})

-- Loop Principal de Proteção
spawn(function()
    while true do
        if not IsPlayerSafe() and Config.AntiAdmin then
            -- Desligar todas as funções
            Config.AutoFarm = false
            Config.AutoBoss = false
            Config.AutoCollect = false
            
            Rayfield:Notify({
                Title = "⚠️ ADMIN DETECTADO!",
                Content = "Todas as funções foram desativadas por segurança!",
                Duration = 10,
                Image = 4483362458
            })
            
            wait(30)
        end
        wait(5)
    end
end)

print("Neon Hub v2 - Blox Fruits carregado com sucesso!")
print("Criado por: Advanced Scripts")
print("Versão: 2.0")
print("⚠️ Use por sua própria conta e risco!")
