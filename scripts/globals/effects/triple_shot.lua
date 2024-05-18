-----------------------------------
--
--     tpz.effect.TRIPLE_SHOT
--
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.TRIPLE_SHOT_EFFECT)

    target:addMod(tpz.mod.TRIPLE_SHOT_RATE, effect:getPower() + jpValue)
    target:addMod(tpz.mod.RACC, 30)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.TRIPLE_SHOT_EFFECT)

    target:delMod(tpz.mod.TRIPLE_SHOT_RATE, effect:getPower() + jpValue)
    target:delMod(tpz.mod.RACC, 30)
end
