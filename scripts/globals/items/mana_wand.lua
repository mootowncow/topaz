-----------------------------------------
-- ID: 18402
-- Item: mana_wand
-- Item Effect: MPHEAL +2
-- Duration: 30 seconds
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18402 then
        target:delStatusEffectSilent(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 18402)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MPHEAL, 2)
end
