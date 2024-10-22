-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.BARRAGE_EFFECT) * 3

    target:addMod(tpz.mod.RATT, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.BARRAGE_EFFECT) * 3

    target:delMod(tpz.mod.RATT, jpValue)
end
