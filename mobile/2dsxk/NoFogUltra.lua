-- FULL BYPASS VISION (SEA 3 & MAR 6) - Otimizado para Xeno PC
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- Função para forçar as propriedades (Bypass de proteção do jogo)
local function ForceClear()
    -- 1. Força Neblina no Infinito
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 9e9
    Lighting.GlobalShadows = false
    Lighting.ClockTime = 14
    
    -- 2. Limpa Atmosfera e Efeitos (Mar 6 / Indra / V3)
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") then
            obj.Density = 0
            obj.Haze = 0
            obj.Glare = 0
            obj.Offset = 0
        elseif obj:IsA("ColorCorrectionEffect") or obj:IsA("BlurEffect") or obj:IsA("BloomEffect") then
            obj.Enabled = false
        elseif obj:IsA("Sky") then
            -- Em vez de deletar, apenas desativamos o efeito visual se possível
            -- ou mudamos a cor para não brilhar
        end
    end

    -- 3. Visibilidade Total da Água (Mar 6)
    if Workspace:FindFirstChildOfClass("Terrain") then
        local t = Workspace.Terrain
        t.WaterTransparency = 1
        t.WaterReflectance = 0
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
    end
end

-- 4. Remove Partículas Agressivamente (Chuva e Névoa de Água)
local function NoMoreParticles()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") then
            v.Enabled = false
        end
    end
end

-- LOOP DE ALTA PRIORIDADE (Corre em paralelo para o jogo não reagir)
task.spawn(function()
    while true do
        ForceClear()
        task.wait(0.1) -- Roda 10 vezes por segundo (Super rápido)
    end
end)

-- Remove partículas com menos frequência para não dar lag
task.spawn(function()
    while true do
        NoMoreParticles()
        task.wait(3)
    end
end)

-- Hook para evitar que o jogo mude a iluminação via script interno
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if t == Lighting and (k == "FogEnd" or k == "FogStart") then
        return 9e9
    end
    return old(t, k)
end)

setreadonly(mt, true)

print("--- [SISTEMA REPARADO] VISÃO TOTAL ATIVADA NO XENO ---")
