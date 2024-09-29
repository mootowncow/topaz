-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SPIKES, 3)
    target:addMod(tpz.mod.SPIKES_MACC, 175)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SPIKES, 3)
    target:delMod(tpz.mod.SPIKES_MACC, 175)
    target:setCharVar("drkSpikes", 0)
end
