-----------------------------------
--
-- tpz.effect.NEGATE_CHARM
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addImmunity(tpz.immunity.CHARM)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delImmunity(tpz.immunity.CHARM)
end
