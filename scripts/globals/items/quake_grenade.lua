-----------------------------------------
-- ID: 17314
-- Item: Quake Grenade
-- Additional Effect: Lowers Mgc. Atk.
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
    return TryApplyAdditionalEffect(player, target, tpz.effect.MAGIC_ATK_DOWN, tpz.magic.ele.FIRE, power, tick, duration, subpower, tier, chance, bonus)
 end
