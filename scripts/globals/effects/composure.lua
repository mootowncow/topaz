-----------------------------------
-- Composure
-- Increases accuracy, enspell magic accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.COMPOSURE_EFFECT)

    target:addMod(tpz.mod.ACC, 35 + jpValue)
    target:addMod(tpz.mod.ENSPELL_MACC, 15 + jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.COMPOSURE_EFFECT)

    target:delMod(tpz.mod.ACC, 35 + jpValue)
    target:delMod(tpz.mod.ENSPELL_MACC, 15 + jpValue)
end
