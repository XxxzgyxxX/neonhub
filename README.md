--[[
    Neon Hub para Blox Fruits
    Criado por XxxzgyxxX
    Estilo similar ao Redz Hub
    Versão 1.0
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Neon Hub | Blox Fruits", "Sentinel")

-- Tabs
local MainTab = Window:NewTab("Principal")
local CombatTab = Window:NewTab("Combate")
local FarmingTab = Window:NewTab("Farm")
local TeleportTab = Window:NewTab("Teleportes")
local MiscTab = Window:NewTab("Miscelânea")
local SettingsTab = Window:NewTab("Configurações")

-- Sections
local MainSection = MainTab:NewSection("Funções Principais")
local AutoFarmSection = FarmingTab:NewSection("Farm Automático")
local CombatSection = CombatTab:NewSection("Habilidades de Combate")
local PlayerSection = CombatTab:NewSection("Jogador")
local IslandSection = TeleportTab:NewSection("Ilhas")
local DungeonSection = TeleportTab:NewSection("Masmorra")
local MiscSection = MiscTab:NewSection("Outras Funções")
local SettingsSection = SettingsTab:NewSection("Configurações UI")

-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local AutoFarm = false
local AutoNewWorld = false
local AutoThirdSea = false
local AutoBartilo = false
local AutoRipIndra = false
local AutoSaber = false
local AutoPole = false
local AutoFarmBoss = false
local AutoFarmElite = false
local AutoFarmMirage = false
local AutoKen = false
local AutoHaki = false
local AutoObservation = false
local AutoMelee = false
local AutoDefense = false
local AutoSword = false
local AutoGun = false
local AutoBloxFruit = false
local AutoBuyAbilities = false
local AutoBuso = false
local AutoKenV2 = false
local AutoFarmChest = false
local AutoFarmPirates = false
local AutoFarmMarines = false
local AutoFarmFish = false
local AutoFarmEctoplasm = false
local AutoFarmBone = false
local AutoFarmCakePrince = false
local AutoFarmDoughKing = false
local AutoFarmSwan = false
local AutoFarmDonSwan = false
local AutoFarmCursedCaptain = false

-- Functions
function TweenTo(CFrame)
    local TweenSpeed = 300
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local Distance = (HumanoidRootPart.Position - CFrame.Position).Magnitude
    local Time = Distance / TweenSpeed
    
    local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Linear)
    local Tween = game:GetService("TweenService"):Create(HumanoidRootPart, TweenInfo, {CFrame = CFrame})
    Tween:Play()
    
    Tween.Completed:Wait()
end

function GetClosestPlayer()
    local MaxDistance = math.huge
    local Target = nil
    
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
            if Distance < MaxDistance then
                MaxDistance = Distance
                Target = Player
            end
        end
    end
    
    return Target
end

function EquipTool(ToolName)
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Backpack = LocalPlayer.Backpack
    
    for _, Tool in pairs(Backpack:GetChildren()) do
        if Tool.Name == ToolName and Tool:IsA("Tool") then
            Character.Humanoid:EquipTool(Tool)
            break
        end
    end
end

function Attack()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    if Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
        VirtualInputManager:SendKeyEvent(true, "X", false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, "X", false, game)
    end
end

-- Main Section
MainSection:NewButton("Ativar Todas as Habilidades", "Ativa todas as habilidades disponíveis", function()
    AutoKen = true
    AutoHaki = true
    AutoObservation = true
    AutoMelee = true
    AutoDefense = true
    AutoSword = true
    AutoGun = true
    AutoBloxFruit = true
    AutoBuyAbilities = true
    AutoBuso = true
    AutoKenV2 = true
end)

MainSection:NewButton("Desativar Todas as Habilidades", "Desativa todas as habilidades", function()
    AutoKen = false
    AutoHaki = false
    AutoObservation = false
    AutoMelee = false
    AutoDefense = false
    AutoSword = false
    AutoGun = false
    AutoBloxFruit = false
    AutoBuyAbilities = false
    AutoBuso = false
    AutoKenV2 = false
end)

MainSection:NewToggle("Farm Automático", "Ativa o farm automático", function(State)
    AutoFarm = State
end)

MainSection:NewToggle("Farm de Chefes", "Farm automático de chefes", function(State)
    AutoFarmBoss = State
end)

MainSection:NewToggle("Farm de Elite", "Farm automático de Elite", function(State)
    AutoFarmElite = State
end)

-- Auto Farm Section
AutoFarmSection:NewToggle("Farm de Piratas", "Farm automático de piratas", function(State)
    AutoFarmPirates = State
end)

AutoFarmSection:NewToggle("Farm de Fuzileiros", "Farm automático de fuzileiros", function(State)
    AutoFarmMarines = State
end)

AutoFarmSection:NewToggle("Farm de Peixes", "Farm automático de peixes", function(State)
    AutoFarmFish = State
end)

AutoFarmSection:NewToggle("Farm de Ectoplasma", "Farm automático de ectoplasma", function(State)
    AutoFarmEctoplasm = State
end)

AutoFarmSection:NewToggle("Farm de Ossos", "Farm automático de ossos", function(State)
    AutoFarmBone = State
end)

AutoFarmSection:NewToggle("Farm de Baús", "Farm automático de baús", function(State)
    AutoFarmChest = State
end)

-- Combat Section
CombatSection:NewToggle("Auto Ken", "Ativa automaticamente o Ken", function(State)
    AutoKen = State
end)

CombatSection:NewToggle("Auto Haki", "Ativa automaticamente o Haki", function(State)
    AutoHaki = State
end)

CombatSection:NewToggle("Auto Buso Haki", "Ativa automaticamente o Buso Haki", function(State)
    AutoBuso = State
end)

CombatSection:NewToggle("Auto Observação", "Ativa automaticamente a Observação", function(State)
    AutoObservation = State
end)

CombatSection:NewToggle("Auto Ken V2", "Tenta automaticamente conseguir Ken V2", function(State)
    AutoKenV2 = State
end)

-- Player Section
PlayerSection:NewSlider("Velocidade", "Ajusta a velocidade do personagem", 500, 16, function(Value)
    LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

PlayerSection:NewSlider("Pulo", "Ajusta a altura do pulo", 350, 50, function(Value)
    LocalPlayer.Character.Humanoid.JumpPower = Value
end)

PlayerSection:NewButton("Resetar Personagem", "Reseta seu personagem", function()
    LocalPlayer.Character.Humanoid.Health = 0
end)

PlayerSection:NewButton("Nadar Infinito", "Permite nadar infinitamente", function()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
end)

-- Island Section
IslandSection:NewButton("Primeiro Mundo", "Teleporta para o Primeiro Mundo", function()
    TweenTo(CFrame.new(1000, 100, 1000))
end)

IslandSection:NewButton("Segundo Mundo", "Teleporta para o Segundo Mundo", function()
    TweenTo(CFrame.new(-1000, 100, -1000))
end)

IslandSection:NewButton("Terceiro Mundo", "Teleporta para o Terceiro Mundo", function()
    TweenTo(CFrame.new(5000, 100, 5000))
end)

-- Dungeon Section
DungeonSection:NewButton("Masmorra do Fogo", "Teleporta para a Masmorra do Fogo", function()
    TweenTo(CFrame.new(500, 100, 500))
end)

DungeonSection:NewButton("Masmorra do Gelo", "Teleporta para a Masmorra do Gelo", function()
    TweenTo(CFrame.new(-500, 100, -500))
end)

-- Misc Section
MiscSection:NewButton("Coletar Frutas", "Coleta todas as frutas próximas", function()
    -- Implementação da coleta de frutas
end)

MiscSection:NewButton("Auto Rip Indra", "Tenta automaticamente conseguir Rip Indra", function()
    AutoRipIndra = true
end)

MiscSection:NewButton("Auto Saber", "Tenta automaticamente conseguir Saber", function()
    AutoSaber = true
end)

MiscSection:NewButton("Auto Pole", "Tenta automaticamente conseguir Pole", function()
    AutoPole = true
end)

MiscSection:NewToggle("Auto New World", "Tenta automaticamente ir para o New World", function(State)
    AutoNewWorld = State
end)

MiscSection:NewToggle("Auto Third Sea", "Tenta automaticamente ir para o Third Sea", function(State)
    AutoThirdSea = State
end)

-- Settings Section
SettingsSection:NewKeybind("Tecla de Atalho", "Tecla para abrir/fechar o GUI", Enum.KeyCode.RightShift, function()
    Library:ToggleUI()
end)

SettingsSection:NewButton("Copiar Discord", "Copia o link do Discord para a área de transferência", function()
    setclipboard("discord.gg/xxxxxx")
end)

SettingsSection:NewButton("Destruir GUI", "Remove completamente a GUI", function()
    Library:Destroy()
end)

-- Main Loop
RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    -- Auto Farm
    if AutoFarm then
        -- Implementação do farm automático
    end
    
    -- Auto Skills
    if AutoKen then
        -- Ativar Ken
    end
    
    if AutoHaki then
        -- Ativar Haki
    end
    
    if AutoBuso then
        -- Ativar Buso Haki
    end
    
    if AutoObservation then
        -- Ativar Observação
    end
    
    -- Player Stats
    if AutoMelee then
        -- Farm de Melee
    end
    
    if AutoDefense then
        -- Farm de Defesa
    end
    
    if AutoSword then
        -- Farm de Espada
    end
    
    if AutoGun then
        -- Farm de Arma
    end
    
    if AutoBloxFruit then
        -- Farm de Fruta
    end
end)

-- Notificação de Inicialização
Library:Notify("Neon Hub carregado com sucesso!", 5)
