-----------------------------------
--
--     tpz.effect.DIVINE_SEAL
--
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")

function onEffectGain(target, effect)
    local jpLevel = player:getJobPointLevel(tpz.jp.DIVINE_SEAL_EFFECT)

    target:addMod(tpz.mod.CURE_ENMITY_REDUCTION, jpLevel)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = player:getJobPointLevel(tpz.jp.DIVINE_SEAL_EFFECT)

    target:delMod(tpz.mod.CURE_ENMITY_REDUCTION, jpLevel)
end


