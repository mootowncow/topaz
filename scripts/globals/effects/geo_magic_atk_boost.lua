-----------------------------------
--
-- tpz.effect.GEO_MAGIC_ATK_BOOST
-- Power 1082: Star Sibyl grants MATT + 25, MACC + 25
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:addMod(tpz.mod.MATT, 25)
        target:addMod(tpz.mod.MACC, 25)
    else
        target:addMod(tpz.mod.MATT, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if (power == 1082) then
        target:delMod(tpz.mod.MATT, 25)
        target:delMod(tpz.mod.MACC, 25)
    else
        target:delMod(tpz.mod.MATT, effect:getPower())
    end
end
