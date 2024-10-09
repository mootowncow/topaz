-----------------------------------
--
-- tpz.effect.ANCIENT_CIRCLE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
   target:addMod(tpz.mod.DRAGON_KILLER, effect:getPower())
   target:addMod(tpz.mod.DRAGON_CIRCLE, 10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.DRAGON_KILLER, effect:getPower())
   target:delMod(tpz.mod.DRAGON_CIRCLE, 10)
end
