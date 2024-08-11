-----------------------------------
-- Arrow Shield
-- Blocks all ranged attacks
-- TODO:Absorb ranged damage only like magic shield if power is > 100
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UDMGRANGE, -100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGRANGE, -100)
end
