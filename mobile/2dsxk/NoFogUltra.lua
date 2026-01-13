-- BLOX FRUITS NO FOG & SEA 3 BYPASS (PC XENO)
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- 1. FUNÇÃO DE DESTRUIÇÃO DE ATMOSFERA
local function DestroyFog()
    -- Remove a névoa clássica
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 9e9
    Lighting.ClockTime = 14
    
    -- Remove todos os objetos que criam o efeito de névoa no Sea 3
    for _, obj in ipairs(Lighting:GetGetChildren()) do
        if obj:IsA("Atmosphere") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BlurEffect") or obj:IsA("BloomEffect") then
            obj:Destroy() -- Deleta o objeto para o jogo não conseguir reativar
        end
    end
end

-- 2. TRAVA DE PROPRIEDADE (Se o jogo mudar, o script muda de volta instantaneamente)
Lighting.Changed:Connect(function(prop)
    if prop == "FogEnd" or prop == "FogStart" or prop == "Ambient" then
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    end
end)

-- 3. REMOVER NEBLINA DO TERRAIN (Mar 6)
workspace.Terrain.WaterTransparency = 1
workspace.Terrain.WaterWaveSize = 0
workspace.Terrain.WaterWaveSpeed = 0

-- 4. LOOP DE EXECUÇÃO AGRESSIVA (RENDER STEPPED)
-- Isso roda antes de cada frame ser desenhado na sua tela
RunService.RenderStepped:Connect(function()
    DestroyFog()
    
    -- Se houver atmosfera no Workspace (alguns jogos escondem lá)
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Atmosphere") then
            v:Destroy()
        end
    end
end)

-- 5. DESATIVAR PARTÍCULAS (Céu escuro, chuva, raios)
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") then
        v.Enabled = false
    end
end

print("!!! VISION BYPASS ATIVADO - MODO AGRESSIVO !!!")
