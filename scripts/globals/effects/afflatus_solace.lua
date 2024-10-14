-----------------------------------
--
-- tpz.effect.AFFLATUS_SOLACE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.AFFLATUS_SOLACE_EFFECT) * 2

    target:addMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:addMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
    target:addMod(tpz.mod.CURE_POTENCY_BASE, jpLevel)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpLevel = target:getJobPointLevel(tpz.jp.AFFLATUS_SOLACE_EFFECT) * 2

    target:delMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:delMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
    target:delMod(tpz.mod.CURE_POTENCY_BASE, jpLevel)
end
