-----------------------------------
--
-- tpz.effect.ELEMENTAL_SFORZO
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UDMGMAGIC, -100)
    target:addMod(tpz.mod.UDMGBREATH, -100)
    -- Todo: status resists(code into magic etc)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGMAGIC, -100)
    target:delMod(tpz.mod.UDMGBREATH, -100)
    -- Todo: status resists(code into magic etc)
end
