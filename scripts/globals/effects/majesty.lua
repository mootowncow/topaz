-----------------------------------
--
--     tpz.effect.MAJESTY
--     
-----------------------------------
function onEffectGain(target, effect)
    local strength = effect:getPower()

    target:addMod(tpz.mod.CURE_POTENCY_II, strength)
    target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -strength)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local strength = effect:getPower()

    target:delMod(tpz.mod.CURE_POTENCY_II, strength)
    target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -strength)
end
