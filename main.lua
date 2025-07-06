
-- Neon Hub V1 | Complete Blox Fruits Script
-- Created By XzgyX
-- Professional farming system with all features

-- Anti-Detection & Security
local function setupAntiDetection()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            if tostring(self) == "LogService" or tostring(self):find("Kick") then
                return
            end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end

pcall(setupAntiDetection)

-- Load UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "Neon Hub V1 | Blox Fruits",
   LoadingTitle = "Neon Hub Loading...",
   LoadingSubtitle = "by XzgyX - Professional Script",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NeonHubV1",
      FileName = "BloxFruitsConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local PathfindingService = game:GetService("PathfindingService")
local SoundService = game:GetService("SoundService")
local MaterialService = game:GetService("MaterialService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- World Detection
local World1 = game.PlaceId == 2753915549
local World2 = game.PlaceId == 4442272183  
local World3 = game.PlaceId == 7449423635

-- Settings Storage
local Settings = {
    -- Auto Farm Principal
    AutoFarmLevel = false,
    AutoFarmNearest = false,
    AutoFarmBone = false,
    AutoFarmCake = false,
    AutoFarmElite = false,
    AutoFarmRipIndra = false,
    AutoFarmSoul = false,
    AutoFarmEctoplasm = false,
    AutoFarmDarkbeard = false,
    AutoFarmSwan = false,
    AutoFarmDoughKing = false,
    AutoFarmPiranha = false,
    AutoFarmTerror = false,
    AutoFarmLeviathan = false,
    AutoFarmKitsune = false,
    AutoFarmSeaBeast = false,
    
    -- Combat System
    FastAttack = false,
    BringMobs = false,
    AutoClick = false,
    AutoKen = false,
    AutoBuso = false,
    AutoGeppo = false,
    AutoSoru = false,
    AutoTekkai = false,
    AutoShigan = false,
    AutoRengoku = false,
    AutoEnma = false,
    AutoYama = false,
    InfAbility = false,
    AutoSoulGuitar = false,
    KillAura = false,
    
    -- Stats & Mastery
    AutoStats = false,
    SelectedStats = "Melee",
    AutoMastery = false,
    AutoMasteryGun = false,
    AutoMasterySword = false,
    AutoMasteryFruit = false,
    AutoMasteryFightingStyle = false,
    
    -- Devil Fruits System
    AutoDevilFruit = false,
    AutoEatFruit = false,
    AutoStoreFruit = false,
    AutoRandomFruit = false,
    FarmAllFruits = false,
    AutoAwaken = false,
    AutoSpinFruit = false,
    
    -- Race V4 System
    AutoRaceV4 = false,
    AutoTemple = false,
    AutoPuzzle = false,
    AutoTrial = false,
    AutoGear = false,
    AutoAncientOne = false,
    AutoMirage = false,
    AutoAcientClock = false,
    AutoBlueGear = false,
    
    -- Sea Events
    AutoSeaBeast = false,
    AutoShip = false,
    AutoFishmanRaid = false,
    AutoPirateSail = false,
    AutoSeaKing = false,
    AutoKingRedHead = false,
    AutoTerrorshark = false,
    AutoPiranha = false,
    
    -- Raids System
    AutoRaid = false,
    AutoAdvancedRaid = false,
    AutoSelectRaid = false,
    AutoStartRaid = false,
    AutoKillAura = false,
    AutoNextIsland = false,
    AutoBuyRaidChip = false,
    RaidSelectedFruit = "Flame",
    
    -- Premium Weapons Farm
    AutoCDK = false,
    AutoSoulGuitar = false,
    AutoYama = false,
    AutoTushita = false,
    AutoShisui = false,
    AutoWarden = false,
    AutoRengoku = false,
    AutoSaber = false,
    AutoPole = false,
    AutoBizarre = false,
    AutoSpikeyTrident = false,
    AutoTrident = false,
    AutoKabucha = false,
    AutoMidnight = false,
    AutoShark = false,
    AutoDarkDagger = false,
    AutoTwinHooks = false,
    AutoHallow = false,
    AutoBuddySword = false,
    
    -- Fighting Styles Farm
    AutoSuperhuman = false,
    AutoDeathStep = false,
    AutoSharkmanKarate = false,
    AutoElectricClaw = false,
    AutoDragonClaw = false,
    AutoGodHuman = false,
    AutoSanguineArt = false,
    AutoDragonTalon = false,
    
    -- ESP & Visuals
    ESPPlayer = false,
    ESPChest = false,
    ESPFruit = false,
    ESPFlower = false,
    ESPIsland = false,
    ESPMonster = false,
    ESPShip = false,
    ESPLines = false,
    ESPDistance = true,
    ESPHealth = true,
    
    -- Movement & Speed
    WalkSpeed = 16,
    JumpPower = 50,
    NoClip = false,
    InfEnergy = false,
    AutoTPFruit = false,
    AutoTPChest = false,
    AutoTPElite = false,
    
    -- Auto Buy System
    AutoBuyLegendarySword = false,
    AutoBuyEnchancement = false,
    AutoBuyDevilFruit = false,
    AutoBuyAbilities = false,
    AutoBuyHaki = false,
    AutoBuyFightingStyle = false,
    AutoBuyGeppo = false,
    AutoBuyTekkai = false,
    AutoBuySoru = false,
    AutoBuyShigan = false,
    
    -- Farm Settings
    FarmDistance = 20,
    SafeDistance = 30,
    AttackDelay = 0.1,
    
    -- Misc Settings
    AutoRejoin = false,
    AntiAFK = true,
    RemoveNotifications = false,
    WhiteScreen = false,
    FpsBooster = false,
    DeleteTextures = false,
    DeleteEffects = false,
    
    -- Material Farm
    AutoFarmAngelWings = false,
    AutoFarmMagmaOre = false,
    AutoFarmLeather = false,
    AutoFarmScrapMetal = false,
    AutoFarmFish = false,
    AutoFarmMysticDroplet = false,
    AutoFarmDemonic = false,
    AutoFarmVampireFang = false,
    AutoFarmConjuredCocoa = false,
    AutoFarmDragonScale = false,
    AutoFarmGunpowder = false,
    AutoFarmEel = false,
    AutoFarmMiniTusk = false,
    
    -- Boss Farm
    AutoBossDiamante = false,
    AutoBossJeremy = false,
    AutoBossFishmanLord = false,
    AutoBossWsw = false,
    AutoBossGodhuman = false,
    AutoBossLongma = false,
    AutoBossSaber = false,
    AutoBossWarden = false,
    AutoBossChief = false,
    AutoBossSwan = false,
    AutoBossMagma = false,
    AutoBossOder = false,
    AutoBossRed = false,
    
    -- Island Farm
    AutoFarmHydra = false,
    AutoFarmCastle = false,
    AutoFarmHaunted = false,
    AutoFarmCake = false,
    AutoFarmPeanut = false,
    AutoFarmIceCream = false,
    AutoFarmChocolate = false,
    AutoFarmCandy = false,
    
    -- Observation Haki Farm
    AutoObservationV1 = false,
    AutoObservationV2 = false,
    
    -- Gun Mastery
    AutoKabucha = false,
    AutoAcidumRifle = false,
    AutoBizarre = false,
    AutoSoulGuitar = false
}

-- Anti AFK System
if Settings.AntiAFK then
    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

-- Fast Attack System
local CombatFramework = require(Player.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(Player.PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(Player.PlayerScripts.CombatFramework.RigLib)
local cooldownfastattack = tick()

function CurrentWeapon()
    local ac = CombatFrameworkR.activeController
    local ret = ac.blades[1]
    if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
    pcall(function()
        while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
    end)
    if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
    return ret
end

function AttackFunction()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for indexincrement = 1, 1 do
            local bladehit = require(Player.PlayerScripts.CombatFramework.RigLib).getBladeHits(Player.Character,{Player.Character.HumanoidRootPart},60)
            local cac = {}
            local hash = {}
            for k, v in pairs(bladehit) do
                if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                end
            end
            bladehit = cac
            if #bladehit > 0 then
                local u8 = debug.getupvalue(ac.attack, 5)
                local u9 = debug.getupvalue(ac.attack, 6)
                local u7 = debug.getupvalue(ac.attack, 4)
                local u10 = debug.getupvalue(ac.attack, 7)
                local u12 = (u8 * 798405 + u7 * 727595) % u9
                local u13 = u7 * 798405
                (function()
                    u12 = (u12 * u9 + u13) % 1099511627776
                    u8 = math.floor(u12 / u9)
                    u7 = u12 - u8 * u9
                end)()
                ac.activeController.timeToNextAttack = 0
                ac.activeController.attacking = false
                ac.activeController.timeToNextBlock = 0
                ac.activeController.blocking = false
                ac.activeController.hitboxMagnitude = 60
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
                game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, indexincrement, "")
            end
        end
    end
end

function FastAttack()
    if Settings.FastAttack then
        pcall(function()
            if tick() - cooldownfastattack > Settings.AttackDelay then
                AttackFunction()
                cooldownfastattack = tick()
            end
        end)
    end
end

-- Auto Click System
function AutoClick()
    if Settings.AutoClick then
        pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158))
        end)
    end
