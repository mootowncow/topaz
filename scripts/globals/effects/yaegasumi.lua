-----------------------------------
--
--     tpz.effect.YAEGASUMI
--     Grants avoidance to mob TP moves
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.TPEVA, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.TPEVA, -effect:getPower())
end
