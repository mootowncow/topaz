-----------------------------------
--
-- tpz.effect.CAMOUFLAGE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CAMOUFLAGE_EFFECT)

    target:addMod(tpz.mod.ENMITY, -25)
    target:addMod(tpz.mod.CRITHITRATE, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CAMOUFLAGE_EFFECT)

    target:delMod(tpz.mod.ENMITY, -25)
    target:delMod(tpz.mod.CRITHITRATE, jpValue)
end
