-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOOTWORK_EFFECT)

	target:addMod(tpz.mod.MAIN_DMG_RATING, 25 + jpLevel)
    target:addMod(tpz.mod.KICK_DMG, effect:getPower() + jpLevel)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOOTWORK_EFFECT)

    target:delMod(tpz.mod.MAIN_DMG_RATING, 25 + jpLevel)
    target:delMod(tpz.mod.KICK_DMG, effect:getPower() + jpLevel)
end
