-----------------------------------
--
--     tpz.effect.MAZURKA
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MOVE_SPEED_MAZURKA, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MOVE_SPEED_MAZURKA, effect:getPower())
end
