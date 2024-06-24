-----------------------------------
--
--     tpz.effect.GEO_WEIGHT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
    target:addMod(tpz.mod.EVA, -10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
    target:delMod(tpz.mod.EVA, -10)
end
