-----------------------------------
--
--     tpz.effect.WARDING_CIRCLE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
   target:addMod(tpz.mod.DEMON_KILLER, effect:getPower())
   target:addMod(tpz.mod.DEMON_CIRCLE, effect:getPower())
   target:addMod(tpz.mod.DEMON_CIRCLE_DR, effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.DEMON_KILLER, effect:getPower())
   target:delMod(tpz.mod.DEMON_CIRCLE, effect:getPower())
   target:delMod(tpz.mod.DEMON_CIRCLE_DR, effect:getSubPower())
end
