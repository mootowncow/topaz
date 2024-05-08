-----------------------------------
--
-- tpz.effect.MULTI_STRIKES
--
-- If Power > 100, then Triple attack is equal to power - 100
-----------------------------------

function onEffectGain(target, effect)
    if (effect:getPower() > 100) then
        target:addMod(tpz.mod.TRIPLE_ATTACK, effect:getPower() - 100)
    else
        target:addMod(tpz.mod.DOUBLE_ATTACK, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (effect:getPower() > 100) then
        target:delMod(tpz.mod.TRIPLE_ATTACK, effect:getPower() - 100)
    else
        target:delMod(tpz.mod.DOUBLE_ATTACK, effect:getPower())
    end
end
