-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.DOUBLE_SHOT_EFFECT)

    target:addMod(tpz.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.DOUBLE_SHOT_EFFECT)

    target:delMod(tpz.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end
