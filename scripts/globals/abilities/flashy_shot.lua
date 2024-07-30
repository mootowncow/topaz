-----------------------------------
-- Ability: Flashy Shot
-- Your next attack will generate more enmity and both have increased accuracy and deal increased damage based on the level difference between you and the target.
-- Obtained: Ranger Level 75 (Merit)
-- Recast Time: 10:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local meritBonus = player:getMerit(tpz.merit.FLASHY_SHOT)
    local power = (meritBonus > 1) and (meritBonus - 1) * 5 or 0
    local duration = 60

    player:addStatusEffect(tpz.effect.FLASHY_SHOT, power, 0, duration)

    return tpz.effect.FLASHY_SHOT
end