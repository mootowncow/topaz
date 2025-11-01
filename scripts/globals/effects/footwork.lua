-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOOTWORK_EFFECT)
    local attpMod = target:getMod(tpz.mod.FOOTWORK_ATT_BONUS)

    target:addMod(tpz.mod.KICK_DMG, effect:getPower() + jpLevel)
	target:addMod(tpz.mod.ATTP, 10 + attpMod)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOOTWORK_EFFECT)
    local attpMod = target:getMod(tpz.mod.FOOTWORK_ATT_BONUS)

    target:delMod(tpz.mod.KICK_DMG, effect:getPower() + jpLevel)
	target:delMod(tpz.mod.ATTP, 10 + attpMod)
end
