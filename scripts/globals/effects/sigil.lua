-----------------------------------
-- tpz.effect.SIGIL
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local REGEN      = 1  -- 0001
    local REFRESH    = 2  -- 0010
    local MEAL       = 4  -- 0100
    local EXPLOSS    = 8  -- 1000

    local power = effect:getPower()

    if (bit.band(power, REGEN) ~= 0) then
        target:addLatent(tpz.latent.SIGIL_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    end
    if (bit.band(power, REFRESH) ~= 0) then
        target:addLatent(tpz.latent.SIGIL_REFRESH_BONUS, 85, tpz.mod.REFRESH, 1)
    end
    if (bit.band(power, MEAL) ~= 0) then
        target:addLatent(tpz.latent.SIGIL_FOOD_DURATION, 1, tpz.mod.FOOD_DURATION, 200)
    end
    if (bit.band(power, EXPLOSS) ~= 0) then
        target:addLatent(tpz.latent.SIGIL_RETAINED_EXP, 1, tpz.mod.EXPERIENCE_RETAINED, 35)
    end

    -- Always add campaign EXP bonus
    target:addLatent(tpz.latent.SIGIL_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local REGEN      = 1  -- 0001
    local REFRESH    = 2  -- 0010
    local MEAL       = 4  -- 0100
    local EXPLOSS    = 8  -- 1000

    local power = effect:getPower()


    if (bit.band(power, REGEN) ~= 0) then
        target:delLatent(tpz.latent.SIGIL_REGEN_BONUS, 95, tpz.mod.REGEN, 1)
    end
    if (bit.band(power, REFRESH) ~= 0) then
        target:delLatent(tpz.latent.SIGIL_REFRESH_BONUS, 85, tpz.mod.REFRESH, 1)
    end
    if (bit.band(power, MEAL) ~= 0) then
        target:delLatent(tpz.latent.SIGIL_FOOD_DURATION, 1, tpz.mod.FOOD_DURATION, 200)
    end
    if (bit.band(power, EXPLOSS) ~= 0) then
        target:delLatent(tpz.latent.SIGIL_RETAINED_EXP, 1, tpz.mod.EXPERIENCE_RETAINED, 35)
    end

    -- Always remove campaign EXP bonus
    target:delLatent(tpz.latent.SIGIL_EXP_BONUS, 1, tpz.mod.EXP_BONUS, 15)
end