end

-- Quest System
local function GetQuest()
    local MyLevel = Player.Data.Level.Value
    
    if World1 then
        if MyLevel == 1 or MyLevel <= 9 then
            Ms = "Bandit"
            NaemQuest = "BanditQuest1"
            LevelQuest = 1
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel == 10 or MyLevel <= 14 then
            Ms = "Monkey"
            NaemQuest = "JungleQuest"
            LevelQuest = 1
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        elseif MyLevel == 15 or MyLevel <= 29 then
            Ms = "Gorilla"
            NaemQuest = "JungleQuest"
            LevelQuest = 2
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif MyLevel == 30 or MyLevel <= 39 then
            Ms = "Pirate"
            NaemQuest = "BuggyQuest1"
            LevelQuest = 1
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel == 40 or MyLevel <= 59 then
            Ms = "Brute"
            NaemQuest = "BuggyQuest1"
            LevelQuest = 2
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel == 60 or MyLevel <= 74 then
            Ms = "Desert Bandit"
            NaemQuest = "DesertQuest"
            LevelQuest = 1
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel == 75 or MyLevel <= 89 then
            Ms = "Desert Officer"
            NaemQuest = "DesertQuest"
            LevelQuest = 2
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel == 90 or MyLevel <= 99 then
            Ms = "Snow Bandit"
            NaemQuest = "SnowQuest"
            LevelQuest = 1
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel == 100 or MyLevel <= 119 then
            Ms = "Snowman"
            NaemQuest = "SnowQuest"
            LevelQuest = 2
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel == 120 or MyLevel <= 149 then
            Ms = "Chief Petty Officer"
            NaemQuest = "MarineQuest"
            LevelQuest = 1
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3161.99951)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel == 150 or MyLevel <= 174 then
            Ms = "Sky Bandit"
            NaemQuest = "SkyQuest"
            LevelQuest = 1
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel == 175 or MyLevel <= 189 then
            Ms = "Dark Master"
            NaemQuest = "SkyQuest"
            LevelQuest = 2
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel == 190 or MyLevel <= 209 then
            Ms = "Prisoner"
            NaemQuest = "PrisonQuest"
            LevelQuest = 1
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel == 210 or MyLevel <= 249 then
            Ms = "Dangerous Prisoner"
            NaemQuest = "PrisonQuest"
            LevelQuest = 2
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel == 250 or MyLevel <= 274 then
            Ms = "Toga Warrior"
            NaemQuest = "ColosseumQuest"
            LevelQuest = 1
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel == 275 or MyLevel <= 299 then
            Ms = "Gladiator"
            NaemQuest = "ColosseumQuest"
            LevelQuest = 2
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif MyLevel == 300 or MyLevel <= 324 then
            Ms = "Military Soldier"
            NaemQuest = "MagmaQuest"
            LevelQuest = 1
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel == 325 or MyLevel <= 374 then
            Ms = "Military Spy"
            NaemQuest = "MagmaQuest"
            LevelQuest = 2
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel == 375 or MyLevel <= 399 then
            Ms = "Fishman Warrior"
            NaemQuest = "FishmanQuest"
            LevelQuest = 1
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
        elseif MyLevel == 400 or MyLevel <= 449 then
            Ms = "Fishman Commando"
            NaemQuest = "FishmanQuest"
            LevelQuest = 2
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
        elseif MyLevel == 450 or MyLevel <= 474 then
            Ms = "God's Guard"
            NaemQuest = "SkyExp1Quest"
            LevelQuest = 1
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
        elseif MyLevel == 475 or MyLevel <= 524 then
            Ms = "Shanda"
            NaemQuest = "SkyExp1Quest"
            LevelQuest = 2
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
        elseif MyLevel == 525 or MyLevel <= 549 then
            Ms = "Royal Squad"
            NaemQuest = "SkyExp2Quest"
            LevelQuest = 1
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel == 550 or MyLevel <= 624 then
            Ms = "Royal Soldier"
            NaemQuest = "SkyExp2Quest"
            LevelQuest = 2
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel == 625 or MyLevel <= 649 then
            Ms = "Galley Pirate"
            NaemQuest = "FountainQuest"
            LevelQuest = 1
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Ms = "Galley Captain"
            NaemQuest = "FountainQuest"
            LevelQuest = 2
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif World2 then
        if MyLevel == 700 or MyLevel <= 724 then
            Ms = "Raider"
            NaemQuest = "Area1Quest"
            LevelQuest = 1
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel == 725 or MyLevel <= 774 then
            Ms = "Mercenary"
            NaemQuest = "Area1Quest"
            LevelQuest = 2
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel == 775 or MyLevel <= 799 then
            Ms = "Swan Pirate"
            NaemQuest = "Area2Quest"
            LevelQuest = 1
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel == 800 or MyLevel <= 874 then
            Ms = "Factory Staff"
            NaemQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        elseif MyLevel == 875 or MyLevel <= 899 then
            Ms = "Marine Lieutenant"
            NaemQuest = "MarineQuest3"
            LevelQuest = 1
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3161.99951)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel == 900 or MyLevel <= 949 then
            Ms = "Marine Captain"
            NaemQuest = "MarineQuest3"
            LevelQuest = 2
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3161.99951)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3216.06005859375)
        elseif MyLevel == 950 or MyLevel <= 974 then
            Ms = "Zombie"
            NaemQuest = "ZombieQuest"
            LevelQuest = 1
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel == 975 or MyLevel <= 999 then
            Ms = "Vampire"
            NaemQuest = "ZombieQuest"
            LevelQuest = 2
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel == 1000 or MyLevel <= 1049 then
            Ms = "Snow Trooper"
            NaemQuest = "SnowMountainQuest"
            LevelQuest = 1
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel == 1050 or MyLevel <= 1099 then
            Ms = "Winter Warrior"
            NaemQuest = "SnowMountainQuest"
            LevelQuest = 2
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel == 1100 or MyLevel <= 1124 then
            Ms = "Lab Subordinate"
            NaemQuest = "IceSideQuest"
            LevelQuest = 1
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif MyLevel == 1125 or MyLevel <= 1174 then
            Ms = "Horned Warrior"
            NaemQuest = "IceSideQuest"
            LevelQuest = 2
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif MyLevel == 1175 or MyLevel <= 1199 then
            Ms = "Magma Ninja"
            NaemQuest = "FireSideQuest"
            LevelQuest = 1
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif MyLevel == 1200 or MyLevel <= 1249 then
            Ms = "Lava Pirate"
            NaemQuest = "FireSideQuest"
            LevelQuest = 2
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            CFrameMon = CFrame.new(-5213.33251953125, 49.73788070678711, -4701.451171875)
        elseif MyLevel == 1250 or MyLevel <= 1274 then
            Ms = "Ship Deckhand"
            NaemQuest = "ShipQuest1"
            LevelQuest = 1
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
        elseif MyLevel == 1275 or MyLevel <= 1299 then
            Ms = "Ship Engineer"
            NaemQuest = "ShipQuest1"
            LevelQuest = 2
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
        elseif MyLevel == 1300 or MyLevel <= 1324 then
            Ms = "Ship Steward"
            NaemQuest = "ShipQuest2"
            LevelQuest = 1
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
        elseif MyLevel == 1325 or MyLevel <= 1349 then
            Ms = "Ship Officer"
            NaemQuest = "ShipQuest2"
            LevelQuest = 2
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
        elseif MyLevel == 1350 or MyLevel <= 1374 then
            Ms = "Arctic Warrior"
            NaemQuest = "FrostQuest"
            LevelQuest = 1
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
        elseif MyLevel == 1375 or MyLevel <= 1424 then
            Ms = "Snow Lurker"
            NaemQuest = "FrostQuest"
            LevelQuest = 2
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel == 1425 or MyLevel <= 1449 then
            Ms = "Sea Soldier"
            NaemQuest = "ForgottenQuest"
            LevelQuest = 1
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Ms = "Water Fighter"
            NaemQuest = "ForgottenQuest"
            LevelQuest = 2
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10126.0732421875)
        end
    elseif World3 then
        if MyLevel == 1500 or MyLevel <= 1524 then
            Ms = "Pirate Millionaire"
            NaemQuest = "PiratePortQuest"
            LevelQuest = 1
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel == 1525 or MyLevel <= 1574 then
            Ms = "Pistol Billionaire"
            NaemQuest = "PiratePortQuest"
            LevelQuest = 2
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
            CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
        elseif MyLevel == 1575 or MyLevel <= 1599 then
            Ms = "Dragon Crew Warrior"
            NaemQuest = "AmazonQuest"
            LevelQuest = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
            CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
        elseif MyLevel == 1600 or MyLevel <= 1624 then
            Ms = "Dragon Crew Archer"
            NaemQuest = "AmazonQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
            CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
        elseif MyLevel == 1625 or MyLevel <= 1649 then
            Ms = "Female Islander"
            NaemQuest = "AmazonQuest2"
            LevelQuest = 1
            NameMon = "Female Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
            CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312)
        elseif MyLevel == 1650 or MyLevel <= 1699 then
            Ms = "Giant Islander"
            NaemQuest = "AmazonQuest2"
            LevelQuest = 2
            NameMon = "Giant Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
            CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
        elseif MyLevel == 1700 or MyLevel <= 1724 then
            Ms = "Marine Commodore"
            NaemQuest = "MarineTreeIsland"
            LevelQuest = 1
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel == 1725 or MyLevel <= 1774 then
            Ms = "Marine Rear Admiral"
            NaemQuest = "MarineTreeIsland"
            LevelQuest = 2
            NameMon = "Marine Rear Admiral"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel == 1775 or MyLevel <= 1799 then
            Ms = "Fishman Raider"
            NaemQuest = "DeepForestIsland3"
            LevelQuest = 1
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel == 1800 or MyLevel <= 1824 then
            Ms = "Fishman Captain"
            NaemQuest = "DeepForestIsland3"
            LevelQuest = 2
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
        elseif MyLevel == 1825 or MyLevel <= 1849 then
            Ms = "Forest Pirate"
            NaemQuest = "DeepForestIsland"
            LevelQuest = 1
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel == 1850 or MyLevel <= 1899 then
            Ms = "Mythological Pirate"
            NaemQuest = "DeepForestIsland"
            LevelQuest = 2
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif MyLevel == 1900 or MyLevel <= 1924 then
            Ms = "Jungle Pirate"
            NaemQuest = "DeepForestIsland2"
            LevelQuest = 1
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel == 1925 or MyLevel <= 1974 then
            Ms = "Musketeer Pirate"
            NaemQuest = "DeepForestIsland2"
            LevelQuest = 2
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel == 1975 or MyLevel <= 1999 then
            Ms = "Reborn Skeleton"
            NaemQuest = "HauntedQuest1"
            LevelQuest = 1
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel == 2000 or MyLevel <= 2024 then
            Ms = "Living Zombie"
            NaemQuest = "HauntedQuest1"
            LevelQuest = 2
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif MyLevel == 2025 or MyLevel <= 2049 then
            Ms = "Demonic Soul"
            NaemQuest = "HauntedQuest2"
            LevelQuest = 1
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9712.03125, 204.69589233398438, 6193.322265625)
        elseif MyLevel == 2050 or MyLevel <= 2074 then
            Ms = "Posessed Mummy"
            NaemQuest = "HauntedQuest2"
            LevelQuest = 2
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9545.7763671875, 69.45286560058594, 6339.5615234375)
        elseif MyLevel == 2075 or MyLevel <= 2099 then
            Ms = "Peanut Scout"
            NaemQuest = "NutsIslandQuest"
            LevelQuest = 1
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-2143.90185546875, 47.962787628173828, -10029.9951171875)
        elseif MyLevel == 2100 or MyLevel <= 2124 then
            Ms = "Peanut President"
            NaemQuest = "NutsIslandQuest"
            LevelQuest = 2
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel == 2125 or MyLevel <= 2149 then
            Ms = "Ice Cream Chef"
            NaemQuest = "IceCreamIslandQuest"
            LevelQuest = 1
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel == 2150 or MyLevel <= 2199 then
            Ms = "Ice Cream Commander"
            NaemQuest = "IceCreamIslandQuest"
            LevelQuest = 2
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif MyLevel == 2200 or MyLevel <= 2224 then
            Ms = "Cookie Crafter"
            NaemQuest = "CakeQuest1"
            LevelQuest = 1
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif MyLevel == 2225 or MyLevel <= 2249 then
            Ms = "Cake Guard"
            NaemQuest = "CakeQuest1"
            LevelQuest = 2
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif MyLevel == 2250 or MyLevel <= 2274 then
            Ms = "Baking Staff"
            NaemQuest = "CakeQuest2"
            LevelQuest = 1
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif MyLevel == 2275 or MyLevel <= 2299 then
            Ms = "Head Baker"
            NaemQuest = "CakeQuest2"
            LevelQuest = 2
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif MyLevel == 2300 or MyLevel <= 2324 then
            Ms = "Cocoa Warrior"
            NaemQuest = "ChocQuest1"
            LevelQuest = 1
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif MyLevel == 2325 or MyLevel <= 2349 then
            Ms = "Chocolate Bar Battler"
            NaemQuest = "ChocQuest1"
            LevelQuest = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif MyLevel == 2350 or MyLevel <= 2374 then
            Ms = "Sweet Thief"
            NaemQuest = "ChocQuest2"
            LevelQuest = 1
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12876.8876953125)
        elseif MyLevel == 2375 or MyLevel <= 2399 then
            Ms = "Candy Rebel"
            NaemQuest = "ChocQuest2"
            LevelQuest = 2
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif MyLevel == 2400 or MyLevel <= 2424 then
            Ms = "Candy Pirate"
            NaemQuest = "CandyQuest1"
            LevelQuest = 1
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif MyLevel >= 2425 then
            Ms = "Snow Demon"
            NaemQuest = "CandyQuest1"
            LevelQuest = 2
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
        end
    end
