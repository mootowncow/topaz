-----------------------------------
--
--     tpz.effect.PERFECT_DODGE
--
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.PERFECT_DODGE_EFFECT) * 3

    target:addMod(tpz.mod.MEVA, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.PERFECT_DODGE_EFFECT) * 3

    target:delMod(tpz.mod.MEVA, jpValue)
end
