-----------------------------------
--
--    tpz.effect.SHARPSHOT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SHARPSHOT_EFFECT) * 2

    target:addMod(tpz.mod.RACC, effect:getPower())
    target:addMod(tpz.mod.RATT, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SHARPSHOT_EFFECT) * 2

    target:delMod(tpz.mod.RACC, effect:getPower())
    target:delMod(tpz.mod.RATT, jpValue)
end
