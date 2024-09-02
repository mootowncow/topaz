-----------------------------------
--
-- tpz.effect.SANCTION
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    if power == 1 then
        target:addLatent(tpz.latent.SANCTION_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    elseif power == 2 then
        target:addLatent(tpz.latent.SANCTION_REFRESH_BONUS, 75, tpz.mod.REFRESH, 1)
    elseif power == 3 then
        target:addMod(tpz.mod.FOOD_DURATION, 120)
    end
    -- Gain +15% more EXP in besieged regiions if above level 55 and below 75
    target:addLatent(tpz.latent.SANCTION_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)

    local power = effect:getPower()
    if power == 1 then
        target:delLatent(tpz.latent.SANCTION_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    elseif power == 2 then
        target:delLatent(tpz.latent.SANCTION_REFRESH_BONUS, 75, tpz.mod.REFRESH, 1)
    elseif power == 3 then
        target:delMod(tpz.mod.FOOD_DURATION, 120)
    end
    target:delLatent(tpz.latent.SANCTION_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end
