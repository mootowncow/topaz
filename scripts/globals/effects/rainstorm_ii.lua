-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MND, effect:getPower())
    target:addMod(tpz.mod.CURE_POTENCY_RCVD, 35)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MND, effect:getPower())
    target:delMod(tpz.mod.CURE_POTENCY_RCVD, 35)
end
