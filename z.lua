-- Neon Hub V2 by xzgyx - Rayfield UI Edition
-- Código completo otimizado para Blox Fruits
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
    local UserInputService = game:GetService("UserInputService")

    -- Variáveis
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local RootPart = Character:WaitForChild("HumanoidRootPart")

    -- Variáveis de ESP
    local ESPConnections = {}

    -- Configurações otimizadas
    local Config = {
        -- Auto Farm Melhorado
        AutoFarmLevel = false,
        AutoQuest = false,
        AutoBuso = false,
        AutoObservation = false,
        AutoBring = false,
        AutoFastAttack = false,
        SelectWeapon = "",
        FarmDistance = 25,
        BringDistance = 500,
        SafeDistance = 50,
        AttackDistance = 60,
        QuestDistance = 10,
        TeleportHeight = 30,

        -- Combat Melhorado
        KillAura = false,
        AutoEquipWeapon = true,
        UseSkillZ = false,
        UseSkillX = false,
        UseSkillC = false,
        UseSkillV = false,
        UseSkillF = false,
        AttackMethod = "Click",

        -- Stats
        SelectedStats = "Combat",
        AutoStats = false,
        StatsAmount = 1,

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

        -- Item Farm
        AutoFarmFruit = false,
        AutoFarmChest = false,
        AutoFarmMaterial = false,
        SelectMaterial = "",

        -- Misc
        AutoRejoin = false,
        AutoSave = false,
        WalkOnWater = false,

        -- Internal - Otimizado
        CurrentQuest = nil,
        QuestMob = nil,
        QuestLevel = nil,
        IslandPosition = nil,
        QuestPosition = nil,
        MobPosition = nil,
        FastAttackDelay = 0.05,
        TweenSpeed = 400,
        BypassTP = true,
        SafeMode = true,
        LastAttackTime = 0,
        AttackCooldown = 0.1,
        ClickConnection = nil,
        MeleeConnection = nil
    }

    -- Criar Rayfield Window
    local Window = Rayfield:CreateWindow({
        Name = "Neon Hub V2 by xzgyx - Otimizado",
        LoadingTitle = "Neon Hub V2",
        LoadingSubtitle = "Carregando versão otimizada...",
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
    local WeaponTab = Window:CreateTab("🗡️ Weapon", nil)
    local StatusTab = Window:CreateTab("📊 Status", nil)
    local SettingsTab = Window:CreateTab("⚙️ Settings", nil)

    -- Funções utilitárias otimizadas
    local function Notify(title, text, duration)
        Rayfield:Notify({
            Title = title,
            Content = text,
            Duration = duration or 3,
            Image = nil,
            Actions = {}
        })
    end

    local function GetCharacter()
        return Player.Character or Player.CharacterAdded:Wait()
    end

    local function GetHumanoid()
        local char = GetCharacter()
        return char and char:FindFirstChild("Humanoid")
    end

    local function GetRootPart()
        local char = GetCharacter()
        return char and char:FindFirstChild("HumanoidRootPart")
    end

    local function GetWeapon()
        local char = GetCharacter()
        if not char then return nil end

        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                return tool
            end
        end
        return nil
    end

    local function GetWeaponList()
        local weapons = {}

        -- Mochila
        for _, tool in pairs(Player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(weapons, tool.Name)
            end
        end

        -- Equipada
        local char = GetCharacter()
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(weapons, tool.Name)
                end
            end
        end

        return weapons
    end

    local function EquipWeapon(weaponName)
        if not weaponName or weaponName == "" then return false end

        local char = GetCharacter()
        local humanoid = GetHumanoid()

        if not char or not humanoid then return false end

        -- Verificar se já está equipada
        local equippedWeapon = GetWeapon()
        if equippedWeapon and equippedWeapon.Name == weaponName then
            return true
        end

        -- Procurar na mochila
        local weapon = Player.Backpack:FindFirstChild(weaponName)
        if weapon then
            humanoid:EquipTool(weapon)
            wait(0.1)
            return true
        end

        return false
    end

    local function GetNearestMob(maxDistance, questOnly)
        local char = GetCharacter()
        local rootPart = GetRootPart()

        if not char or not rootPart then return nil, math.huge end

        local nearestMob = nil
        local shortestDistance = maxDistance or math.huge

        -- Procurar em Enemies primeiro
        for _, mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                if mob.Humanoid.Health > 0 then
                    -- Filtrar por quest se necessário
                    if questOnly and Config.QuestMob then
                        if not string.find(string.lower(mob.Name), string.lower(Config.QuestMob)) then
                            continue
                        end
                    end

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

    local function TeleportTo(cframe, speed)
        local char = GetCharacter()
        local rootPart = GetRootPart()

        if not rootPart or not cframe then return nil end

        speed = speed or Config.TweenSpeed

        local distance = (rootPart.Position - cframe.Position).Magnitude
        local duration = distance / speed

        local tweenInfo = TweenInfo.new(
            duration,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )

        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = cframe})
        tween:Play()

        return tween
    end

    -- Sistema de ataque melhorado
    local function AdvancedFastAttack()
        if not Config.AutoFastAttack then return end

        local currentTime = tick()
        if currentTime - Config.LastAttackTime < Config.AttackCooldown then return end

        local char = GetCharacter()
        local weapon = GetWeapon()
        local humanoid = GetHumanoid()

        if not char or not weapon or not humanoid then return end

        -- Método 1: CombatFramework Otimizado
        local success1 = pcall(function()
            local CombatFramework = require(Player.PlayerScripts:WaitForChild("CombatFramework"))
            local CombatFrameworkR = getupvalues(CombatFramework)[2]
            local RigController = require(Player.PlayerScripts.CombatFramework.RigController)
            local RigControllerR = getupvalues(RigController)[2]
            local realbhit = require(ReplicatedStorage.CombatFramework.RigLib)

            if CombatFrameworkR.activeController and CombatFrameworkR.activeController.equipped then
                for i, v in pairs(CombatFrameworkR.activeController.data) do
                    if type(v) == "table" and v.Input then
                        v.Input.TimeStamp = currentTime
                        v.Input.Time = 0
                    end
                end

                CombatFrameworkR.activeController.hitboxMagnitude = 80
                CombatFrameworkR.activeController.active = false
                CombatFrameworkR.activeController.timeToNextAttack = 0
                CombatFrameworkR.activeController.timeToNextBlock = 0
                CombatFrameworkR.activeController.focusStart = 0
                CombatFrameworkR.activeController.increment = 4
                CombatFrameworkR.activeController.blocking = false
                CombatFrameworkR.activeController.hitSound = math.random(1, 5)

                realbhit.wrapAttackAnimationAsync(
                    CombatFrameworkR.activeController,
                    weapon,
                    1,
                    CombatFrameworkR.activeController.humanoid,
                    CombatFrameworkR.activeController.rootPart,
                    weapon.Handle,
                    1
                )
            end
        end)

        -- Método 2: VirtualUser Click
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0, 0))
        end)

        -- Método 3: Direct Remote Call
        pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("Remotes")
            if remote and remote:FindFirstChild("CommF_") then
                remote.CommF_:InvokeServer("TAP")
            end
        end)

        Config.LastAttackTime = currentTime
    end

    -- Sistema de bring otimizado
    local function BringMobs()
        if not Config.AutoBring then return end

        local char = GetCharacter()
        local rootPart = GetRootPart()

        if not rootPart then return end

        local broughtCount = 0
        local maxBring = 15 -- Limitar para performance

        for _, mob in pairs(Workspace.Enemies:GetChildren()) do
            if broughtCount >= maxBring then break end

            if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                if mob.Humanoid.Health > 0 then
                    local distance = (rootPart.Position - mob.HumanoidRootPart.Position).Magnitude

                    if distance <= Config.BringDistance and distance > Config.AttackDistance then
                        local targetPos = rootPart.CFrame * CFrame.new(
                            math.random(-Config.AttackDistance/2, Config.AttackDistance/2),
                            0,
                            math.random(Config.AttackDistance/2, Config.AttackDistance)
                        )

                        pcall(function()
                            mob.HumanoidRootPart.CFrame = targetPos
                            mob.HumanoidRootPart.Anchored = true
                            mob.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
                            mob.HumanoidRootPart.CanCollide = false

                            if mob:FindFirstChild("Head") then
                                mob.Head.CanCollide = false
                            end

                            -- Desabilitar movimento
                            mob.Humanoid.WalkSpeed = 0
                            mob.Humanoid.JumpPower = 0
                            mob.Humanoid.PlatformStand = true

                            -- Desabilitar animações
                            if mob.Humanoid:FindFirstChild("Animator") then
                                mob.Humanoid.Animator:Destroy()
                            end
                        end)

                        broughtCount = broughtCount + 1
                    end
                end
            end
        end
    end

    -- Auto Buso otimizado
    local function AutoBuso()
        if not Config.AutoBuso then return end

        pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("Remotes")
            if remote and remote:FindFirstChild("CommF_") then
                remote.CommF_:InvokeServer("Buso")
            end
        end)
    end

    -- Auto Observation otimizado
    local function AutoObservation()
        if not Config.AutoObservation then return end

        pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("Remotes")
            if remote and remote:FindFirstChild("CommF_") then
                remote.CommF_:InvokeServer("KenTalk", "Buy")
            end
        end)
    end

    -- Usar skills das armas
    local function UseWeaponSkills()
        local weapon = GetWeapon()
        if not weapon then return end

        pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("Remotes")
            if remote and remote:FindFirstChild("CommF_") then
                if Config.UseSkillZ then
                    remote.CommF_:InvokeServer("TAP", "Z")
                    wait(0.1)
                end
                if Config.UseSkillX then
                    remote.CommF_:InvokeServer("TAP", "X")
                    wait(0.1)
                end
                if Config.UseSkillC then
                    remote.CommF_:InvokeServer("TAP", "C")
                    wait(0.1)
                end
                if Config.UseSkillV then
                    remote.CommF_:InvokeServer("TAP", "V")
                    wait(0.1)
                end
                if Config.UseSkillF then
                    remote.CommF_:InvokeServer("TAP", "F")
                    wait(0.1)
                end
            end
        end)
    end

    -- Quest system melhorado
    local function GetQuestForLevel(level)
        -- Sistema de quest completo
        if level >= 1 and level <= 9 then
            return {
                QuestName = "BanditQuest1",
                QuestNumber = 1,
                MobName = "Bandit",
                Level = {1, 9},
                NPCPosition = CFrame.new(1059.37195, 15.4495068, 1550.4231),
                MobPosition = CFrame.new(1045, 17, 1560)
            }
        elseif level >= 10 and level <= 14 then
            return {
                QuestName = "BanditQuest1",
                QuestNumber = 2,
                MobName = "Monkey",
                Level = {10, 14},
                NPCPosition = CFrame.new(1059.37195, 15.4495068, 1550.4231),
                MobPosition = CFrame.new(-1448, 50, 0)
            }
        elseif level >= 15 and level <= 29 then
            return {
                QuestName = "JungleQuest",
                QuestNumber = 1,
                MobName = "Gorilla",
                Level = {15, 29},
                NPCPosition = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                MobPosition = CFrame.new(-1142, 40, -515)
            }
        elseif level >= 30 and level <= 39 then
            return {
                QuestName = "JungleQuest",
                QuestNumber = 2,
                MobName = "Pirate",
                Level = {30, 39},
                NPCPosition = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                MobPosition = CFrame.new(-1169, 42, -1780)
            }
        elseif level >= 75 and level <= 89 then
            return {
                QuestName = "DesertQuest",
                QuestNumber = 1,
                MobName = "Desert Bandit",
                Level = {75, 89},
                NPCPosition = CFrame.new(894.488647, 5.14000702, 4392.43359),
                MobPosition = CFrame.new(924, 7, 4481)
            }
        elseif level >= 100 and level <= 119 then
            return {
                QuestName = "SnowQuest",
                QuestNumber = 1,
                MobName = "Snow Bandit",
                Level = {100, 119},
                NPCPosition = CFrame.new(1389.74451, 88.1519318, -1298.90796),
                MobPosition = CFrame.new(1354, 87, -1393)
            }
        elseif level >= 120 and level <= 149 then
            return {
                QuestName = "SnowQuest",
                QuestNumber = 2,
                MobName = "Snowman",
                Level = {120, 149},
                NPCPosition = CFrame.new(1389.74451, 88.1519318, -1298.90796),
                MobPosition = CFrame.new(1201, 105, -1417)
            }
        end

        return nil
    end

    local function AcceptQuest()
        if not Config.AutoQuest then return end

        pcall(function()
            local level = Player.Data.Level.Value
            local questData = GetQuestForLevel(level)

            if questData then
                local remote = ReplicatedStorage:FindFirstChild("Remotes")
                if remote and remote:FindFirstChild("CommF_") then
                    -- Teleportar para o NPC
                    if questData.NPCPosition then
                        TeleportTo(questData.NPCPosition, Config.TweenSpeed)
                        wait(2)
                    end

                    -- Aceitar quest
                    remote.CommF_:InvokeServer("StartQuest", questData.QuestName, questData.QuestNumber)

                    Config.CurrentQuest = questData.QuestName
                    Config.QuestMob = questData.MobName
                    Config.QuestLevel = questData.Level
                    Config.MobPosition = questData.MobPosition

                    wait(1)
                end
            end
        end)
    end

    -- Auto Farm Level otimizado
    local function AutoFarmLevel()
        if not Config.AutoFarmLevel then return end

        local character = GetCharacter()
        local humanoid = GetHumanoid()
        local rootPart = GetRootPart()

        if not character or not humanoid or not rootPart then return end

        -- Auto Quest
        if Config.AutoQuest then
            pcall(AcceptQuest)
        end

        -- Auto Equip Weapon
        if Config.AutoEquipWeapon and Config.SelectWeapon ~= "" then
            pcall(function() EquipWeapon(Config.SelectWeapon) end)
        end

        -- Auto Buso
        pcall(AutoBuso)

        -- Auto Observation
        pcall(AutoObservation)

        -- Auto Bring Mobs
        pcall(BringMobs)

        -- Usar skills
        if Config.UseSkillZ or Config.UseSkillX or Config.UseSkillC or Config.UseSkillV or Config.UseSkillF then
            pcall(UseWeaponSkills)
        end

        -- Encontrar mob
        local mob, distance = GetNearestMob(Config.FarmDistance * 3, Config.AutoQuest)

        if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            if mob.Humanoid.Health > 0 then
                if distance > Config.AttackDistance then
                    -- Teleportar para o mob
                    local targetPos = mob.HumanoidRootPart.CFrame * CFrame.new(0, Config.TeleportHeight, Config.AttackDistance * 0.8)
                    pcall(function() TeleportTo(targetPos, Config.TweenSpeed) end)
                else
                    -- Atacar
                    pcall(AdvancedFastAttack)
                end
            end
        elseif Config.AutoQuest and Config.MobPosition then
            -- Ir para área da quest
            pcall(function() TeleportTo(Config.MobPosition, Config.TweenSpeed) end)
        end
    end

    -- NoClip
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

    -- Anti AFK
    local function AntiAFK()
        if not Config.AntiAFK then return end

        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end

    -- Loop principal otimizado
    local function MainLoop()
        RunService.Heartbeat:Connect(function()
            pcall(AutoFarmLevel)
            pcall(NoClip)
            pcall(AntiAFK)
        end)
    end

    -- Interface Rayfield

    -- Aba Main
    local MainSection = MainTab:CreateSection("Principal")

    MainTab:CreateLabel("Neon Hub V2 - Otimizado para Blox Fruits")
    MainTab:CreateLabel("Versão: 2.1 | Autor: xzgyx")
    MainTab:CreateLabel("Status: Funcionando ✅")

    -- Aba Farm
    local FarmSection = FarmTab:CreateSection("Auto Farm Level")

    FarmTab:CreateToggle({
        Name = "Auto Farm Level",
        CurrentValue = Config.AutoFarmLevel,
        Flag = "AutoFarmLevel",
        Callback = function(Value)
            Config.AutoFarmLevel = Value
            if Value then
                Notify("Auto Farm", "Auto Farm Level ativado!", 3)
            else
                Notify("Auto Farm", "Auto Farm Level desativado!", 3)
            end
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
            if Value then
                Notify("Combat", "Fast Attack ativado!", 3)
            end
        end,
    })

    FarmTab:CreateSlider({
        Name = "Farm Distance",
        Range = {10, 100},
        Increment = 5,
        Suffix = "studs",
        CurrentValue = Config.FarmDistance,
        Flag = "FarmDistance",
        Callback = function(Value)
            Config.FarmDistance = Value
        end,
    })

    FarmTab:CreateSlider({
        Name = "Bring Distance",
        Range = {100, 1000},
        Increment = 50,
        Suffix = "studs",
        CurrentValue = Config.BringDistance,
        Flag = "BringDistance",
        Callback = function(Value)
            Config.BringDistance = Value
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

    CombatTab:CreateToggle({
        Name = "Use Skill Z",
        CurrentValue = Config.UseSkillZ,
        Flag = "UseSkillZ",
        Callback = function(Value)
            Config.UseSkillZ = Value
        end,
    })

    CombatTab:CreateToggle({
        Name = "Use Skill X",
        CurrentValue = Config.UseSkillX,
        Flag = "UseSkillX",
        Callback = function(Value)
            Config.UseSkillX = Value
        end,
    })

    CombatTab:CreateToggle({
        Name = "Use Skill C",
        CurrentValue = Config.UseSkillC,
        Flag = "UseSkillC",
        Callback = function(Value)
            Config.UseSkillC = Value
        end,
    })

    CombatTab:CreateToggle({
        Name = "Use Skill V",
        CurrentValue = Config.UseSkillV,
        Flag = "UseSkillV",
        Callback = function(Value)
            Config.UseSkillV = Value
        end,
    })

    -- Aba Weapon
    local WeaponSection = WeaponTab:CreateSection("Weapon Settings")

    WeaponTab:CreateDropdown({
        Name = "Select Weapon",
        Options = GetWeaponList(),
        CurrentOption = Config.SelectWeapon,
        Flag = "SelectWeapon",
        Callback = function(Option)
            Config.SelectWeapon = Option
            Notify("Weapon", "Arma selecionada: " .. Option, 3)
        end,
    })

    WeaponTab:CreateButton({
        Name = "Refresh Weapon List",
        Callback = function()
            local weapons = GetWeaponList()
            Notify("Weapon", "Lista atualizada! " .. #weapons .. " armas encontradas", 3)
        end,
    })

    WeaponTab:CreateToggle({
        Name = "Auto Equip Weapon",
        CurrentValue = Config.AutoEquipWeapon,
        Flag = "AutoEquipWeapon",
        Callback = function(Value)
            Config.AutoEquipWeapon = Value
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
        Name = "Anti AFK",
        CurrentValue = Config.AntiAFK,
        Flag = "AntiAFK",
        Callback = function(Value)
            Config.AntiAFK = Value
        end,
    })

    -- Aba Settings
    local SettingsSection = SettingsTab:CreateSection("Performance Settings")

    SettingsTab:CreateSlider({
        Name = "Tween Speed",
        Range = {100, 800},
        Increment = 50,
        Suffix = "speed",
        CurrentValue = Config.TweenSpeed,
        Flag = "TweenSpeed",
        Callback = function(Value)
            Config.TweenSpeed = Value
        end,
    })

    SettingsTab:CreateSlider({
        Name = "Attack Cooldown",
        Range = {0.01, 0.5},
        Increment = 0.01,
        Suffix = "s",
        CurrentValue = Config.AttackCooldown,
        Flag = "AttackCooldown",
        Callback = function(Value)
            Config.AttackCooldown = Value
        end,
    })

    -- Initialize
    print("Neon Hub V2 - Otimizado carregado!")
    print("Auto Farm: Melhorado")
    print("Fast Attack: Otimizado")
    print("Combat: Aprimorado")

    -- Start
    MainLoop()

    -- Notify
    Notify("Neon Hub V2", "Script otimizado carregado! Todas as funções foram melhoradas.", 5)

end)

if not success then
    print("Erro ao carregar o script:", error)
end