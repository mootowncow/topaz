-----------------------------------
--
--     tpz.effect.QUICKENING
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MOVE_SPEED_QUICKENING, effect:getPower())
    target:addPetMod(tpz.mod.MOVE_SPEED_QUICKENING, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MOVE_SPEED_QUICKENING, effect:getPower())
    target:delPetMod(tpz.mod.MOVE_SPEED_QUICKENING, effect:getPower())
end
