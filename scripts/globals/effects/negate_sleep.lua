-----------------------------------
--
-- tpz.effect.NEGATE_SLEEP
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addImmunity(tpz.immunity.SLEEP)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delImmunity(tpz.immunity.SLEEP)
end
