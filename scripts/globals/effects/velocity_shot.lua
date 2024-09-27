-----------------------------------
--
--    tpz.effect.VELOCITY_SHOT
--
-----------------------------------
require("scripts/globals/status")
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.VELOCITY_SHOT_EFFECT) * 2

    target:addMod(tpz.mod.RATT, jpValue)
    target:addMod(tpz.mod.ATTP, -15)
    target:addMod(tpz.mod.HASTE_ABILITY, -1500)
    target:addMod(tpz.mod.RATTP, 15)
    target:addMod(tpz.mod.RANGED_DELAYP, -15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.VELOCITY_SHOT_EFFECT) * 2

    target:delMod(tpz.mod.RATT, jpValue)
    target:delMod(tpz.mod.ATTP, -15)
    target:delMod(tpz.mod.HASTE_ABILITY, -1500)
    target:delMod(tpz.mod.RATTP, 15)
    target:delMod(tpz.mod.RANGED_DELAYP, -15)
end
