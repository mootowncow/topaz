-----------------------------------
-- Ability: Stealth Shot
-- Your next attack will generate less enmity.
-- Obtained: Ranger Level 75 (Merit)
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local meritBonus = player:getMerit(tpz.merit.STEALTH_SHOT)
    local power = math.max(10, meritBonus)  -- Ensure power is never less than 10
    local duration = 60

    player:addStatusEffect(tpz.effect.STEALTH_SHOT, power, 0, duration)

    return tpz.effect.STEALTH_SHOT
end
