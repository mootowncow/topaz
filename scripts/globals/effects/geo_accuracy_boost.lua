-----------------------------------
--
-- tpz.effect.GEO_ACCURACY_BOOST
-- Power 1082: Moogle grants DEX +30, Accuracy +30, Ranged Accuracy +30
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:addMod(tpz.mod.DEX, 30)
        target:addMod(tpz.mod.ACC, 30)
        target:addMod(tpz.mod.RACC, 30)
    else
        target:addMod(tpz.mod.ACC, effect:getPower())
        target:addMod(tpz.mod.RACC, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:delMod(tpz.mod.DEX, 30)
        target:delMod(tpz.mod.ACC, 30)
        target:delMod(tpz.mod.RACC, 30)
    else
        target:delMod(tpz.mod.ACC, effect:getPower())
        target:delMod(tpz.mod.RACC, effect:getPower())
    end
end
