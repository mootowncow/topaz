-----------------------------------
--
--   tpz.effect.STRIKING_FLOURISH
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.FLOURISH_III_EFFECT)

    target:addMod(tpz.mod.EXTRA_DMG_CHANCE, effect:getPower() + jpValue * 10) -- i.e. 111 would be 11.1% proc chance
    target:addMod(tpz.mod.OCC_DO_EXTRA_DMG, effect:getSubPower()) -- i.e. 250 would be 2.5x damage
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.FLOURISH_III_EFFECT)

    target:delMod(tpz.mod.EXTRA_DMG_CHANCE, effect:getPower() + jpValue * 10) -- i.e. 111 would be 11.1% proc chance
    target:delMod(tpz.mod.OCC_DO_EXTRA_DMG, effect:getSubPower()) -- i.e. 250 would be 2.5x damage
end