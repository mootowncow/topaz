-----------------------------------
--
--     tpz.effect.PERFECT_COUNTER
--
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.PERFECT_COUNTER_ATT, 100)
    target:addMod(tpz.mod.DMGPHYS_II, -25)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.PERFECT_COUNTER_ATT, 100)
    target:delMod(tpz.mod.DMGPHYS_II, -25)
end
