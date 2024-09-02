-----------------------------------
--
--     tpz.effect.SIGNET
--
--   Signet is a a beneficial Status Effect that allows the acquisition of Conquest Points and Crystals
--   from defeated enemies that grant Experience Points.

--   Increased Healing HP
--   No TP loss while resting
--   Bonus experience earned in smaller parties
--   Increased defense and evasion against attacks from your auto-attack target when even match or lower
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.DMGPHYS_II, 15)
    target:addLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.EVA, 50)
    -- Gain +15% more EXP in Conquest zones if above level 55 and below 75
    target:addLatent(tpz.latent.SIGNET_EXP_BONUS, 0, tpz.mod.EXP_BONUS, 15) 
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.DMGPHYS_II, 15)
    target:delLatent(tpz.latent.SIGNET_BONUS, 0, tpz.mod.EVA, 50)
    target:delLatent(tpz.latent.SIGNET_EXP_BONUS, 0, tpz.mod.EXP_BONUS, 15)
end