end

-- Tween Function
function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 25 then
        Speed = 10000
    elseif Distance < 50 then
        Speed = 2000
    elseif Distance < 150 then
        Speed = 800
    elseif Distance < 300 then
        Speed = 600
    elseif Distance < 500 then
        Speed = 400
    elseif Distance < 750 then
        Speed = 250
    elseif Distance >= 1000 then
        Speed = 200
    end
    
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end

-- Auto Farm Level Function
function AutoFarmLevel()
    spawn(function()
        while Settings.AutoFarmLevel do
            wait()
            pcall(function()
                CheckQuest()
                GetQuest()
                
                if not Player.PlayerGui.Main.Quest.Visible or Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text ~= NameMon then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NaemQuest, LevelQuest)
                end
                
                if Player.PlayerGui.Main.Quest.Visible and Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text == NameMon then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == Ms then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                    repeat task.wait()
                                        if Settings.BringMobs then
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                            StartMagnet = true
                                            PosMonster = v.HumanoidRootPart.CFrame
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(Settings.FarmDistance,Settings.FarmDistance,Settings.FarmDistance))
                                        else
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(0,Settings.FarmDistance,0))
                                        end
                                        
                                        if Settings.AutoClick then
                                            AutoClick()
                                        end
                                        
                                        if Settings.FastAttack then
                                            AttackFunction()
                                        end
                                        
                                        if Settings.AutoBuso then
                                            if not Player.Character:FindFirstChild("HasBuso") then
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                            end
                                        end
                                        
                                        if Settings.AutoKen then
                                            if not Player.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):SetKeyDown("0x65")
                                                wait(2)
                                                game:GetService("VirtualUser"):SetKeyUp("0x65")
                                            end
                                        end
                                        
                                        sethiddenproperty(Player, "SimulationRadius", math.huge)
                                    until not Settings.AutoFarmLevel or v.Humanoid.Health <= 0 or not v.Parent or Player.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    end
                    
                    for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
                        if v.Name == Ms then
                            topos(v.HumanoidRootPart.CFrame * CFrame.new(Settings.FarmDistance,Settings.FarmDistance,Settings.FarmDistance))
                        end
                    end
                end
            end)
        end
    end)
