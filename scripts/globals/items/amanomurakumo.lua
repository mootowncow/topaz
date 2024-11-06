-----------------------------------------
-- ID: 18318, 18319, 18646, 18660, 18674, 19755, 19848, 21015, 21016, 21954
-- Item: Amanomurakumo
-- Additional Effect: 10% Attack Down
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 20
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 100
    return TryApplyAdditionalEffect(player, target, tpz.effect.ATTACK_DOWN, tpz.magic.ele.WATER, power, tick, duration, subpower, tier, chance, bonus)
 end

