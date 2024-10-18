-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.EVA, -effect:getPower())
    target:addMod(tpz.mod.ENMITY, -effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.EVA, -effect:getPower())
    target:delMod(tpz.mod.ENMITY, -effect:getSubPower())
end
