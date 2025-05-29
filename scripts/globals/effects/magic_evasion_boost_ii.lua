-----------------------------------
--
--tpz.effect.MAGIC_EVASION_BOOST_II
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MEVA, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MEVA, effect:getPower())
end
