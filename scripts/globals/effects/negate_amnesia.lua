-----------------------------------
--
-- tpz.effect.NEGATE_AMNESIA
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addImmunity(tpz.immunity.AMNESIA)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delImmunity(tpz.immunity.AMNESIA)
end
