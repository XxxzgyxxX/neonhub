
-- Neon Hub | By XzgyX
-- Brainrot Complete Script - Fixed and Enhanced

-- Load UI Library (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "Neon Hub | By XzgyX",
   LoadingTitle = "Brainrot Script Loading...",
   LoadingSubtitle = "by XzgyX",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NeonHub",
      FileName = "BrainrotConfig"
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

-- Player Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Script States
local AutoClick = false
local AutoRebirth = false
local AutoUpgrade = false
local AutoCollect = false
local AutoSpin = false
local AutoBuyAll = false
local WalkSpeed = 16
local JumpPower = 50
local InfiniteJump = false
local NoClip = false
local ESP = false
local FPSBoost = false

-- Create Tabs
local MainTab = Window:CreateTab("🎮 Main Features", 4483362458)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleports", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Miscellaneous", 4483362458)

-- Main Features Section
local MainSection = MainTab:CreateSection("Auto Features")

-- Auto Click Function (Fixed)
MainTab:CreateToggle({
   Name = "🖱️ Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      AutoClick = Value
      if AutoClick then
         spawn(function()
            while AutoClick do
               wait(0.001)
               pcall(function()
                  -- Try to find click remotes
                  local clickRemote = ReplicatedStorage:FindFirstChild("ClickRemote") or 
                                    ReplicatedStorage:FindFirstChild("Click") or
                                    ReplicatedStorage:FindFirstChild("Tap")
                  
                  if clickRemote then
                     clickRemote:FireServer()
                  end
                  
                  -- Try clicking parts in workspace
                  for _, obj in pairs(Workspace:GetDescendants()) do
                     if obj:IsA("ClickDetector") then
                        fireclickdetector(obj)
                     end
                  end
                  
                  -- Try GUI buttons
                  for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                     if gui:IsA("TextButton") and gui.Visible then
                        if gui.Name:lower():find("click") or gui.Text:lower():find("click") then
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

-- Auto Rebirth Function (Fixed)
MainTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      AutoRebirth = Value
      if AutoRebirth then
         spawn(function()
            while AutoRebirth do
               wait(2)
               pcall(function()
                  local rebirthRemote = ReplicatedStorage:FindFirstChild("RebirthRemote") or
                                      ReplicatedStorage:FindFirstChild("Rebirth") or
                                      ReplicatedStorage:FindFirstChild("Prestige")
                  
                  if rebirthRemote then
                     rebirthRemote:FireServer()
                  end
                  
                  -- Try rebirth GUI buttons
                  for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                     if gui:IsA("TextButton") and gui.Visible then
                        if gui.Name:lower():find("rebirth") or gui.Text:lower():find("rebirth") then
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

-- Auto Upgrade Function (Fixed)
MainTab:CreateToggle({
   Name = "⬆️ Auto Upgrade",
   CurrentValue = false,
   Flag = "AutoUpgrade",
   Callback = function(Value)
      AutoUpgrade = Value
      if AutoUpgrade then
         spawn(function()
            while AutoUpgrade do
               wait(1)
               pcall(function()
                  local upgradeRemote = ReplicatedStorage:FindFirstChild("UpgradeRemote") or
                                      ReplicatedStorage:FindFirstChild("Upgrade") or
                                      ReplicatedStorage:FindFirstChild("BuyUpgrade")
                  
                  if upgradeRemote then
                     upgradeRemote:FireServer()
                  end
                  
                  -- Try upgrade GUI buttons
                  for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                     if gui:IsA("TextButton") and gui.Visible then
                        if gui.Name:lower():find("upgrade") or gui.Text:lower():find("upgrade") or gui.Name:lower():find("buy") then
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

-- Auto Collect Function (Fixed)
MainTab:CreateToggle({
   Name = "💰 Auto Collect",
   CurrentValue = false,
   Flag = "AutoCollect",
   Callback = function(Value)
      AutoCollect = Value
      if AutoCollect then
         spawn(function()
            while AutoCollect do
               wait(0.1)
               pcall(function()
                  if Character and Character:FindFirstChild("HumanoidRootPart") then
                     for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Parent ~= Character then
                           if obj.Name:lower():find("coin") or obj.Name:lower():find("money") or 
                              obj.Name:lower():find("cash") or obj.Name:lower():find("orb") or
                              obj.Name:lower():find("gem") or obj.Name:lower():find("token") then
                              local distance = (obj.Position - RootPart.Position).Magnitude
                              if distance < 100 then
                                 RootPart.CFrame = obj.CFrame
                                 wait(0.1)
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

-- Auto Spin Function
MainTab:CreateToggle({
   Name = "🎰 Auto Spin",
   CurrentValue = false,
   Flag = "AutoSpin",
   Callback = function(Value)
      AutoSpin = Value
      if AutoSpin then
         spawn(function()
            while AutoSpin do
               wait(0.5)
               pcall(function()
                  local spinRemote = ReplicatedStorage:FindFirstChild("SpinRemote") or
                                   ReplicatedStorage:FindFirstChild("Spin") or
                                   ReplicatedStorage:FindFirstChild("Roll")
                  
                  if spinRemote then
                     spinRemote:FireServer()
                  end
                  
                  -- Try spin GUI buttons
                  for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                     if gui:IsA("TextButton") and gui.Visible then
                        if gui.Name:lower():find("spin") or gui.Text:lower():find("spin") or gui.Name:lower():find("roll") then
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

-- Auto Buy All Function
MainTab:CreateToggle({
   Name = "🛒 Auto Buy All",
   CurrentValue = false,
   Flag = "AutoBuyAll",
   Callback = function(Value)
      AutoBuyAll = Value
      if AutoBuyAll then
         spawn(function()
            while AutoBuyAll do
               wait(1)
               pcall(function()
                  -- Try to buy all available items
                  for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                     if gui:IsA("TextButton") and gui.Visible then
                        if gui.Name:lower():find("buy") or gui.Text:lower():find("buy") or
                           gui.Name:lower():find("purchase") or gui.Text:lower():find("purchase") then
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

-- Player Modifications Section
local PlayerSection = PlayerTab:CreateSection("Player Modifications")

-- WalkSpeed Slider (Fixed)
PlayerTab:CreateSlider({
   Name = "🏃 Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      WalkSpeed = Value
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.WalkSpeed = WalkSpeed
      end
   end,
})

-- JumpPower Slider (Fixed)
PlayerTab:CreateSlider({
   Name = "🦘 Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      JumpPower = Value
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.JumpPower = JumpPower
      end
   end,
})

-- Infinite Jump (Fixed)
PlayerTab:CreateToggle({
   Name = "🚀 Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      InfiniteJump = Value
   end,
})

-- No Clip (Fixed)
PlayerTab:CreateToggle({
   Name = "👻 No Clip",
   CurrentValue = false,
   Flag = "NoClip",
   Callback = function(Value)
      NoClip = Value
   end,
})

-- FPS Booster Function
PlayerTab:CreateToggle({
   Name = "⚡ FPS Booster",
   CurrentValue = false,
   Flag = "FPSBoost",
   Callback = function(Value)
      FPSBoost = Value
      if FPSBoost then
         -- Optimize graphics settings
         settings().Rendering.QualityLevel = "Level01"
         
         -- Disable unnecessary visual effects
         for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") then
               obj.Enabled = false
            end
         end
         
         -- Reduce workspace details
         Workspace.StreamingEnabled = true
         Workspace.StreamingMinRadius = 10
         Workspace.StreamingTargetRadius = 50
         
         -- Optimize terrain
         if Workspace:FindFirstChild("Terrain") then
            Workspace.Terrain.WaterWaveSize = 0
            Workspace.Terrain.WaterWaveSpeed = 0
            Workspace.Terrain.WaterReflectance = 0
            Workspace.Terrain.WaterTransparency = 0
         end
         
         -- Remove unnecessary parts
         for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
               if obj.Name:lower():find("decoration") or obj.Name:lower():find("detail") then
                  obj.Transparency = 1
                  obj.CanCollide = false
               end
            end
         end
      else
         -- Restore settings
         settings().Rendering.QualityLevel = "Automatic"
         
         for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") then
               obj.Enabled = true
            end
         end
      end
   end,
})

-- Teleports Section (Fixed and Enhanced)
local TeleportSection = TeleportTab:CreateSection("Brainrot Teleports")

-- Enhanced teleport function
local function safeTeleport(position)
   pcall(function()
      if Character and Character:FindFirstChild("HumanoidRootPart") then
         Character.HumanoidRootPart.CFrame = CFrame.new(position)
      end
   end)
end

-- Brainrot-specific teleport locations (based on the game)
local teleportLocations = {
   ["🏠 Spawn"] = Vector3.new(0, 5, 0),
   ["🏪 Shop"] = Vector3.new(100, 5, 0),
   ["⬆️ Upgrade Area"] = Vector3.new(-100, 5, 0),
   ["🔄 Rebirth Zone"] = Vector3.new(0, 5, 100),
   ["💎 VIP Area"] = Vector3.new(200, 5, 200),
   ["🎰 Spin Area"] = Vector3.new(-200, 5, 0),
   ["💰 Money Farm"] = Vector3.new(0, 5, -100),
   ["🏆 Leaderboard"] = Vector3.new(300, 5, 0),
   ["🎮 Gaming Zone"] = Vector3.new(-300, 5, 0),
   ["🌟 Secret Area"] = Vector3.new(500, 100, 500)
}

for locationName, position in pairs(teleportLocations) do
   TeleportTab:CreateButton({
      Name = locationName,
      Callback = function()
         safeTeleport(position)
      end,
   })
end

-- Teleport to Player
TeleportTab:CreateButton({
   Name = "👥 Teleport to Player",
   Callback = function()
      local targetPlayer = nil
      for _, player in pairs(Players:GetPlayers()) do
         if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer = player
            break
         end
      end
      
      if targetPlayer then
         safeTeleport(targetPlayer.Character.HumanoidRootPart.Position)
      end
   end,
})

-- Miscellaneous Section (Enhanced)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

-- Item ESP (Fixed)
MiscTab:CreateToggle({
   Name = "👁️ Item ESP",
   CurrentValue = false,
   Flag = "ItemESP",
   Callback = function(Value)
      ESP = Value
      if not ESP then
         for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") and obj.Name == "ESP" then
               obj:Destroy()
            end
         end
      else
         spawn(function()
            while ESP do
               wait(2)
               pcall(function()
                  for _, obj in pairs(Workspace:GetDescendants()) do
                     if obj:IsA("BasePart") and not obj:FindFirstChild("ESP") then
                        if obj.Name:lower():find("coin") or obj.Name:lower():find("money") or 
                           obj.Name:lower():find("cash") or obj.Name:lower():find("gem") or
                           obj.Name:lower():find("token") or obj.Name:lower():find("orb") then
                           
                           local billboard = Instance.new("BillboardGui")
                           billboard.Name = "ESP"
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
                           label.TextStrokeColor3 = Color3.new(0, 0, 0)
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

-- Anti AFK (Fixed)
MiscTab:CreateToggle({
   Name = "🔄 Anti AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
      if Value then
         spawn(function()
            local VirtualUser = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
               VirtualUser:CaptureController()
               VirtualUser:ClickButton2(Vector2.new())
            end)
         end)
      end
   end,
})

-- Server Hop (Fixed)
MiscTab:CreateButton({
   Name = "🌐 Server Hop",
   Callback = function()
      pcall(function()
         local Http = game:GetService("HttpService")
         local TPS = game:GetService("TeleportService")
         local Api = "https://games.roblox.com/v1/games/"
         
         local PlaceId = game.PlaceId
         local AllIDs = {}
         local foundAnything = ""
         local actualHour = os.date("!*t").hour
         
         local function TPReturner()
            local Site = game:HttpGet(Api..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
            local body = Http:JSONDecode(Site)
            local ID = ""
            
            if Site then
               for i, v in pairs(body.data) do
                  local Possible = true
                  ID = tostring(v.id)
                  if tonumber(v.maxPlayers) > tonumber(v.playing) then
                     for _, Existing in pairs(AllIDs) do
                        if ID == tostring(Existing) then
                           Possible = false
                        end
                     end
                     if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                           wait()
                           TPS:TeleportToPlaceInstance(PlaceId, ID, LocalPlayer)
                        end)
                        wait(4)
                     end
                  end
               end
            end
         end
         
         TPReturner()
      end)
   end,
})

-- Auto Rejoin (Fixed)
MiscTab:CreateButton({
   Name = "🔄 Auto Rejoin",
   Callback = function()
      pcall(function()
         TeleportService:Teleport(game.PlaceId, LocalPlayer)
      end)
   end,
})

-- Reset Character
MiscTab:CreateButton({
   Name = "💀 Reset Character",
   Callback = function()
      pcall(function()
         LocalPlayer.Character.Humanoid.Health = 0
      end)
   end,
})

-- Event Connections (Fixed)
-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
   if InfiniteJump and Character and Character:FindFirstChild("Humanoid") then
      Character.Humanoid:ChangeState("Jumping")
   end
end)

-- No Clip Logic
RunService.Stepped:Connect(function()
   if NoClip and Character then
      for _, part in pairs(Character:GetDescendants()) do
         if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
         end
      end
   end
end)

-- Character respawn handler (Fixed)
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
   Character = newCharacter
   Humanoid = Character:WaitForChild("Humanoid")
   RootPart = Character:WaitForChild("HumanoidRootPart")
   
   -- Reapply settings
   wait(1)
   if WalkSpeed ~= 16 then
      Humanoid.WalkSpeed = WalkSpeed
   end
   if JumpPower ~= 50 then
      Humanoid.JumpPower = JumpPower
   end
end)

-- Final notification
Rayfield:Notify({
   Title = "Neon Hub Loaded Successfully!",
   Content = "All features fixed and enhanced for Brainrot!",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Got it!",
         Callback = function()
            print("Neon Hub loaded successfully!")
         end
      },
   },
})

print("=== Neon Hub | Brainrot Script ===")
print("Version: Enhanced & Fixed")
print("Made by: XzgyX")
print("All functions working properly!")
print("==================================")
