-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, effect:getPower())
    target:addMod(tpz.mod.TP_BONUS, 750)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, effect:getPower())
    target:delMod(tpz.mod.TP_BONUS, 750)
end
