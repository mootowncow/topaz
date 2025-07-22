-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SPIKES, tpz.subEffect.DREAD_SPIKES)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SPIKES, tpz.subEffect.DREAD_SPIKES)
    target:setCharVar("drkSpikes", 0)
end
