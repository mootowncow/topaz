-----------------------------------
--
-- tpz.effect.SIGIL
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
-- TODO: if you get all buffs it breaks and doesn't give regen/refresh
function onEffectGain(target, effect)

    local power = effect:getPower() -- Tracks which bonus effects are in use.
    if (power == 1 or power == 3 or power == 5 or power == 7 or power == 9 or power == 11 or power == 13 or power == 15) then
        local percentage = 95 
        target:addLatent(tpz.latent.SIGIL_REGEN_BONUS, percentage, tpz.mod.REGEN, 1)
    end

    if (power == 2 or power == 3 or power == 6 or power == 7 or power == 10 or power == 11 or power >= 14) then
        local percentage = 85 
        target:addLatent(tpz.latent.SIGIL_REFRESH_BONUS, percentage, tpz.mod.REFRESH, 1)
    end

    if (power >= 4 and power <= 7) then
        target:addMod(tpz.mod.FOOD_DURATION, 100)
    elseif (power >= 8 and power <= 11) then
        -- target:addMod(tpz.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    elseif (power >= 12) then
        -- Possibly handle exp loss reduction in core instead..Maybe the food bonus also?
        target:addMod(tpz.mod.FOOD_DURATION, 100)
        -- target:addLatent(LATENT_SIGIL_EXPLOSS, ?, MOD_EXPLOSS_REDUCTION, ?)
        -- exp loss reduction not implemented.
    end
    -- Gain +15% more EXP in campaign regions if above level 55 and below 75
    target:addLatent(tpz.latent.SIGIL_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower() -- Tracks which bonus effects are in use.
    local subPower = effect:getSubPower() -- subPower sets % required to trigger regen/refresh.

    if (power == 1 or power == 3 or power == 5 or power == 7 or power == 9 or power == 11 or power == 13 or power == 15) then
        local percentage = 95 
        target:delLatent(tpz.latent.SIGIL_REGEN_BONUS, percentage, tpz.mod.REGEN, 1)
    end

    if (power == 2 or power == 3 or power == 6 or power == 7 or power == 10 or power == 11 or power >= 14) then
        local percentage = 85
        target:delLatent(tpz.latent.SIGIL_REFRESH_BONUS, percentage, tpz.mod.REFRESH, 1)
    end

    if (effect:getPower() >= 4 and effect:getPower() <= 7) then
        target:delMod(tpz.mod.FOOD_DURATION, 100)
    elseif (effect:getPower() >= 8 and effect:getPower() <= 11) then
        -- target:delMod(tpz.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    elseif (effect:getPower() >= 12) then
        target:delMod(tpz.mod.FOOD_DURATION, 100)
        -- target:delMod(tpz.mod.EXPLOSS_REDUCTION), ???)
        -- exp loss reduction not implemented.
    end
    target:delLatent(tpz.latent.SIGIL_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end
