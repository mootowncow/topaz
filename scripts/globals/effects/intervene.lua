-----------------------------------
--
--     tpz.effect.INTERVENE
--     Sets the enemy's accuracy and attack to 1 for the duration.
--     
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATT, -9999)
    target:addMod(tpz.mod.ACC, -9999)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATT, -9999)
    target:delMod(tpz.mod.ACC, -9999)
end
