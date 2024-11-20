-----------------------------------------
-- ID: 18306, 18307, 18644, 18658, 18672, 19753, 19846, 20880, 20881, 21808
-- Item: Apocalypse
-- Additional Effect: Blindness
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 25
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 100
    return TryApplyAdditionalEffect(player, target, tpz.effect.BLINDNESS, tpz.magic.ele.DARK, power, tick, duration, subpower, tier, chance, bonus)
 end