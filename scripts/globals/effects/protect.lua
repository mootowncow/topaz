-----------------------------------
--
--     tpz.effect.PROTECT
--
-- 9653 power sets mobs DMGPHYS to 0. This is used for Qutrubs fortifying wail.
-- 9654 grants the mob 90% PDT. This is used for Nighmare crabs Scissor Guard.
-- Grants PDT based on the protect spell(and merits into Protectra V)
-- Protect - 2% PDT II
-- Protect II - 4% PDT II
-- Protect III - 6% PDT II
-- Protect IV - 8% PDT II
-- Protect V - 10% PDT II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local protect =
{
    {10, -2},
    {25, -4},
    {40, -6},
    {55, -8},
    {60, -10},
    {62, -11},
    {64, -12},
    {66, -13},
    {68, -14}
}
function onEffectGain(target, effect)
    -- Apply PDT effect
    local power = effect:getPower()
    for _, protectMods in pairs(protect) do
        if (power == protectMods[1]) then
            target:addMod(tpz.mod.UDMGPHYS, protectMods[2])
        end
    end

    -- Apply protect mods
    local protShellMod = target:getMod(tpz.mod.PROTECT_SHELL_EFFECT)
    power = math.floor(power * (1 + (protShellMod / 10))) -- Percent

    local protectMod = target:getMod(tpz.mod.ENHANCES_PROT_RCVD)
    power = math.floor(power * (1 + (protectMod / 100))) -- Percent

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

    -- Apply protect mods
    local protShellMod = target:getMod(tpz.mod.PROTECT_SHELL_EFFECT)
    power = math.floor(power * (1 + (protShellMod / 10))) -- Percent

    local protectMod = target:getMod(tpz.mod.ENHANCES_PROT_RCVD)
    power = math.floor(power * (1 + (protectMod / 100))) -- Percent

    if (power == 9653) then
        target:setMod(tpz.mod.UDMGPHYS, 200)
    elseif (power == 9654) then
        target:setMod(tpz.mod.UDMGPHYS, 0)
    else
        target:delMod(tpz.mod.DEF, power)
    end
end
