-----------------------------------
-- tpz.effects.COUNTER_BOOST
-- +Counter rate. used for mob counter moves and BLU spells
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.COUNTER, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.COUNTER, effect:getPower())
end
