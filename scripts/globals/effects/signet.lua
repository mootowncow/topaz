-----------------------------------
--
--     tpz.effect.SIGNET
--
--   Signet is a a beneficial Status Effect that allows the acquisition of Conquest Points and Crystals
--   from defeated enemies that grant Experience Points.

--   Increased Healing HP
--   No TP loss while resting
--   Bonus experience earned in smaller parties
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    -- Gain +15% more EXP in Conquest zones
    target:addLatent(tpz.latent.SIGNET_EXP_BONUS, 0, tpz.mod.EXP_BONUS, 15) 
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delLatent(tpz.latent.SIGNET_EXP_BONUS, 0, tpz.mod.EXP_BONUS, 15)
end
