-----------------------------------
--
-- tpz.effect.CONCENTRATION
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FASTCAST, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FASTCAST, effect:getPower())
end
