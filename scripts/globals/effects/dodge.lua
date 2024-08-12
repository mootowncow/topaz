-----------------------------------
--
--     tpz.effect.DODGE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.DODGE_EFFECT) * 2

    target:addMod(tpz.mod.EVA, effect:getPower() + jpLevel)
    target:addMod(tpz.mod.GUARD_PERCENT, 50 + jpLevel)
    target:addMod(tpz.mod.INQUARTATA, 15 + jpLevel)
    target:addMod(tpz.mod.MEVA, effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.DODGE_EFFECT) * 2

    target:delMod(tpz.mod.EVA, effect:getPower() + jpLevel)
    target:delMod(tpz.mod.GUARD_PERCENT, 50 + jpLevel)
    target:delMod(tpz.mod.INQUARTATA, 15 + jpLevel)
    target:delMod(tpz.mod.MEVA, effect:getSubPower())
end
