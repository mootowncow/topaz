-----------------------------------
--
--     tpz.effect.DIVINE_EMBLEM
--     
-----------------------------------
function onEffectGain(target, effect)
   target:addMod(tpz.mod.CURE_POTENCY_II, 25)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
	target:delMod(tpz.mod.CURE_POTENCY_II, 25)
end
