-----------------------------------
--
--     tpz.effect.FOCUS
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOCUS_EFFECT)
    
    target:addMod(tpz.mod.ACC, effect:getPower() + jpLevel)
    target:addMod(tpz.mod.CRITHITRATE, effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.FOCUS_EFFECT)

    target:delMod(tpz.mod.ACC, effect:getPower() + jpLevel)
    target:delMod(tpz.mod.CRITHITRATE, effect:getSubPower())
end
