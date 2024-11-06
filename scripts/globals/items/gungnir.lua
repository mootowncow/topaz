-----------------------------------------
-- ID: 18300, 18301, 18643, 18657, 18671, 19752, 19845, 20925, 20926, 21857
-- Item: Gungnir
-- Additional Effect: Weakens Defense
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 17
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 100
    return TryApplyAdditionalEffect(player, target, tpz.effect.DEFENSE_DOWN, tpz.magic.ele.WIND, power, tick, duration, subpower, tier, chance, bonus)
 end
