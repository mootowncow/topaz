-----------------------------------
--
--     tpz.effect.DRAGON_BREAKER
--     
-----------------------------------
function onEffectGain(target, effect)
	target:addMod(tpz.mod.ACC, -20)
	target:addMod(tpz.mod.EVA, -20)
	target:addMod(tpz.mod.MACC, -20)
	target:addMod(tpz.mod.MEVA, -20)
	target:addMod(tpz.mod.STORETP, -20)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
	target:delMod(tpz.mod.ACC, -20)
	target:delMod(tpz.mod.EVA, -20)
	target:delMod(tpz.mod.MACC, -20)
	target:delMod(tpz.mod.MEVA, -20)
	target:delMod(tpz.mod.STORETP, -20)
end
