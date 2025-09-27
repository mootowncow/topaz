-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, effect:getPower())
    target:addMod(tpz.mod.FASTCAST, 30)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, effect:getPower())
    target:delMod(tpz.mod.FASTCAST, 30)
end
