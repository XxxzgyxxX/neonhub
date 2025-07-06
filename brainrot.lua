-- Neon Hub - Auto Game Detection Script
-- Created by XzgyX

-- Game Detection Function
local function getGameName()
    local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    return gameInfo.Name or "Unknown Game"
end

-- Wait for game to load
repeat wait() until game:IsLoaded()

local gameName = getGameName()
print("Detected Game: " .. gameName)

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window with Game Name
local Window = Rayfield:CreateWindow({
   Name = "Neon Hub - " .. gameName .. " | By XzgyX",
   LoadingTitle = "Loading " .. gameName .. " Script...",
   LoadingSubtitle = "by XzgyX",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NeonHub",
      FileName = "Config_" .. tostring(game.PlaceId)
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

-- Player Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Script States
local ScriptStates = {
    AutoClick = false,
    AutoRebirth = false,
    AutoUpgrade = false,
    AutoCollect = false,
    AutoSpin = false,
    AutoBuyAll = false,
    ESP = false,
    NoClip = false,
    InfiniteJump = false,
    AntiAFK = false
}

-- Game Detection System
local GameDetection = {
    Remotes = {},
    Collectibles = {},
    TeleportLocations = {},
    ClickTargets = {}
}

-- Detect Game Elements
local function detectGameElements()
    -- Detect Remotes
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("click") or name:find("tap") then
                table.insert(GameDetection.Remotes, {Type = "Click", Remote = remote})
            elseif name:find("rebirth") or name:find("prestige") then
                table.insert(GameDetection.Remotes, {Type = "Rebirth", Remote = remote})
            elseif name:find("upgrade") or name:find("buy") then
                table.insert(GameDetection.Remotes, {Type = "Upgrade", Remote = remote})
            elseif name:find("spin") or name:find("roll") then
                table.insert(GameDetection.Remotes, {Type = "Spin", Remote = remote})
            end
        end
    end

    -- Detect Collectibles
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("coin") or name:find("money") or name:find("cash") or 
               name:find("gem") or name:find("token") or name:find("orb") then
                table.insert(GameDetection.Collectibles, obj)
            end
        end
    end

    -- Detect Teleport Locations
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("spawn") or name:find("shop") or name:find("upgrade") or
               name:find("rebirth") or name:find("vip") or name:find("secret") then
                local position = obj:IsA("Model") and obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position
                if position then
                    GameDetection.TeleportLocations[obj.Name] = position
                end
            end
        end
    end

    print("Detected " .. #GameDetection.Remotes .. " remotes")
    print("Detected " .. #GameDetection.Collectibles .. " collectibles")
    print("Detected " .. #GameDetection.TeleportLocations .. " teleport locations")
end

-- Run detection
detectGameElements()

-- Create Tabs
local MainTab = Window:CreateTab("🎮 Auto Farm", 4483362458)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleports", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

-- Auto Click Function
MainTab:CreateToggle({
   Name = "🖱️ Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      ScriptStates.AutoClick = Value
      if Value then
         spawn(function()
            while ScriptStates.AutoClick do
               wait(0.01)
               -- Use detected remotes
               for _, remoteData in pairs(GameDetection.Remotes) do
                   if remoteData.Type == "Click" then
                       pcall(function()
                           remoteData.Remote:FireServer()
                       end)
                   end
               end

               -- Click detectors
               for _, obj in pairs(Workspace:GetDescendants()) do
                   if obj:IsA("ClickDetector") then
                       pcall(function()
                           fireclickdetector(obj)
                       end)
                   end
               end

               -- GUI clicking
               for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                   if gui:IsA("TextButton") and gui.Visible and gui.Parent.Visible then
                       local text = gui.Text:lower()
                       local name = gui.Name:lower()
                       if text:find("click") or text:find("tap") or name:find("click") or name:find("tap") then
                           pcall(function()
                               for _, connection in pairs(getconnections(gui.MouseButton1Click)) do
                                   connection:Fire()
                               end
                           end)
                       end
                   end
               end
            end
         end)
      end
   end,
})

-- Auto Rebirth
MainTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      ScriptStates.AutoRebirth = Value
      if Value then
         spawn(function()
            while ScriptStates.AutoRebirth do
               wait(2)
               for _, remoteData in pairs(GameDetection.Remotes) do
                   if remoteData.Type == "Rebirth" then
                       pcall(function()
                           remoteData.Remote:FireServer()
                       end)
                   end
               end

               -- GUI rebirth
               for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                   if gui:IsA("TextButton") and gui.Visible then
                       local text = gui.Text:lower()
                       if text:find("rebirth") or text:find("prestige") then
                           pcall(function()
                               for _, connection in pairs(getconnections(gui.MouseButton1Click)) do
                                   connection:Fire()
                               end
                           end)
                       end
                   end
               end
            end
         end)
      end
   end,
})

-- Auto Upgrade
MainTab:CreateToggle({
   Name = "⬆️ Auto Upgrade",
   CurrentValue = false,
   Flag = "AutoUpgrade",
   Callback = function(Value)
      ScriptStates.AutoUpgrade = Value
      if Value then
         spawn(function()
            while ScriptStates.AutoUpgrade do
               wait(1)
               for _, remoteData in pairs(GameDetection.Remotes) do
                   if remoteData.Type == "Upgrade" then
                       pcall(function()
                           remoteData.Remote:FireServer()
                       end)
                   end
               end

               -- GUI upgrades
               for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                   if gui:IsA("TextButton") and gui.Visible then
                       local text = gui.Text:lower()
                       if text:find("upgrade") or text:find("buy") then
                           pcall(function()
                               for _, connection in pairs(getconnections(gui.MouseButton1Click)) do
                                   connection:Fire()
                               end
                           end)
                       end
                   end
               end
            end
         end)
      end
   end,
})

-- Auto Collect
MainTab:CreateToggle({
   Name = "💰 Auto Collect",
   CurrentValue = false,
   Flag = "AutoCollect",
   Callback = function(Value)
      ScriptStates.AutoCollect = Value
      if Value then
         spawn(function()
            while ScriptStates.AutoCollect do
               wait(0.1)
               if Character and RootPart then
                   for _, collectible in pairs(GameDetection.Collectibles) do
                       if collectible and collectible.Parent then
                           local distance = (collectible.Position - RootPart.Position).Magnitude
                           if distance < 200 then
                               pcall(function()
                                   RootPart.CFrame = collectible.CFrame
                               end)
                               wait(0.1)
                           end
                       end
                   end

                   -- Re-detect new collectibles
                   for _, obj in pairs(Workspace:GetDescendants()) do
                       if obj:IsA("BasePart") and obj.Parent ~= Character then
                           local name = obj.Name:lower()
                           if name:find("coin") or name:find("money") or name:find("cash") or 
                              name:find("gem") or name:find("token") or name:find("orb") then
                               local distance = (obj.Position - RootPart.Position).Magnitude
                               if distance < 100 then
                                   pcall(function()
                                       RootPart.CFrame = obj.CFrame
                                   end)
                                   wait(0.1)
                               end
                           end
                       end
                   end
               end
            end
         end)
      end
   end,
})

-- Auto Spin
MainTab:CreateToggle({
   Name = "🎰 Auto Spin",
   CurrentValue = false,
   Flag = "AutoSpin",
   Callback = function(Value)
      ScriptStates.AutoSpin = Value
      if Value then
         spawn(function()
            while ScriptStates.AutoSpin do
               wait(1)
               for _, remoteData in pairs(GameDetection.Remotes) do
                   if remoteData.Type == "Spin" then
                       pcall(function()
                           remoteData.Remote:FireServer()
                       end)
                   end
               end
            end
         end)
      end
   end,
})

-- Player Modifications
PlayerTab:CreateSlider({
   Name = "🏃 Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      if Character and Humanoid then
         Humanoid.WalkSpeed = Value
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "🦘 Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if Character and Humanoid then
         Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "🚀 Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      ScriptStates.InfiniteJump = Value
   end,
})

PlayerTab:CreateToggle({
   Name = "👻 No Clip",
   CurrentValue = false,
   Flag = "NoClip",
   Callback = function(Value)
      ScriptStates.NoClip = Value
   end,
})

-- Teleports (Dynamic based on detection)
TeleportTab:CreateSection("📍 Auto-Detected Locations")

local function safeTeleport(position)
   if Character and RootPart then
       pcall(function()
           RootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
       end)
   end
end

-- Add detected teleport locations
for locationName, position in pairs(GameDetection.TeleportLocations) do
   TeleportTab:CreateButton({
      Name = "📍 " .. locationName,
      Callback = function()
         safeTeleport(position)
      end,
   })
end

-- Common teleport locations if none detected
if next(GameDetection.TeleportLocations) == nil then
    local commonLocations = {
        ["🏠 Spawn"] = Vector3.new(0, 10, 0),
        ["🏪 Shop"] = Vector3.new(100, 10, 0),
        ["⬆️ Upgrade"] = Vector3.new(-100, 10, 0),
        ["🔄 Rebirth"] = Vector3.new(0, 10, 100),
        ["💎 VIP"] = Vector3.new(200, 10, 200),
    }

    for name, pos in pairs(commonLocations) do
        TeleportTab:CreateButton({
           Name = name,
           Callback = function()
              safeTeleport(pos)
           end,
        })
    end
end

-- Miscellaneous
MiscTab:CreateToggle({
   Name = "👁️ Item ESP",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
      ScriptStates.ESP = Value
      if not Value then
         for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") and obj.Name == "ESP_Neon" then
               obj:Destroy()
            end
         end
      else
         spawn(function()
            while ScriptStates.ESP do
               wait(2)
               for _, obj in pairs(Workspace:GetDescendants()) do
                  if obj:IsA("BasePart") and not obj:FindFirstChild("ESP_Neon") then
                     local name = obj.Name:lower()
                     if name:find("coin") or name:find("money") or name:find("cash") or 
                        name:find("gem") or name:find("token") or name:find("orb") then

                        pcall(function()
                           local billboard = Instance.new("BillboardGui")
                           billboard.Name = "ESP_Neon"
                           billboard.Size = UDim2.new(0, 100, 0, 50)
                           billboard.StudsOffset = Vector3.new(0, 3, 0)
                           billboard.Parent = obj

                           local label = Instance.new("TextLabel")
                           label.Size = UDim2.new(1, 0, 1, 0)
                           label.BackgroundTransparency = 1
                           label.Text = obj.Name
                           label.TextColor3 = Color3.new(0, 1, 0)
                           label.TextScaled = true
                           label.Font = Enum.Font.SourceSansBold
                           label.TextStrokeTransparency = 0
                           label.Parent = billboard
                        end)
                     end
                  end
               end
            end
         end)
      end
   end,
})

MiscTab:CreateToggle({
   Name = "🔄 Anti AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
      ScriptStates.AntiAFK = Value
      if Value then
         LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
         end)
      end
   end,
})

MiscTab:CreateButton({
   Name = "🌐 Server Hop",
   Callback = function()
      local Http = game:GetService("HttpService")
      local TPS = game:GetService("TeleportService")
      local Api = "https://games.roblox.com/v1/games/"

      local PlaceId = game.PlaceId

      pcall(function()
         local Site = game:HttpGet(Api..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
         local body = Http:JSONDecode(Site)

         if body and body.data then
            for _, server in pairs(body.data) do
               if tonumber(server.maxPlayers) > tonumber(server.playing) then
                  TPS:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                  break
               end
            end
         end
      end)
   end,
})

MiscTab:CreateButton({
   Name = "🔄 Rejoin Server",
   Callback = function()
      TeleportService:Teleport(game.PlaceId, LocalPlayer)
   end,
})

-- Event Connections
UserInputService.JumpRequest:Connect(function()
   if ScriptStates.InfiniteJump and Character and Humanoid then
      Humanoid:ChangeState("Jumping")
   end
end)

RunService.Stepped:Connect(function()
   if ScriptStates.NoClip and Character then
      for _, part in pairs(Character:GetDescendants()) do
         if part:IsA("BasePart") then
            part.CanCollide = false
         end
      end
   end
end)

-- Character respawn handler
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
   Character = newCharacter
   wait(1)
   Humanoid = Character:WaitForChild("Humanoid")
   RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Refresh detection periodically
spawn(function()
    while true do
        wait(30)
        detectGameElements()
    end
end)

-- Success notification
Rayfield:Notify({
   Title = "Neon Hub Loaded!",
   Content = "Successfully loaded for " .. gameName,
   Duration = 5,
   Image = 4483362458,
})

print("=== Neon Hub Successfully Loaded ===")
print("Game: " .. gameName)
print("Place ID: " .. game.PlaceId)
print("By: XzgyX")
print("===================================")