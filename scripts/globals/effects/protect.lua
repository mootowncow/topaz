-----------------------------------
--
--     tpz.effect.PROTECT
--
-- 9653 power sets mobs DMGPHYS to 0. This is used for Qutrubs fortifying wail.
-- 9654 grants the mob 90% PDT. This is used for Nighmare crabs Scissor Guard.
-- Grants PDT based on the protect spell(and merits into Protectra V)
-- Protect - 5% PDT II
-- Protect II - 10% PDT II
-- Protect III - 15% PDT II
-- Protect IV - 20% PDT II
-- Protect V - 24~28% PDT II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local protect =
{
    {10, -5},
    {25, -10},
    {40, -15},
    {55, -20},
    {60, -24},
    {62, -25},
    {64, -26},
    {66, -27},
    {68, -28}
}

function onEffectGain(target, effect)
    -- Apply PDT effect
    local power = effect:getPower()
    for _, protectMods in pairs(protect) do
        if (power == protectMods[1]) then
            target:addMod(tpz.mod.UDMGPHYS, protectMods[2])
        end
    end

    -- Apply protect mod
    local protShellMod = target:getMod(tpz.mod.PROTECT_SHELL_EFFECT)
    power = math.floor(power * (1 + (protShellMod / 10))) -- Percent

    if (power == 9653) then
        target:setMod(tpz.mod.UDMGPHYS, 0)
    elseif (power == 9654) then
        target:setMod(tpz.mod.UDMGPHYS, -90)
    else
        target:addMod(tpz.mod.DEF, power)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    -- Apply PDT effect
    local power = effect:getPower()
    for _, protectMods in pairs(protect) do
        if (power == protectMods[1]) then
            target:delMod(tpz.mod.UDMGPHYS, protectMods[2])
        end
    end

    -- Apply protect mod
    local protShellMod = target:getMod(tpz.mod.PROTECT_SHELL_EFFECT)
    power = math.floor(power * (1 + (protShellMod / 10))) -- Percent

    if (power == 9653) then
        target:setMod(tpz.mod.UDMGPHYS, 200)
    elseif (power == 9654) then
        target:setMod(tpz.mod.UDMGPHYS, 0)
    else
        target:delMod(tpz.mod.DEF, power)
    end
end
