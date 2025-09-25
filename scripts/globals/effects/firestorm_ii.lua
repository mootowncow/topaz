-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, effect:getPower())
    target:addMod(tpz.mod.ATTP, 10)
    target:addMod(tpz.mod.RATTP, 10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, effect:getPower())
    target:delMod(tpz.mod.ATTP, 10)
    target:delMod(tpz.mod.RATTP, 10)
end
