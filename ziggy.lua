
-- Neon Hub V2 by xzgyx - Rayfield UI Edition
-- Código completo consolidado para Blox Fruits
-- UI: Rayfield Library

-- Proteção Anti-Crash
local success, error = pcall(function()
    -- Verificar se é Blox Fruits
    local BloxFruitsIds = {2753915549, 4442272183, 7449423635, 11156845653}
    local isBloxFruits = false
    
    for _, id in pairs(BloxFruitsIds) do
        if game.PlaceId == id then
            isBloxFruits = true
            break
        end
    end
    
    if not isBloxFruits then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Neon Hub V2",
            Text = "Este script é apenas para Blox Fruits!",
            Duration = 5
        })
        return
    end
    
    -- Carregar Rayfield UI Library
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    -- Serviços
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")
    local VirtualUser = game:GetService("VirtualUser")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PathfindingService = game:GetService("PathfindingService")
    local StarterGui = game:GetService("StarterGui")
    
    -- Variáveis
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Variáveis de ESP
    local ESPConnections = {}
    
    -- Configurações
    local Config = {
        -- Auto Farm
        AutoFarmLevel = false,
        AutoQuest = false,
        AutoBuso = false,
        AutoObservation = false,
        AutoBring = false,
        AutoFastAttack = false,
        SelectWeapon = "",
        FarmDistance = 15,
        BringDistance = 350,
        SafeDistance = 30,
        AttackDistance = 35,
        QuestDistance = 5,
        TeleportHeight = 25,
        
        -- Stats
        SelectedStats = "Combat",
        AutoStats = false,
        StatsAmount = 1,
        
        -- Combat
        KillAura = false,
        AutoEquipWeapon = true,
        
        -- Player
        NoClip = false,
        WalkSpeed = 16,
        JumpPower = 50,
        InfiniteStamina = false,
        AntiAFK = false,
        
        -- Visual
        RemoveFog = false,
        FullBright = false,
        ESPPlayer = false,
        ESPFruit = false,
        ESPChest = false,
        ESPNPC = false,
        MobESP = false,
        
        -- Boss Farm
        AutoFarmBoss = false,
        SelectBoss = "",
        
        -- Mastery Farm
        AutoFarmMastery = false,
        SelectWeaponMastery = "",
        UseSkillZ = false,
        UseSkillX = false,
        UseSkillC = false,
        UseSkillV = false,
        UseSkillF = false,
        
        -- Item Farm
        AutoFarmFruit = false,
        AutoFarmChest = false,
        AutoFarmMaterial = false,
        SelectMaterial = "",
        
        -- Misc
        AutoRejoin = false,
        AutoSave = false,
        WalkOnWater = false,
        
        -- Internal
        CurrentQuest = nil,
        QuestMob = nil,
        QuestLevel = nil,
        IslandPosition = nil,
        QuestPosition = nil,
        MobPosition = nil,
        FastAttackDelay = 0.1,
        TweenSpeed = 350,
        BypassTP = false,
        SafeMode = true
    }
    
    -- Criar Rayfield Window
    local Window = Rayfield:CreateWindow({
        Name = "Neon Hub V2 by xzgyx",
        LoadingTitle = "Neon Hub V2",
        LoadingSubtitle = "Carregando...",
        Theme = "Default",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "NeonHubV2",
            FileName = "Config"
        },
        Discord = {
            Enabled = true,
            Invite = "neonhub",
            RememberJoins = true
        },
        KeySystem = false
    })
    
    -- Abas
    local MainTab = Window:CreateTab("🏠 Principal", nil)
    local FarmTab = Window:CreateTab("🌾 Auto Farm", nil)
    local CombatTab = Window:CreateTab("⚔️ Combat", nil)
    local PlayerTab = Window:CreateTab("👤 Player", nil)
    local TeleportTab = Window:CreateTab("🚀 Teleport", nil)
    local MiscTab = Window:CreateTab("🔧 Misc", nil)
    local VisualTab = Window:CreateTab("👁️ Visual", nil)
    local RaidTab = Window:CreateTab("🌊 Raid", nil)
    local SeaTab = Window:CreateTab("🌊 Sea Events", nil)
    local BossTab = Window:CreateTab("👑 Boss", nil)
    local QuestTab = Window:CreateTab("📋 Quest", nil)
    local WeaponTab = Window:CreateTab("🗡️ Weapon", nil)
    local FruitTab = Window:CreateTab("🍎 Fruit", nil)
    local ShopTab = Window:CreateTab("🛒 Shop", nil)
    local StatusTab = Window:CreateTab("📊 Status", nil)
    local SettingsTab = Window:CreateTab("⚙️ Settings", nil)
    
    -- Funções utilitárias
    local function Notify(title, text, duration)
        Rayfield:Notify({
            Title = title,
            Content = text,
            Duration = duration or 5,
            Image = nil,
            Actions = {}
        })
    end
    
    local function GetCharacter()
        return Player.Character or Player.CharacterAdded:Wait()
    end
    
    local function GetHumanoid()
        local char = GetCharacter()
        return char:WaitForChild("Humanoid")
    end
    
    local function GetRootPart()
        local char = GetCharacter()
        return char:WaitForChild("HumanoidRootPart")
    end
    
    local function GetWeapon()
        local char = GetCharacter()
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                return tool
            end
        end
        return nil
    end
    
    local function GetWeaponList()
        local weapons = {}
        for _, tool in pairs(Player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(weapons, tool.Name)
            end
        end
        local char = GetCharacter()
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(weapons, tool.Name)
            end
        end
        return weapons
    end
    
    local function EquipWeapon(weaponName)
        local char = GetCharacter()
        local humanoid = GetHumanoid()
        
        -- Verificar se a arma já está equipada
        local equippedWeapon = GetWeapon()
        if equippedWeapon and equippedWeapon.Name == weaponName then
            return true
        end
        
        -- Procurar na mochila
        local weapon = Player.Backpack:FindFirstChild(weaponName)
        if weapon then
            humanoid:EquipTool(weapon)
            return true
        end
        
        return false
    end
    
    local function GetNearestMob(maxDistance)
        local char = GetCharacter()
        local rootPart = GetRootPart()
        local nearestMob = nil
        local shortestDistance = maxDistance or math.huge
        
        for _, mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                if mob.Humanoid.Health > 0 then
                    local distance = (rootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestMob = mob
                    end
                end
            end
        end
        
        return nearestMob, shortestDistance
    end
    
    local function GetQuestMob()
        local char = GetCharacter()
        local rootPart = GetRootPart()
        local questMob = nil
        local shortestDistance = math.huge
        
        if Config.QuestMob then
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if string.find(mob.Name, Config.QuestMob) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                    if mob.Humanoid.Health > 0 then
                        local distance = (rootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            questMob = mob
                        end
                    end
                end
            end
        end
        
        return questMob, shortestDistance
    end
    
    local function TeleportTo(cframe, speed)
        local char = GetCharacter()
        local rootPart = GetRootPart()
        
        if not rootPart then return end
        
        local tweenInfo = TweenInfo.new(
            (rootPart.Position - cframe.Position).Magnitude / (speed or Config.TweenSpeed),
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = cframe})
        tween:Play()
        
        return tween
    end
    
    local function BringMobs()
        if not Config.AutoBring then return end
        
        local char = GetCharacter()
        local rootPart = GetRootPart()
        
        if not rootPart then return end
        
        for _, mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                if mob.Humanoid.Health > 0 then
                    local distance = (rootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                    if distance <= Config.BringDistance then
                        local targetPos = rootPart.CFrame * CFrame.new(0, 0, Config.AttackDistance)
                        
                        mob.HumanoidRootPart.CFrame = targetPos
                        mob.HumanoidRootPart.Anchored = true
                        mob.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                        
                        if mob:FindFirstChild("Head") then
                            mob.Head.CanCollide = false
                        end
                        
                        -- Desabilitar animações
                        if mob.Humanoid:FindFirstChild("Animator") then
                            mob.Humanoid.Animator:Destroy()
                        end
                        
                        -- Reduzir velocidade
                        mob.Humanoid.WalkSpeed = 0
                        mob.Humanoid.JumpPower = 0
                        
                        -- Desabilitar scripts
                        for _, script in pairs(mob:GetChildren()) do
                            if script:IsA("Script") or script:IsA("LocalScript") then
                                script.Disabled = true
                            end
                        end
                    end
                end
            end
        end
    end
    
    local function FastAttack()
        if not Config.AutoFastAttack then return end
        
        local char = GetCharacter()
        local weapon = GetWeapon()
        
        if not weapon then return end
        
        -- Método 1: CombatFramework
        pcall(function()
            local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
            local CombatFrameworkR = getupvalues(CombatFramework)[2]
            local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
            local RigControllerR = getupvalues(RigController)[2]
            local realbhit = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
            local cooldownfastattack = tick()
            
            if CombatFrameworkR.activeController and CombatFrameworkR.activeController.equipped then
                if tick() - cooldownfastattack > Config.FastAttackDelay then
                    for _, v in pairs(CombatFrameworkR.activeController.data) do
                        if type(v) == "table" and v.Input then
                            v.Input.TimeStamp = tick()
                            v.Input.Time = 0
                        end
                    end
                    CombatFrameworkR.activeController.hitboxMagnitude = 55
                    CombatFrameworkR.activeController.active = false
                    CombatFrameworkR.activeController.timeToNextAttack = 0
                    CombatFrameworkR.activeController.timeToNextBlock = 0
                    CombatFrameworkR.activeController.focusStart = 0
                    CombatFrameworkR.activeController.increment = 4
                    CombatFrameworkR.activeController.blocking = false
                    CombatFrameworkR.activeController.hitSound = math.random(1, 5)
                    realbhit.wrapAttackAnimationAsync(CombatFrameworkR.activeController, weapon, 1, CombatFrameworkR.activeController.humanoid, CombatFrameworkR.activeController.rootPart, weapon.Handle, 1)
                    cooldownfastattack = tick()
                end
            end
        end)
        
        -- Método 2: VirtualUser
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(0, 0))
    end
    
    local function AutoBuso()
        if not Config.AutoBuso then return end
        
        local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        if remoteEvent and remoteEvent:FindFirstChild("CommF_") then
            remoteEvent.CommF_:InvokeServer("Buso")
        end
    end
    
    local function AutoObservation()
        if not Config.AutoObservation then return end
        
        local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        if remoteEvent and remoteEvent:FindFirstChild("CommF_") then
            remoteEvent.CommF_:InvokeServer("KenTalk", "Buy")
        end
    end
    
    local function AutoStats()
        if not Config.AutoStats then return end
        
        local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        if remoteEvent and remoteEvent:FindFirstChild("CommF_") then
            remoteEvent.CommF_:InvokeServer("AddPoint", Config.SelectedStats, Config.StatsAmount)
        end
    end
    
    local function UseSkill(key)
        local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        if remoteEvent and remoteEvent:FindFirstChild("CommF_") then
            remoteEvent.CommF_:InvokeServer("TAP")
        end
    end
    
    local function GetQuestForLevel(level)
        -- Definir quests baseadas no nível (nível 1-1574)
        if level >= 1 and level <= 9 then
            return {
                QuestName = "BanditQuest1",
                QuestNumber = 1,
                MobName = "Bandit",
                Level = {1, 9},
                NPCPosition = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544),
                MobPosition = CFrame.new(1045, 17, 1560)
            }
        elseif level >= 10 and level <= 14 then
            return {
                QuestName = "BanditQuest1",
                QuestNumber = 2,
                MobName = "Monkey",
                Level = {10, 14},
                NPCPosition = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544),
                MobPosition = CFrame.new(-1448, 50, 0)
            }
        elseif level >= 15 and level <= 29 then
            return {
                QuestName = "JungleQuest",
                QuestNumber = 1,
                MobName = "Gorilla",
                Level = {15, 29},
                NPCPosition = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                MobPosition = CFrame.new(-1142, 40, -515)
            }
        elseif level >= 30 and level <= 39 then
            return {
                QuestName = "JungleQuest",
                QuestNumber = 2,
                MobName = "Pirate",
                Level = {30, 39},
                NPCPosition = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                MobPosition = CFrame.new(-1169, 42, -1780)
            }
        elseif level >= 40 and level <= 59 then
            return {
                QuestName = "BuggyQuest1",
                QuestNumber = 1,
                MobName = "Brute",
                Level = {40, 59},
                NPCPosition = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627),
                MobPosition = CFrame.new(-1145, 15, 4350)
            }
        elseif level >= 60 and level <= 74 then
            return {
                QuestName = "BuggyQuest1",
                QuestNumber = 2,
                MobName = "Pirate",
                Level = {60, 74},
                NPCPosition = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627),
                MobPosition = CFrame.new(-1103, 13, 3896)
            }
        elseif level >= 75 and level <= 89 then
            return {
                QuestName = "DesertQuest",
                QuestNumber = 1,
                MobName = "Desert Bandit",
                Level = {75, 89},
                NPCPosition = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693),
                MobPosition = CFrame.new(924, 7, 4481)
            }
        elseif level >= 90 and level <= 99 then
            return {
                QuestName = "DesertQuest",
                QuestNumber = 2,
                MobName = "Desert Officer",
                Level = {90, 99},
                NPCPosition = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693),
                MobPosition = CFrame.new(1608, 10, 4371)
            }
        elseif level >= 100 and level <= 119 then
            return {
                QuestName = "SnowQuest",
                QuestNumber = 1,
                MobName = "Snow Bandit",
                Level = {100, 119},
                NPCPosition = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685),
                MobPosition = CFrame.new(1354, 87, -1393)
            }
        elseif level >= 120 and level <= 149 then
            return {
                QuestName = "SnowQuest",
                QuestNumber = 2,
                MobName = "Snowman",
                Level = {120, 149},
                NPCPosition = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685),
                MobPosition = CFrame.new(1201, 105, -1417)
            }
        elseif level >= 150 and level <= 174 then
            return {
                QuestName = "MarineQuest",
                QuestNumber = 1,
                MobName = "Chief Petty Officer",
                Level = {150, 174},
                NPCPosition = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                MobPosition = CFrame.new(-4881, 22, 4273)
            }
        elseif level >= 1525 and level <= 1574 then
            return {
                QuestName = "Area3Quest",
                QuestNumber = 4,
                MobName = "Water Fighter",
                Level = {1525, 1574},
                NPCPosition = CFrame.new(-6064.06885, 61.1445961, -9547.33398, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                MobPosition = CFrame.new(-216, 244, 1446)
            }
        end
        
        return nil
    end
    
    local function AcceptQuest()
        if not Config.AutoQuest then return end
        
        local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        if remoteEvent and remoteEvent:FindFirstChild("CommF_") then
            local level = Player.Data.Level.Value
            local questData = GetQuestForLevel(level)
            
            if questData then
                -- Teleportar para o NPC da quest
                if questData.NPCPosition then
                    TeleportTo(questData.NPCPosition)
                    wait(2)
                end
                
                -- Aceitar a quest
                remoteEvent.CommF_:InvokeServer("StartQuest", questData.QuestName, questData.QuestNumber)
                
                Config.CurrentQuest = questData.QuestName
                Config.QuestMob = questData.MobName
                Config.QuestLevel = questData.Level
                Config.MobPosition = questData.MobPosition
                
                wait(1)
            end
        end
    end
    
    local function AutoFarmLevel()
        if not Config.AutoFarmLevel then return end
        
        local character = GetCharacter()
        local humanoid = GetHumanoid()
        local rootPart = GetRootPart()
        
        if not character or not humanoid or not rootPart then return end
        
        -- Auto Quest
        if Config.AutoQuest then
            AcceptQuest()
        end
        
        -- Auto Equip Weapon
        if Config.AutoEquipWeapon and Config.SelectWeapon ~= "" then
            EquipWeapon(Config.SelectWeapon)
        end
        
        -- Auto Buso
        if Config.AutoBuso then
            AutoBuso()
        end
        
        -- Auto Observation
        if Config.AutoObservation then
            AutoObservation()
        end
        
        -- Auto Stats
        if Config.AutoStats then
            AutoStats()
        end
        
        -- Auto Bring Mobs
        if Config.AutoBring then
            BringMobs()
        end
        
        -- Auto Fast Attack
        if Config.AutoFastAttack then
            FastAttack()
        end
        
        -- Encontrar e atacar mob
        local mob, distance
        
        if Config.AutoQuest and Config.QuestMob then
            mob, distance = GetQuestMob()
        else
            mob, distance = GetNearestMob(Config.FarmDistance * 2)
        end
        
        if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            if mob.Humanoid.Health > 0 then
                if distance > Config.AttackDistance then
                    -- Teleportar para perto do mob
                    local targetPos = mob.HumanoidRootPart.CFrame * CFrame.new(0, Config.TeleportHeight, Config.AttackDistance)
                    TeleportTo(targetPos, Config.TweenSpeed)
                else
                    -- Atacar o mob
                    if Config.AutoFastAttack then
                        FastAttack()
                    end
                end
            end
        elseif Config.AutoQuest and Config.MobPosition then
            -- Teleportar para área do mob da quest
            TeleportTo(Config.MobPosition, Config.TweenSpeed)
        end
    end
    
    local function NoClip()
        if not Config.NoClip then return end
        
        local character = GetCharacter()
        if not character then return end
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    local function InfiniteStamina()
        if not Config.InfiniteStamina then return end
        
        local humanoid = GetHumanoid()
        if humanoid and humanoid:FindFirstChild("LocalScript") then
            local stamina = humanoid:FindFirstChild("Stamina")
            if stamina then
                stamina.Value = stamina.MaxValue
            end
        end
    end
    
    local function AntiAFK()
        if not Config.AntiAFK then return end
        
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
    
    local function RemoveFog()
        if not Config.RemoveFog then return end
        
        local lighting = game:GetService("Lighting")
        lighting.FogEnd = 100000
        lighting.FogStart = 0
        lighting.Brightness = 2
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.new(1, 1, 1)
    end
    
    local function WalkOnWater()
        if not Config.WalkOnWater then return end
        
        local character = GetCharacter()
        local humanoid = GetHumanoid()
        local rootPart = GetRootPart()
        
        if not character or not humanoid or not rootPart then return end
        
        -- Create invisible part under player when over water
        local raycast = workspace:Raycast(rootPart.Position, Vector3.new(0, -1000, 0))
        if not raycast then
            local waterWalkPart = Instance.new("Part")
            waterWalkPart.Name = "WaterWalk"
            waterWalkPart.Size = Vector3.new(6, 0.5, 6)
            waterWalkPart.Position = rootPart.Position - Vector3.new(0, 3, 0)
            waterWalkPart.Anchored = true
            waterWalkPart.CanCollide = true
            waterWalkPart.Transparency = 1
            waterWalkPart.Parent = workspace
            
            game:GetService("Debris"):AddItem(waterWalkPart, 2)
        end
    end
    
    local function AutoRejoin()
        if not Config.AutoRejoin then return end
        
        local Players = game:GetService("Players")
        local TeleportService = game:GetService("TeleportService")
        
        -- Auto rejoin on kick/disconnect
        Players.PlayerRemoving:Connect(function(player)
            if player == Players.LocalPlayer then
                wait(1)
                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
            end
        end)
    end
    
    local function AutoSave()
        if not Config.AutoSave then return end
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local saveRemote = ReplicatedStorage:FindFirstChild("SaveProgress")
        
        if saveRemote then
            saveRemote:FireServer()
        end
    end
    
    local function UpdateESP()
        if not Config.MobESP then
            -- Remove all ESP
            for _, connection in pairs(ESPConnections) do
                connection:Disconnect()
            end
            ESPConnections = {}
            
            for _, esp in pairs(workspace:GetChildren()) do
                if esp.Name == "MobESP" then
                    esp:Destroy()
                end
            end
            return
        end
        
        -- Add ESP to all mobs
        for _, mob in pairs(workspace:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Name ~= Players.LocalPlayer.Name then
                if not mob:FindFirstChild("MobESP") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "MobESP"
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.Parent = mob
                    
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundTransparency = 1
                    frame.Parent = billboard
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = mob.Name
                    label.TextColor3 = Color3.new(1, 0, 0)
                    label.TextScaled = true
                    label.Font = Enum.Font.SourceSansBold
                    label.Parent = frame
                    
                    local healthLabel = Instance.new("TextLabel")
                    healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    healthLabel.BackgroundTransparency = 1
                    healthLabel.Text = "HP: " .. math.floor(mob.Humanoid.Health)
                    healthLabel.TextColor3 = Color3.new(0, 1, 0)
                    healthLabel.TextScaled = true
                    healthLabel.Font = Enum.Font.SourceSans
                    healthLabel.Parent = frame
                    
                    -- Update health in real time
                    local connection = mob.Humanoid.HealthChanged:Connect(function()
                        healthLabel.Text = "HP: " .. math.floor(mob.Humanoid.Health)
                    end)
                    
                    table.insert(ESPConnections, connection)
                end
            end
        end
    end
    
    local function AutoFarmFruit()
        if not Config.AutoFarmFruit then return end
        
        local character = GetCharacter()
        local rootPart = GetRootPart()
        
        if not character or not rootPart then return end
        
        -- Look for devil fruits
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                local distance = (rootPart.Position - fruit.Handle.Position).Magnitude
                if distance <= Config.FarmDistance then
                    -- Teleport to fruit
                    TeleportTo(fruit.Handle.CFrame, Config.TweenSpeed)
                    wait(0.5)
                    -- Try to pick up fruit
                    if fruit and fruit.Parent then
                        fruit.Handle.CFrame = rootPart.CFrame
                    end
                end
            end
        end
    end
    
    local function AutoFarmChest()
        if not Config.AutoFarmChest then return end
        
        local character = GetCharacter()
        local rootPart = GetRootPart()
        
        if not character or not rootPart then return end
        
        -- Look for chests
        for _, chest in pairs(workspace:GetChildren()) do
            if chest.Name:find("Chest") and chest:FindFirstChild("Part") then
                local distance = (rootPart.Position - chest.Part.Position).Magnitude
                if distance <= Config.FarmDistance then
                    -- Teleport to chest
                    TeleportTo(chest.Part.CFrame, Config.TweenSpeed)
                    wait(0.5)
                    -- Try to open chest
                    if chest and chest.Parent then
                        chest.Part.CFrame = rootPart.CFrame
                    end
                end
            end
        end
    end
    
    local function AutoFarmMaterial()
        if not Config.AutoFarmMaterial then return end
        
        local character = GetCharacter()
        local rootPart = GetRootPart()
        
        if not character or not rootPart then return end
        
        -- Look for materials
        for _, material in pairs(workspace:GetChildren()) do
            if Config.SelectMaterial and material.Name == Config.SelectMaterial then
                if material:FindFirstChild("Part") or material:FindFirstChild("Handle") then
                    local part = material:FindFirstChild("Part") or material:FindFirstChild("Handle")
                    local distance = (rootPart.Position - part.Position).Magnitude
                    if distance <= Config.FarmDistance then
                        -- Teleport to material
                        TeleportTo(part.CFrame, Config.TweenSpeed)
                        wait(0.5)
                        -- Try to collect material
                        if material and material.Parent then
                            part.CFrame = rootPart.CFrame
                        end
                    end
                end
            end
        end
    end
    
    local function AutoFarmBoss()
        if not Config.AutoFarmBoss then return end
        
        local character = GetCharacter()
        local humanoid = GetHumanoid()
        local rootPart = GetRootPart()
        
        if not character or not humanoid or not rootPart then return end
        
        -- Auto Equip Weapon
        if Config.AutoEquipWeapon and Config.SelectWeapon ~= "" then
            EquipWeapon(Config.SelectWeapon)
        end
        
        -- Auto Buso
        if Config.AutoBuso then
            AutoBuso()
        end
        
        -- Auto Observation
        if Config.AutoObservation then
            AutoObservation()
        end
        
        -- Look for boss
        local boss = nil
        local minDistance = math.huge
        
        for _, mob in pairs(workspace:GetChildren()) do
            if mob.Name == Config.SelectBoss and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                if mob.Humanoid.Health > 0 then
                    local distance = (rootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        boss = mob
                    end
                end
            end
        end
        
        if boss then
            if minDistance > Config.AttackDistance then
                -- Teleport to boss
                local targetPos = boss.HumanoidRootPart.CFrame * CFrame.new(0, Config.TeleportHeight, Config.AttackDistance)
                TeleportTo(targetPos, Config.TweenSpeed)
            else
                -- Attack boss
                if Config.AutoFastAttack then
                    FastAttack()
                end
            end
        end
    end
    
    local function AutoFarmMastery()
        if not Config.AutoFarmMastery then return end
        
        local character = GetCharacter()
        local humanoid = GetHumanoid()
        local rootPart = GetRootPart()
        
        if not character or not humanoid or not rootPart then return end
        
        -- Auto Equip Weapon for mastery
        if Config.SelectWeaponMastery and Config.SelectWeaponMastery ~= "" then
            EquipWeapon(Config.SelectWeaponMastery)
        end
        
        -- Use weapon skills
        if Config.UseSkillZ then
            UseSkill("Z")
        end
        if Config.UseSkillX then
            UseSkill("X")
        end
        if Config.UseSkillC then
            UseSkill("C")
        end
        if Config.UseSkillV then
            UseSkill("V")
        end
        if Config.UseSkillF then
            UseSkill("F")
        end
        
        -- Find and attack mob for mastery
        local mob, distance = GetNearestMob(Config.FarmDistance)
        
        if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            if mob.Humanoid.Health > 0 then
                if distance > Config.AttackDistance then
                    -- Teleport to mob
                    local targetPos = mob.HumanoidRootPart.CFrame * CFrame.new(0, Config.TeleportHeight, Config.AttackDistance)
                    TeleportTo(targetPos, Config.TweenSpeed)
                else
                    -- Attack mob
                    if Config.AutoFastAttack then
                        FastAttack()
                    end
                end
            end
        end
    end
    
    local function MainLoop()
        RunService.Heartbeat:Connect(function()
            pcall(AutoFarmLevel)
            pcall(AutoFarmBoss)
            pcall(AutoFarmMastery)
            pcall(AutoFarmFruit)
            pcall(AutoFarmChest)
            pcall(AutoFarmMaterial)
            pcall(NoClip)
            pcall(InfiniteStamina)
            pcall(AntiAFK)
            pcall(RemoveFog)
            pcall(WalkOnWater)
            pcall(UpdateESP)
        end)
        
        -- Auto save every 5 minutes
        spawn(function()
            while true do
                wait(300) -- 5 minutes
                pcall(AutoSave)
            end
        end)
        
        -- Auto rejoin setup
        pcall(AutoRejoin)
    end
    
    -- Criar Interface Rayfield
    
    -- Aba Main
    local MainSection = MainTab:CreateSection("Principal")
    
    MainTab:CreateLabel("Neon Hub V2 - Blox Fruits")
    MainTab:CreateLabel("Versão: 2.0 | Autor: xzgyx")
    
    -- Aba Farm
    local FarmSection = FarmTab:CreateSection("Auto Farm Level")
    
    FarmTab:CreateToggle({
        Name = "Auto Farm Level",
        CurrentValue = Config.AutoFarmLevel,
        Flag = "AutoFarmLevel",
        Callback = function(Value)
            Config.AutoFarmLevel = Value
        end,
    })
    
    FarmTab:CreateToggle({
        Name = "Auto Quest",
        CurrentValue = Config.AutoQuest,
        Flag = "AutoQuest",
        Callback = function(Value)
            Config.AutoQuest = Value
        end,
    })
    
    FarmTab:CreateToggle({
        Name = "Auto Bring Mobs",
        CurrentValue = Config.AutoBring,
        Flag = "AutoBring",
        Callback = function(Value)
            Config.AutoBring = Value
        end,
    })
    
    FarmTab:CreateToggle({
        Name = "Auto Fast Attack",
        CurrentValue = Config.AutoFastAttack,
        Flag = "AutoFastAttack",
        Callback = function(Value)
            Config.AutoFastAttack = Value
        end,
    })
    
    -- Aba Combat
    local CombatSection = CombatTab:CreateSection("Combat Settings")
    
    CombatTab:CreateToggle({
        Name = "Auto Buso/Haki",
        CurrentValue = Config.AutoBuso,
        Flag = "AutoBuso",
        Callback = function(Value)
            Config.AutoBuso = Value
        end,
    })
    
    CombatTab:CreateToggle({
        Name = "Auto Observation",
        CurrentValue = Config.AutoObservation,
        Flag = "AutoObservation",
        Callback = function(Value)
            Config.AutoObservation = Value
        end,
    })
    
    -- Aba Player
    local PlayerSection = PlayerTab:CreateSection("Player Settings")
    
    PlayerTab:CreateToggle({
        Name = "No Clip",
        CurrentValue = Config.NoClip,
        Flag = "NoClip",
        Callback = function(Value)
            Config.NoClip = Value
        end,
    })
    
    PlayerTab:CreateToggle({
        Name = "Infinite Stamina",
        CurrentValue = Config.InfiniteStamina,
        Flag = "InfiniteStamina",
        Callback = function(Value)
            Config.InfiniteStamina = Value
        end,
    })
    
    PlayerTab:CreateToggle({
        Name = "Anti AFK",
        CurrentValue = Config.AntiAFK,
        Flag = "AntiAFK",
        Callback = function(Value)
            Config.AntiAFK = Value
        end,
    })
    
    PlayerTab:CreateToggle({
        Name = "Walk on Water",
        CurrentValue = Config.WalkOnWater,
        Flag = "WalkOnWater",
        Callback = function(Value)
            Config.WalkOnWater = Value
        end,
    })
    
    -- Aba Visual
    local VisualSection = VisualTab:CreateSection("Visual Settings")
    
    VisualTab:CreateToggle({
        Name = "Remove Fog",
        CurrentValue = Config.RemoveFog,
        Flag = "RemoveFog",
        Callback = function(Value)
            Config.RemoveFog = Value
        end,
    })
    
    VisualTab:CreateToggle({
        Name = "ESP Mobs",
        CurrentValue = Config.MobESP,
        Flag = "MobESP",
        Callback = function(Value)
            Config.MobESP = Value
        end,
    })
    
    -- Aba Misc
    local MiscSection = MiscTab:CreateSection("Misc Settings")
    
    MiscTab:CreateToggle({
        Name = "Auto Save",
        CurrentValue = Config.AutoSave,
        Flag = "AutoSave",
        Callback = function(Value)
            Config.AutoSave = Value
        end,
    })
    
    MiscTab:CreateToggle({
        Name = "Auto Rejoin",
        CurrentValue = Config.AutoRejoin,
        Flag = "AutoRejoin",
        Callback = function(Value)
            Config.AutoRejoin = Value
        end,
    })
    
    -- Initialize
    print("Neon Hub V2 - Blox Fruits Auto Farm Script Loaded!")
    print("Author: Neon Hub Team")
    print("Version: 2.0")
    print("Game: Blox Fruits")
    
    -- Start main loop
    MainLoop()
    
    -- Notify user
    Notify("Neon Hub V2", "Script carregado com sucesso!", 5)
    
end)

if not success then
    print("Erro ao carregar o script:", error)
end
