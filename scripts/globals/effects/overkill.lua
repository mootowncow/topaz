-----------------------------------
--
--     tpz.effect.OVERKILL
--     
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.OVERKILL_EFFECT)

    target:addMod(tpz.mod.HASTE_ABILITY, 2500)
    target:addMod(tpz.mod.DOUBLE_ATTACK, 50)
    target:addMod(tpz.mod.TRIPLE_ATTACK, 25)
    target:addMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
    target:addMod(tpz.mod.TRIPLE_SHOT_RATE, 33)
    target:addMod(tpz.mod.ENMITY, -jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.OVERKILL_EFFECT)

    target:delMod(tpz.mod.HASTE_ABILITY, 2500)
    target:delMod(tpz.mod.DOUBLE_ATTACK, 50)
    target:delMod(tpz.mod.TRIPLE_ATTACK, 25)
    target:delMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
    target:delMod(tpz.mod.TRIPLE_SHOT_RATE, 33)
    target:delMod(tpz.mod.ENMITY, -jpValue)
end