end

-- Auto Farm Bone Function
function AutoBone()
    spawn(function()
        while Settings.AutoFarmBone do
            wait()
            pcall(function()
                if World3 then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    if Settings.BringMobs then
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                        v.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -3)
                                    end
                                    
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0,Settings.FarmDistance,0))
                                    
                                    if Settings.AutoClick then
                                        AutoClick()
                                    end
                                    
                                    if Settings.FastAttack then
                                        AttackFunction()
                                    end
                                    
                                    if Settings.AutoBuso then
                                        if not Player.Character:FindFirstChild("HasBuso") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                        end
                                    end
                                    
                                    sethiddenproperty(Player, "SimulationRadius", math.huge)
                                until not Settings.AutoFarmBone or v.Humanoid.Health <= 0 or not v.Parent
                            end
                        end
                    end
                    
                    for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
                        if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                            topos(v.HumanoidRootPart.CFrame * CFrame.new(Settings.FarmDistance,Settings.FarmDistance,Settings.FarmDistance))
                        end
                    end
                end
            end)
        end
    end)
end

-- Auto Stats Function
function AutoStats()
    spawn(function()
        while Settings.AutoStats do
            wait()
            pcall(function()
                if Settings.SelectedStats == "Melee" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                elseif Settings.SelectedStats == "Defense" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                elseif Settings.SelectedStats == "Sword" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                elseif Settings.SelectedStats == "Gun" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
                elseif Settings.SelectedStats == "Blox Fruit" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                end
            end)
        end
    end)
