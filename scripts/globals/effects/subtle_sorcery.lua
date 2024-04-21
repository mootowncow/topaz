-----------------------------------
--
--     tpz.effect.SUBTLE_SORCERY
--
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SUBTLE_SORCERY_EFFECT)
    target:addMod(tpz.mod.FASTCAST, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SUBTLE_SORCERY_EFFECT)
    target:delMod(tpz.mod.FASTCAST, jpValue)
end
