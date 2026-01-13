-- FULL CLEAR VISION - BLOX FRUITS (SEA 3 & MAR 6)
-- Compatível com Xeno / Solara / Wave

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:Terrain

-- Função principal de limpeza
local function CleanEnvironment()
    -- 1. Força propriedades de Iluminação (Anti-Neblina)
    Lighting.FogEnd = 100000
    Lighting.FogStart = 100000
    Lighting.GlobalShadows = false
    Lighting.ClockTime = 14 -- Sempre dia
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)

    -- 2. Desativa Atmosphere e Efeitos Visuais (Mar 6)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then
            v.Density = 0
            v.Haze = 0
        elseif v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false
        elseif v:IsA("Sky") or v:IsA("Clouds") then
            v:Destroy()
        end
    end

    -- 3. Transparência da Água (Ver monstros no Mar 6)
    Terrain.WaterTransparency = 1
    Terrain.WaterReflectance = 0
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
end

-- 4. Remove Partículas (Chuva, Raios e Névoa de água)
local function RemoveParticles()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
end

-- EXECUÇÃO CONSTANTE (Para o jogo não resetar os efeitos)
RunService.RenderStepped:Connect(function()
    CleanEnvironment()
end)

-- Remove partículas a cada 5 segundos (para não pesar o PC)
task.spawn(function()
    while true do
        RemoveParticles()
        task.wait(5)
    end
end)

print("---------------------------------------")
print("!!! XENO VISION LOADED SUCCESSFULLY !!!")
print("Sea 3 e Mar 6 agora estão 100% limpos.")
print("---------------------------------------")