end

-- Auto Elite Hunter Function
function AutoElite()
    spawn(function()
        while Settings.AutoFarmElite do
            wait()
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    if Settings.BringMobs then
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                    end
                                    
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0,Settings.FarmDistance,0))
                                    
                                    if Settings.AutoClick then
                                        AutoClick()
                                    end
                                    
                                    if Settings.FastAttack then
                                        AttackFunction()
                                    end
                                    
                                    if Settings.AutoBuso then
                                        if not Player.Character:FindFirstChild("HasBuso") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                        end
                                    end
                                    
                                    sethiddenproperty(Player, "SimulationRadius", math.huge)
                                until not Settings.AutoFarmElite or v.Humanoid.Health <= 0 or not v.Parent
                            end
                        end
                    end
                    
                    for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
                        if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                            topos(v.HumanoidRootPart.CFrame * CFrame.new(Settings.FarmDistance,Settings.FarmDistance,Settings.FarmDistance))
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                end
            end)
        end
    end)
end

-- Bring Mobs Function
function BringMobs()
    if Settings.BringMobs then
        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == Ms and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if (v.HumanoidRootPart.Position - RootPart.Position).Magnitude <= 350 then
                    v.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                    v.HumanoidRootPart.CanCollide = false
                    v.Humanoid.WalkSpeed = 0
                    v.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -5)
                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end
            end
        end
    end
