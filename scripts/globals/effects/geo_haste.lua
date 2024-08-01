-----------------------------------
--
--     tpz.effect.GEO_HASTE
-- Power 1082: Cornelia grants Haste +20%, Accuracy +30, Ranged Accuracy +30, Magic Accuracy +15
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:addMod(tpz.mod.HASTE_MAGIC, 2000)
        target:addMod(tpz.mod.ACC, 30)
        target:addMod(tpz.mod.RACC, 30)
        target:addMod(tpz.mod.MACC, 15)
    else
        target:addMod(tpz.mod.HASTE_MAGIC, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:delMod(tpz.mod.HASTE_MAGIC, 2000)
        target:delMod(tpz.mod.ACC, 30)
        target:delMod(tpz.mod.RACC, 30)
        target:delMod(tpz.mod.MACC, 15)
    else
        target:delMod(tpz.mod.HASTE_MAGIC, effect:getPower())
    end
end
