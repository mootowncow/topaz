-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, effect:getPower())
    target:addMod(tpz.mod.DEFP, 20)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, effect:getPower())
    target:delMod(tpz.mod.DEFP, 20)
end