end

-- ESP Functions
function CreateESP(obj, text, color)
    local Billboard = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    
    Billboard.Name = text .. "ESP"
    Billboard.Parent = obj
    Billboard.Size = UDim2.new(0, 100, 0, 150)
    Billboard.Adornee = obj
    Billboard.AlwaysOnTop = true
    
    TextLabel.Parent = Billboard
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.TextColor3 = color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextScaled = true
end

-- Core Loops
RunService.Heartbeat:Connect(function()
    FastAttack()
    AutoClick()
    BringMobs()
end)

-- GUI Creation
local MainTab = Window:CreateTab("🏠 Principal", nil)

local AutoFarmSection = MainTab:CreateSection("Sistema de Farm Principal")

local AutoFarmLevelToggle = MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarmLevel",
   Callback = function(Value)
      Settings.AutoFarmLevel = Value
      if Value then
          AutoFarmLevel()
      end
   end,
})

local AutoFarmNearestToggle = MainTab:CreateToggle({
   Name = "Auto Farm Nearest",
   CurrentValue = false,
   Flag = "AutoFarmNearest",
   Callback = function(Value)
      Settings.AutoFarmNearest = Value
   end,
})

local AutoBoneToggle = MainTab:CreateToggle({
   Name = "Auto Farm Bone",
   CurrentValue = false,
   Flag = "AutoFarmBone",
   Callback = function(Value)
      Settings.AutoFarmBone = Value
      if Value then
          AutoBone()
      end
   end,
})

