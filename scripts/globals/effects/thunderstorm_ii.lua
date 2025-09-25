-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, effect:getPower())
    target:addMod(tpz.mod.MAG_BURST_BONUS, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, effect:getPower())
    target:delMod(tpz.mod.MAG_BURST_BONUS, 15)
end
