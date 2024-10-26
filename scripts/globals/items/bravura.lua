-----------------------------------------
-- ID: 18294, 18295, 18642, 18656, 18670, 19751, 19844, 20835, 20836, 21756
-- Item: Bravura
-- Additional Effect: Impairs evasion
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 15
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 100
    return TryApplyAdditionalEffect(player, target, tpz.effect.EVASION_DOWN, tpz.magic.ele.ICE, power, tick, duration, subpower, tier, chance, bonus)
 end