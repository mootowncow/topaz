-----------------------------------
--
--     tpz.effect.CONTRADANCE
--     
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CONTRADANCE_EFFECT) * 3

    target:addMod(tpz.mod.WALTZ_COST_PERCENT, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CONTRADANCE_EFFECT) * 3

    target:delMod(tpz.mod.WALTZ_COST_PERCENT, jpValue)
end
