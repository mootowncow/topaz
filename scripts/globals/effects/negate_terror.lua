-----------------------------------
--
-- tpz.effect.NEGATE_TERROR
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addImmunity(tpz.immunity.TERROR)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delImmunity(tpz.immunity.TERROR)
end
