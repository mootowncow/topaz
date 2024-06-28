-----------------------------------
-- Hasso
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC (Handled in C++)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jaHaste = 1000 + target:getMod(tpz.mod.HASSO_HASTE)

    target:addMod(tpz.mod.TWOHAND_STR, effect:getPower())
    target:addMod(tpz.mod.TWOHAND_HASTE_ABILITY, jaHaste)
    target:addMod(tpz.mod.TWOHAND_ACC, 10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jaHaste = 1000 + target:getMod(tpz.mod.HASSO_HASTE)

    target:delMod(tpz.mod.TWOHAND_STR, effect:getPower())
    target:delMod(tpz.mod.TWOHAND_HASTE_ABILITY, jaHaste)
    target:delMod(tpz.mod.TWOHAND_ACC, 10)
end
