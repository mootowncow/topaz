-----------------------------------
--
--  tpz.effect.UNLIMITED_SHOT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.UNLIMITED_SHOT_EFFECT) * 2

    target:addMod(tpz.mod.ENMITY, -jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.UNLIMITED_SHOT_EFFECT) * 2

    target:delMod(tpz.mod.ENMITY, -jpValue)
end
