-----------------------------------
--
--   tpz.effect.TERNARY_FLOURISH
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.FLOURISH_III_EFFECT)

    target:addMod(tpz.mod.CRITHITRATE, effect:getPower() + jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.FLOURISH_III_EFFECT)

    target:delMod(tpz.mod.CRITHITRATE, effect:getPower() + jpValue)
end