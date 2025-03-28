-----------------------------------
--
--  tpz.effect.TAINT
--  Undispellable
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.REGEN_DOWN, effect:getPower())
    local taint = target:getStatusEffect(effect)
    taint:unsetFlag(tpz.effectFlag.DISPELABLE)
end

function onEffectTick(target, effect)
end


function onEffectLose(target, effect)
    target:delMod(tpz.mod.REGEN_DOWN, effect:getPower())
end