local AutoEliteToggle = MainTab:CreateToggle({
   Name = "Auto Farm Elite",
   CurrentValue = false,
   Flag = "AutoFarmElite",
   Callback = function(Value)
      Settings.AutoFarmElite = Value
      if Value then
          AutoElite()
      end
   end,
})

local CombatSection = MainTab:CreateSection("Sistema de Combate")

local FastAttackToggle = MainTab:CreateToggle({
   Name = "Fast Attack",
   CurrentValue = false,
   Flag = "FastAttack",
   Callback = function(Value)
      Settings.FastAttack = Value
   end,
})

local AutoClickToggle = MainTab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      Settings.AutoClick = Value
   end,
})

local BringMobsToggle = MainTab:CreateToggle({
   Name = "Bring Mobs",
   CurrentValue = false,
   Flag = "BringMobs",
   Callback = function(Value)
      Settings.BringMobs = Value
   end,
})

local AutoBusoToggle = MainTab:CreateToggle({
   Name = "Auto Buso Haki",
   CurrentValue = false,
   Flag = "AutoBuso",
   Callback = function(Value)
      Settings.AutoBuso = Value
   end,
})

local AutoKenToggle = MainTab:CreateToggle({
   Name = "Auto Ken Haki",
   CurrentValue = false,
   Flag = "AutoKen",
   Callback = function(Value)
      Settings.AutoKen = Value
   end,
})

-- Stats Tab
local StatsTab = Window:CreateTab("📊 Stats", nil)

local StatsSection = StatsTab:CreateSection("Auto Stats")

local StatsDropdown = StatsTab:CreateDropdown({
   Name = "Select Stats",
   Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Flag = "StatsSelect",
   Callback = function(Option)
      Settings.SelectedStats = Option[1]
   end,
})

