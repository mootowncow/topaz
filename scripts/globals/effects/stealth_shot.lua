-----------------------------------
--
--  tpz.effect.STEALTH_SHOT
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ENMITY_II, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ENMITY_II, effect:getPower())
end
