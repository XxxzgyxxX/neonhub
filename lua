-- Serviços
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI principal
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "NeonHubUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Botão Toggle
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.015, 0, 0.085, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = ""
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = false
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

-- Janela
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0.6, 0, 0.65, 0)
Main.Position = UDim2.new(0.2, 0, 0.17, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- DragBar
local Drag = Instance.new("TextLabel", Main)
Drag.Size = UDim2.new(1, 0, 0, 30)
Drag.Text = "Neon Hub | By _XzgyX_"
Drag.TextColor3 = Color3.new(1, 1, 1)
Drag.Font = Enum.Font.GothamBold
Drag.TextSize = 14
Drag.BackgroundTransparency = 1
Drag.Name = "DragBar"

-- Drag funcional
local dragging, dragStart, startPos
Drag.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Toggle
ToggleButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Scroll
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -35)
Scroll.Position = UDim2.new(0, 0, 0, 35)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.ClipsDescendants = true
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- Padding + Layout
local Padding = Instance.new("UIPadding", Scroll)
Padding.PaddingLeft = UDim.new(0, 10)
Padding.PaddingRight = UDim.new(0, 10)
Padding.PaddingTop = UDim.new(0, 5)

local layout = Instance.new("UIListLayout", Scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- Criador de botão
local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextScaled = true
    Btn.Parent = Scroll
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(callback)
end

-- Speed Toggle
local speedEnabled = false
CreateButton("Speed", function()
    speedEnabled = not speedEnabled
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = speedEnabled and 100 or 16
    end
end)

-- Fly Toggle
local flying = false
CreateButton("Fly", function()
    flying = not flying
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if flying and hrp then
        local bp = Instance.new("BodyPosition")
        local bg = Instance.new("BodyGyro")
        bp.MaxForce = Vector3.new(999999, 999999, 999999)
        bg.MaxTorque = Vector3.new(999999, 999999, 999999)
        bp.Position = hrp.Position + Vector3.new(0, 5, 0)
        bg.CFrame = workspace.CurrentCamera.CFrame
        bp.Parent = hrp
        bg.Parent = hrp
        task.spawn(function()
            while flying and hrp.Parent do
                bp.Position = hrp.Position + Vector3.new(0, 5, 0)
                bg.CFrame = workspace.CurrentCamera.CFrame
                task.wait()
            end
            bp:Destroy()
            bg:Destroy()
        end)
    end
end)

-- NoClip Toggle
local noclip = false
local noclipConnection
CreateButton("NoClip", function()
    noclip = not noclip
    if noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    elseif noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
end)

-- ESP Toggle
local espAtivo = false
CreateButton("ESP", function()
    espAtivo = not espAtivo
    if espAtivo then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if not p.Character:FindFirstChild("NeonESP") then
                    local h = Instance.new("Highlight")
                    h.Name = "NeonESP"
                    h.FillColor = Color3.new(1, 0, 0)
                    h.OutlineColor = Color3.new(1, 1, 1)
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Adornee = p.Character
                    h.Parent = p.Character
                end
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("NeonESP") then
                p.Character.NeonESP:Destroy()
            end
        end
    end
end)

-- Aimbot Toggle
local aimbot = false
local aimbotConnection
CreateButton("Aimbot", function()
    aimbot = not aimbot
    if aimbot then
        aimbotConnection = RunService.RenderStepped:Connect(function()
            local closest, dist = nil, math.huge
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("Head") then
                    local mag = (p.Character.Head.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
                    if mag < dist then
                        closest = p
                        dist = mag
                    end
                end
            end
            if closest and closest.Character:FindFirstChild("Head") then
                workspace.CurrentCamera.CFrame = CFrame.new(
                    workspace.CurrentCamera.CFrame.Position,
                    closest.Character.Head.Position
                )
            end
        end)
    elseif aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
end)

-- Auto Click Toggle
local autoClick = false
CreateButton("Auto Click", function()
    autoClick = not autoClick
    task.spawn(function()
        while autoClick do
            mouse1click()
            task.wait(0.1)
        end
    end)
end)

-- Rejoin
CreateButton("Rejoin", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

-- Teleport
CreateButton("Teleport", function()
    Player.Character:MoveTo(Vector3.new(0, 100, 0))
end)

-- Ping Optimizer
CreateButton("Ping Optimizer", function()
    settings().Network.IncomingReplicationLag = 0
end)

-- FPS Booster
CreateButton("FPS Booster", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(Player.Character) then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
    end
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterTransparency = 1
    workspace.Terrain.WaterReflectance = 0
end)

-- FOV Toggle
local maxFov = false
CreateButton("Max FOV", function()
    maxFov = not maxFov
    if maxFov then
        workspace.CurrentCamera.FieldOfView = 120
    else
        workspace.CurrentCamera.FieldOfView = 70
    end
end)

-- Fog Toggle
local noFog = false
CreateButton("No Fog", function()
    noFog = not noFog
    if noFog then
        game:GetService("Lighting").FogEnd = 1000000
    else
        game:GetService("Lighting").FogEnd = 10000 -- Default value (adjust if needed)
    end
end)