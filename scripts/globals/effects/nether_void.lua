-----------------------------------
--
--     tpz.effect.NETHER_VOID
--     
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.DARK_MAGIC_CAST, -50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DARK_MAGIC_CAST, -50)
end
