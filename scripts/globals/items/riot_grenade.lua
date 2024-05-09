-----------------------------------------
-- ID: 17315
-- Item: Riot Grenade
-- Additional Effect: Elegy
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 100)
    local power = 20
    local duration = 180
    local subpower = 0
    local tier = 1
    local bonus = 0
    return TryApplyAdditionalEffect(player, target, tpz.effect.ELEGY, tpz.magic.ele.EARTH, power, tick, duration, subpower, tier, chance, bonus)
 end
