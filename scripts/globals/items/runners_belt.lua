-----------------------------------------
-- ID: 15865
-- Item: runners_belt
-- Item Effect: DEX +3
-- Duration: 60 seconds
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15865 then
        target:delStatusEffectSilent(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 60, 15865)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 3)
end
