-----------------------------------
--
-- tpz.effect.NEGATE_PETRIFY
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addImmunity(tpz.immunity.PETRIFY)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delImmunity(tpz.immunity.PETRIFY)
end
