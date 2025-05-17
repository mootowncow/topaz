-----------------------------------
--
-- tpz.effect.CAMOUFLAGE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CAMOUFLAGE_EFFECT)

    target:addMod(tpz.mod.EVA, 78)
    target:addMod(tpz.mod.MEVA, 78)
    target:addMod(tpz.mod.CRITHITRATE, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.CAMOUFLAGE_EFFECT)

    target:delMod(tpz.mod.EVA, 78)
    target:delMod(tpz.mod.MEVA, 78)
    target:delMod(tpz.mod.CRITHITRATE, jpValue)
end
