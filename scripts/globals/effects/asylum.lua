-----------------------------------
--
--     tpz.effect.ASYLUM
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.ASYLUM_EFFECT)

    target:addMod(tpz.mod.STATUSRESTRAIT, 40)
    target:addMod(tpz.mod.DISPELRESTRAIT, 40)
    target:addMod(tpz.mod.MEVA, jpLevel)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.ASYLUM_EFFECT)

    target:delMod(tpz.mod.STATUSRESTRAIT, 40)
    target:delMod(tpz.mod.DISPELRESTRAIT, 40)
    target:delMod(tpz.mod.MEVA, jpLevel)
end
