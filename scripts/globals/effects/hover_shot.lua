-----------------------------------
--
--    tpz.effect.HOVER_SHOT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 150)
    target:addMod(tpz.mod.ENMITY, 30)
    target:addMod(tpz.mod.TPEVA, 30)
    target:addMod(tpz.mod.RATTP, -15)
    target:addMod(tpz.mod.RANGED_DELAYP, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 150)
    target:delMod(tpz.mod.ENMITY, 30)
    target:delMod(tpz.mod.TPEVA, 30)
    target:delMod(tpz.mod.RATTP, -15)
    target:delMod(tpz.mod.RANGED_DELAYP, 15)
end
