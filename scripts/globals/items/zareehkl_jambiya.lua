-----------------------------------------
-- ID: 19108
-- Item: Zareehkl Jambiya
-- Additional Effect: Weakens defense
-----------------------------------------
require("scripts/globals/magic")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 12
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 50
    local tick = 0
    return TryApplyAdditionalEffect(player, target, tpz.effect.DEFENSE_DOWN, tpz.magic.ele.WIND, power, tick, duration, subpower, tier, chance, tpz.skill.DAGGER, bonus)
 end
