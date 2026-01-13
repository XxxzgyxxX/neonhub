-- UNIVERSAL VISION BYPASS (Mobile & PC)
-- Remove Fog, Atmosphere, Blur e melhora o Brilho

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local function UltraVision()
    -- 1. Força Brilho Máximo e Remove Sombras (FullBright)
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 9e9 -- Visão infinita
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    
    -- 2. Limpeza Agressiva de Efeitos
    -- Remove tudo que embaça a tela ou cria névoa
    for _, obj in pairs(Lighting:GetDescendants()) do
        if obj:IsA("Atmosphere") or obj:IsA("BlurEffect") or obj:IsA("BloomEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") then
            if obj:IsA("Atmosphere") then
                obj.Density = 0 -- Torna o ar transparente
                obj.Haze = 0
            else
                obj.Enabled = false -- Desativa filtros de cor e borrão
            end
        end
    end

    -- 3. Transparência de Água (Universal para mares e rios)
    if Terrain then
        Terrain.WaterTransparency = 1
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
    end
end

-- 4. Remoção de Partículas (Reduz lag e limpa a visão de fumaça/chuva)
local function NoParticles()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
end

-- 5. Loop de Proteção (Para o jogo não reativar a neblina)
task.spawn(function()
    while true do
        UltraVision()
        task.wait(3) -- Verifica a cada 3 segundos para não pesar no Mobile
    end
end)

-- Execução única imediata
UltraVision()
NoParticles()

print("---------------------------------")
print("Universal Vision Loaded!")
print("Fog, Blur & Particles Removed.")
print("---------------------------------")
