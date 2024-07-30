-----------------------------------
--
--  tpz.effect.FLASHY_SHOT
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.RACC, 50)
    target:addMod(tpz.mod.ENMITY, 25)
    target:addMod(tpz.mod.RATTP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.RACC, 50)
    target:delMod(tpz.mod.ENMITY, 25)
    target:delMod(tpz.mod.RATTP, effect:getPower())
end