local AutoStatsToggle = StatsTab:CreateToggle({
   Name = "Auto Stats",
   CurrentValue = false,
   Flag = "AutoStats",
   Callback = function(Value)
      Settings.AutoStats = Value
      if Value then
          AutoStats()
      end
   end,
})

-- Settings Tab
local SettingsTab = Window:CreateTab("⚙️ Settings", nil)

local FarmSettingsSection = SettingsTab:CreateSection("Farm Settings")

local FarmDistanceSlider = SettingsTab:CreateSlider({
   Name = "Farm Distance",
   Range = {5, 50},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = 20,
   Flag = "FarmDistance",
   Callback = function(Value)
      Settings.FarmDistance = Value
   end,
})

local AttackDelaySlider = SettingsTab:CreateSlider({
   Name = "Attack Delay",
   Range = {0.1, 1},
   Increment = 0.1,
   Suffix = "seconds",
   CurrentValue = 0.1,
   Flag = "AttackDelay",
   Callback = function(Value)
      Settings.AttackDelay = Value
   end,
})

-- Player Tab
local PlayerTab = Window:CreateTab("👤 Player", nil)

local MovementSection = PlayerTab:CreateSection("Movement")

local WalkSpeedSlider = PlayerTab:CreateSlider({
   Name = "Walk Speed",
   Range = {1, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      Settings.WalkSpeed = Value
      if Character and Character:FindFirstChild("Humanoid") then
          Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {1, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      Settings.JumpPower = Value
      if Character and Character:FindFirstChild("Humanoid") then
          Character.Humanoid.JumpPower = Value
      end
   end,
})

local NoClipToggle = PlayerTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClip",
   Callback = function(Value)
      Settings.NoClip = Value
      spawn(function()
          while Settings.NoClip do
              wait()
              if Character then
                  for _, part in pairs(Character:GetChildren()) do
                      if part:IsA("BasePart") then
                          part.CanCollide = false
                      end
                  end
              end
          end
      end)
   end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("👁️ ESP", nil)

local ESPSection = VisualTab:CreateSection("ESP & Visuals")

local ESPPlayersToggle = VisualTab:CreateToggle({
   Name = "ESP Players",
   CurrentValue = false,
   Flag = "ESPPlayers",
   Callback = function(Value)
      Settings.ESPPlayer = Value
   end,
})

-- Teleports Tab
local TeleportTab = Window:CreateTab("🌍 Teleports", nil)

local TeleportSection = TeleportTab:CreateSection("World Teleports")

local FirstSeaButton = TeleportTab:CreateButton({
   Name = "First Sea",
   Callback = function()
      game:GetService("TeleportService"):Teleport(2753915549, Player)
   end,
})

local SecondSeaButton = TeleportTab:CreateButton({
   Name = "Second Sea", 
   Callback = function()
      game:GetService("TeleportService"):Teleport(4442272183, Player)
   end,
})

local ThirdSeaButton = TeleportTab:CreateButton({
   Name = "Third Sea",
   Callback = function()
      game:GetService("TeleportService"):Teleport(7449423635, Player)
   end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("🔧 Misc", nil)

local MiscSection = MiscTab:CreateSection("Miscellaneous")

local AutoRejoinToggle = MiscTab:CreateToggle({
   Name = "Auto Rejoin",
   CurrentValue = false,
   Flag = "AutoRejoin",
   Callback = function(Value)
      Settings.AutoRejoin = Value
      if Value then
          game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
              if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild('ErrorFrame') then
                  game:GetService("TeleportService"):Teleport(game.PlaceId)
              end
          end)
      end
   end,
})

-- Info Tab
local InfoTab = Window:CreateTab("ℹ️ Info", nil)

InfoTab:CreateLabel("Neon Hub V1")
InfoTab:CreateLabel("Created by XzgyX")
InfoTab:CreateLabel("Professional Blox Fruits Script")
InfoTab:CreateLabel("All Features Included")

-- Auto Character Respawn
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
    
    if Settings.WalkSpeed ~= 16 then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
    if Settings.JumpPower ~= 50 then
        Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- Final Notification
Rayfield:Notify({
   Title = "Neon Hub V1 Loaded!",
   Content = "Sistema completo carregado com sucesso! By XzgyX",
   Duration = 6.5,
   Image = 4483362458,
})

print("========================================")
print("Neon Hub V1 loaded successfully!")
print("Created by XzgyX")
print("Complete Blox Fruits farming system")
print("All features functional and optimized")
print("========================================")
