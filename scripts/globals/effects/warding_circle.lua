-----------------------------------
--
--     tpz.effect.WARDING_CIRCLE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = 1 + (target:getJobPointLevel(tpz.jp.WARDING_CIRCLE_EFFECT) / 100)

   target:addMod(tpz.mod.DEMON_KILLER, effect:getPower() * jpValue)
   target:addMod(tpz.mod.DEMON_CIRCLE, 10 * jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   local jpValue = 1 + (target:getJobPointLevel(tpz.jp.WARDING_CIRCLE_EFFECT) / 100)

   target:delMod(tpz.mod.DEMON_KILLER, effect:getPower() * jpValue)
   target:delMod(tpz.mod.DEMON_CIRCLE, 10 * jpValue)
end
