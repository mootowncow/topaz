-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CHR, effect:getPower())
    target:addMod(tpz.mod.MPHEAL, 35)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CHR, effect:getPower())
    target:delMod(tpz.mod.MPHEAL, 35)
end
