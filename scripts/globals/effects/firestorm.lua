-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, effect:getPower())
    target:addMod(tpz.mod.ATTP, 5)
    target:addMod(tpz.mod.RATTP, 5)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, effect:getPower())
    target:delMod(tpz.mod.ATTP, 5)
    target:delMod(tpz.mod.RATTP, 5)
end
