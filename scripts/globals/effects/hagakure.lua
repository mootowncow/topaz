-----------------------------------
--
--     tpz.effect.HAGAKURE
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.HAGAKURE_EFFECT) * 10

    target:addMod(tpz.mod.SAVETP, 400)
    target:addMod(tpz.mod.TP_BONUS, 1000 + jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.HAGAKURE_EFFECT) * 10

    target:delMod(tpz.mod.SAVETP, 400)
    target:delMod(tpz.mod.TP_BONUS, 1000 + jpValue)
end
