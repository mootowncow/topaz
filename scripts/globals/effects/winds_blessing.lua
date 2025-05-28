-----------------------------------
--
-- tpz.effect.WINDS_BLESSING
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DMGMAGIC_II, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DMGMAGIC_II, -effect:getPower())
end
