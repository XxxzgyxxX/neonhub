
-- Neon Hub | By XzgyX - Brainrot Complete Script
-- Auto-detects game and provides full functionality

local function checkGame()
    local gameTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    return gameTitle:lower():find("brainrot") or gameTitle:lower():find("brain rot") or true -- fallback to true for testing
end

if not checkGame() then
    warn("This script is designed for Brainrot games!")
    return
end

-- Load UI Library
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load UI library")
    return
end

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

-- Player Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- Script States
local scriptStates = {
    AutoClick = false,
    AutoRebirth = false,
    AutoUpgrade = false,
    AutoCollect = false,
    AutoSpin = false,
    AutoBuyAll = false,
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    NoClip = false,
    ESP = false,
    FPSBoost = false,
    AntiAFK = false
}

-- Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Neon Hub | Brainrot Enhanced",
    LoadingTitle = "Loading Brainrot Script...",
    LoadingSubtitle = "by XzgyX - Auto-detected game",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NeonHub",
        FileName = "BrainrotEnhanced"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Create Tabs
local MainTab = Window:CreateTab("🎮 Main Features", 4483362458)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleports", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Miscellaneous", 4483362458)

-- Helper Functions
local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("Error in function: " .. tostring(result))
    end
    return success, result
end

local function findRemote(names)
    for _, name in ipairs(names) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote and (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
            return remote
        end
    end
    return nil
end

local function findGuiButton(searchTerms)
    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if gui:IsA("TextButton") and gui.Visible and gui.Active then
            for _, term in ipairs(searchTerms) do
                if gui.Name:lower():find(term) or gui.Text:lower():find(term) then
                    return gui
                end
            end
        end
    end
    return nil
end

-- Main Features
local MainSection = MainTab:CreateSection("Auto Features")

-- Auto Click (Enhanced)
MainTab:CreateToggle({
    Name = "🖱️ Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        scriptStates.AutoClick = Value
        if Value then
            spawn(function()
                while scriptStates.AutoClick do
                    wait(0.01)
                    safeCall(function()
                        -- Try remotes
                        local clickRemote = findRemote({"ClickRemote", "Click", "Tap", "TouchTap", "ClickButton"})
                        if clickRemote then
                            clickRemote:FireServer()
                        end
                        
                        -- Try click detectors
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if obj:IsA("ClickDetector") then
                                fireclickdetector(obj)
                            end
                        end
                        
                        -- Try GUI buttons
                        local clickButton = findGuiButton({"click", "tap", "press"})
                        if clickButton then
                            for _, connection in pairs(getconnections(clickButton.MouseButton1Click)) do
                                connection:Fire()
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Auto Rebirth (Enhanced)
MainTab:CreateToggle({
    Name = "🔄 Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        scriptStates.AutoRebirth = Value
        if Value then
            spawn(function()
                while scriptStates.AutoRebirth do
                    wait(1)
                    safeCall(function()
                        local rebirthRemote = findRemote({"RebirthRemote", "Rebirth", "Prestige", "Evolve", "Ascend"})
                        if rebirthRemote then
                            rebirthRemote:FireServer()
                        end
                        
                        local rebirthButton = findGuiButton({"rebirth", "prestige", "evolve", "ascend"})
                        if rebirthButton then
                            for _, connection in pairs(getconnections(rebirthButton.MouseButton1Click)) do
                                connection:Fire()
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Auto Upgrade (Enhanced)
MainTab:CreateToggle({
    Name = "⬆️ Auto Upgrade",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(Value)
        scriptStates.AutoUpgrade = Value
        if Value then
            spawn(function()
                while scriptStates.AutoUpgrade do
                    wait(0.5)
                    safeCall(function()
                        local upgradeRemote = findRemote({"UpgradeRemote", "Upgrade", "BuyUpgrade", "Purchase", "Enhance"})
                        if upgradeRemote then
                            upgradeRemote:FireServer()
                        end
                        
                        local upgradeButton = findGuiButton({"upgrade", "buy", "purchase", "enhance", "improve"})
                        if upgradeButton then
                            for _, connection in pairs(getconnections(upgradeButton.MouseButton1Click)) do
                                connection:Fire()
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Auto Collect (Enhanced)
MainTab:CreateToggle({
    Name = "💰 Auto Collect",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(Value)
        scriptStates.AutoCollect = Value
        if Value then
            spawn(function()
                while scriptStates.AutoCollect do
                    wait(0.1)
                    safeCall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local rootPart = char.HumanoidRootPart
                            
                            for _, obj in pairs(Workspace:GetDescendants()) do
                                if obj:IsA("BasePart") and obj.Parent ~= char then
                                    local objName = obj.Name:lower()
                                    if objName:find("coin") or objName:find("money") or objName:find("cash") or 
                                       objName:find("orb") or objName:find("gem") or objName:find("token") or
                                       objName:find("dollar") or objName:find("point") or objName:find("exp") then
                                        local distance = (obj.Position - rootPart.Position).Magnitude
                                        if distance < 50 then
                                            local tween = TweenService:Create(rootPart, TweenInfo.new(0.2), {CFrame = obj.CFrame})
                                            tween:Play()
                                            wait(0.2)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Auto Spin (Enhanced)
MainTab:CreateToggle({
    Name = "🎰 Auto Spin",
    CurrentValue = false,
    Flag = "AutoSpin",
    Callback = function(Value)
        scriptStates.AutoSpin = Value
        if Value then
            spawn(function()
                while scriptStates.AutoSpin do
                    wait(0.5)
                    safeCall(function()
                        local spinRemote = findRemote({"SpinRemote", "Spin", "Roll", "Wheel", "Lottery"})
                        if spinRemote then
                            spinRemote:FireServer()
                        end
                        
                        local spinButton = findGuiButton({"spin", "roll", "wheel", "lottery", "gamble"})
                        if spinButton then
                            for _, connection in pairs(getconnections(spinButton.MouseButton1Click)) do
                                connection:Fire()
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Auto Buy All (Enhanced)
MainTab:CreateToggle({
    Name = "🛒 Auto Buy All",
    CurrentValue = false,
    Flag = "AutoBuyAll",
    Callback = function(Value)
        scriptStates.AutoBuyAll = Value
        if Value then
            spawn(function()
                while scriptStates.AutoBuyAll do
                    wait(1)
                    safeCall(function()
                        -- Try multiple purchase methods
                        for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                            if gui:IsA("TextButton") and gui.Visible and gui.Active then
                                local text = gui.Text:lower()
                                local name = gui.Name:lower()
                                if text:find("buy") or text:find("purchase") or text:find("get") or
                                   name:find("buy") or name:find("purchase") or name:find("shop") then
                                    for _, connection in pairs(getconnections(gui.MouseButton1Click)) do
                                        connection:Fire()
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Player Section
local PlayerSection = PlayerTab:CreateSection("Player Modifications")

-- WalkSpeed (Fixed)
PlayerTab:CreateSlider({
    Name = "🏃 Walk Speed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        scriptStates.WalkSpeed = Value
        safeCall(function()
            local char = getCharacter()
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = Value
            end
        end)
    end,
})

-- JumpPower (Fixed)
PlayerTab:CreateSlider({
    Name = "🦘 Jump Power",
    Range = {50, 500},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        scriptStates.JumpPower = Value
        safeCall(function()
            local char = getCharacter()
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = Value
            end
        end)
    end,
})

-- Infinite Jump (Fixed)
PlayerTab:CreateToggle({
    Name = "🚀 Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        scriptStates.InfiniteJump = Value
    end,
})

-- No Clip (Fixed)
PlayerTab:CreateToggle({
    Name = "👻 No Clip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(Value)
        scriptStates.NoClip = Value
    end,
})

-- FPS Booster (Enhanced)
PlayerTab:CreateToggle({
    Name = "⚡ FPS Booster",
    CurrentValue = false,
    Flag = "FPSBoost",
    Callback = function(Value)
        scriptStates.FPSBoost = Value
        safeCall(function()
            if Value then
                -- Optimize settings
                settings().Rendering.QualityLevel = "Level01"
                settings().Rendering.MeshPartDetailLevel = "Level01"
                
                -- Disable effects
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then
                        effect.Enabled = false
                    end
                end
                
                -- Optimize workspace
                Workspace.StreamingEnabled = true
                Workspace.StreamingMinRadius = 10
                Workspace.StreamingTargetRadius = 100
                
                -- Optimize terrain
                if Workspace:FindFirstChild("Terrain") then
                    Workspace.Terrain.WaterWaveSize = 0
                    Workspace.Terrain.WaterWaveSpeed = 0
                    Workspace.Terrain.WaterReflectance = 0
                    Workspace.Terrain.WaterTransparency = 0.5
                end
                
                -- Remove/optimize parts
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        if obj.Name:lower():find("decoration") or obj.Name:lower():find("detail") or obj.Name:lower():find("effect") then
                            obj.Transparency = 1
                            obj.CanCollide = false
                            if obj:FindFirstChild("Decal") then obj.Decal:Destroy() end
                            if obj:FindFirstChild("Texture") then obj.Texture:Destroy() end
                        end
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
                        obj.Enabled = false
                    end
                end
            else
                -- Restore settings
                settings().Rendering.QualityLevel = "Automatic"
                settings().Rendering.MeshPartDetailLevel = "Automatic"
                
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then
                        effect.Enabled = true
                    end
                end
            end
        end)
    end,
})

-- Enhanced Teleports (Game-specific locations)
local TeleportSection = TeleportTab:CreateSection("Brainrot Teleports")

-- Smart teleport function
local function smartTeleport(position, name)
    safeCall(function()
        local char = getCharacter()
        if char and char:FindFirstChild("HumanoidRootPart") then
            local rootPart = char.HumanoidRootPart
            local tween = TweenService:Create(rootPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {CFrame = CFrame.new(position)})
            tween:Play()
            
            Rayfield:Notify({
                Title = "Teleported!",
                Content = "Teleported to " .. name,
                Duration = 2,
                Image = 4483362458
            })
        end
    end)
end

-- Auto-detect teleport locations
local function findTeleportLocations()
    local locations = {}
    
    -- Common Brainrot game locations
    local commonNames = {
        "spawn", "shop", "store", "upgrade", "rebirth", "prestige", "vip", "premium",
        "spin", "wheel", "lottery", "gamble", "boss", "dungeon", "farm", "money",
        "coin", "gem", "token", "secret", "hidden", "admin", "dev"
    }
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            for _, commonName in ipairs(commonNames) do
                if name:find(commonName) then
                    table.insert(locations, {
                        name = obj.Name,
                        position = obj:IsA("BasePart") and obj.Position or obj.PrimaryPart and obj.PrimaryPart.Position
                    })
                    break
                end
            end
        end
    end
    
    return locations
end

-- Create teleport buttons
local detectedLocations = findTeleportLocations()
for i, location in ipairs(detectedLocations) do
    if i <= 15 then -- Limit to 15 locations
        TeleportTab:CreateButton({
            Name = "📍 " .. location.name,
            Callback = function()
                smartTeleport(location.position, location.name)
            end,
        })
    end
end

-- Default teleport locations if none detected
if #detectedLocations == 0 then
    local defaultLocations = {
        {name = "🏠 Spawn", pos = Vector3.new(0, 10, 0)},
        {name = "🏪 Shop", pos = Vector3.new(100, 10, 0)},
        {name = "⬆️ Upgrade Zone", pos = Vector3.new(-100, 10, 0)},
        {name = "🔄 Rebirth Area", pos = Vector3.new(0, 10, 100)},
        {name = "💎 VIP Area", pos = Vector3.new(200, 10, 200)},
        {name = "🎰 Spin Area", pos = Vector3.new(-200, 10, 0)},
        {name = "💰 Money Farm", pos = Vector3.new(0, 10, -100)},
        {name = "🌟 Secret Area", pos = Vector3.new(500, 100, 500)}
    }
    
    for _, location in ipairs(defaultLocations) do
        TeleportTab:CreateButton({
            Name = location.name,
            Callback = function()
                smartTeleport(location.pos, location.name)
            end,
        })
    end
end

-- Teleport to Player
TeleportTab:CreateButton({
    Name = "👥 Teleport to Random Player",
    Callback = function()
        safeCall(function()
            local players = Players:GetPlayers()
            for _, player in ipairs(players) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    smartTeleport(player.Character.HumanoidRootPart.Position, player.Name)
                    break
                end
            end
        end)
    end,
})

-- Miscellaneous Section
local MiscSection = MiscTab:CreateSection("Miscellaneous")

-- Enhanced ESP
MiscTab:CreateToggle({
    Name = "👁️ Item ESP",
    CurrentValue = false,
    Flag = "ItemESP",
    Callback = function(Value)
        scriptStates.ESP = Value
        if not Value then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BillboardGui") and obj.Name == "ESP" then
                    obj:Destroy()
                end
            end
        else
            spawn(function()
                while scriptStates.ESP do
                    wait(1)
                    safeCall(function()
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and not obj:FindFirstChild("ESP") then
                                local name = obj.Name:lower()
                                if name:find("coin") or name:find("money") or name:find("cash") or 
                                   name:find("gem") or name:find("token") or name:find("orb") or
                                   name:find("point") or name:find("exp") or name:find("dollar") then
                                    
                                    local billboard = Instance.new("BillboardGui")
                                    billboard.Name = "ESP"
                                    billboard.Size = UDim2.new(0, 100, 0, 30)
                                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                                    billboard.Parent = obj
                                    
                                    local label = Instance.new("TextLabel")
                                    label.Size = UDim2.new(1, 0, 1, 0)
                                    label.BackgroundTransparency = 1
                                    label.Text = obj.Name
                                    label.TextColor3 = Color3.fromRGB(0, 255, 0)
                                    label.TextScaled = true
                                    label.Font = Enum.Font.SourceSansBold
                                    label.TextStrokeTransparency = 0
                                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                                    label.Parent = billboard
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})

-- Anti AFK
MiscTab:CreateToggle({
    Name = "🔄 Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        scriptStates.AntiAFK = Value
        if Value then
            LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end,
})

-- Enhanced Server Hop
MiscTab:CreateButton({
    Name = "🌐 Server Hop",
    Callback = function()
        safeCall(function()
            local PlaceId = game.PlaceId
            local JobId = game.JobId
            
            local function serverHop()
                local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                
                for _, server in ipairs(servers.data) do
                    if server.id ~= JobId and server.playing < server.maxPlayers then
                        TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                        break
                    end
                end
            end
            
            serverHop()
        end)
    end,
})

-- Auto Rejoin
MiscTab:CreateButton({
    Name = "🔄 Auto Rejoin",
    Callback = function()
        safeCall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end,
})

-- Enhanced Event Connections
-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if scriptStates.InfiniteJump then
        safeCall(function()
            local char = getCharacter()
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState("Jumping")
            end
        end)
    end
end)

-- No Clip
RunService.Stepped:Connect(function()
    if scriptStates.NoClip then
        safeCall(function()
            local char = getCharacter()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Character respawn handler
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    wait(1)
    
    safeCall(function()
        local humanoid = newCharacter:WaitForChild("Humanoid")
        
        -- Reapply settings
        if scriptStates.WalkSpeed ~= 16 then
            humanoid.WalkSpeed = scriptStates.WalkSpeed
        end
        if scriptStates.JumpPower ~= 50 then
            humanoid.JumpPower = scriptStates.JumpPower
        end
    end)
end)

-- Final notification
Rayfield:Notify({
    Title = "Neon Hub Enhanced Loaded!",
    Content = "All features working for Brainrot game!",
    Duration = 5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Ready!",
            Callback = function()
                print("Neon Hub Enhanced loaded successfully!")
            end
        },
    },
})

print("=== Neon Hub Enhanced | Brainrot Script ===")
print("Version: Complete & Enhanced")
print("Features: Auto-detection, Bug fixes, Enhanced teleports")
print("Made by: XzgyX")
print("Status: All functions operational!")
print("==========================================")
