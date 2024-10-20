-----------------------------------
-- Ability: Holy Circle
-- Grants resistance, defense, and attack against Undead to party members within the area of effect.
-- Obtained: Paladin Level 5
-- Recast Time: 5:00 minutes
-- Duration: 3:00 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local damageIncrease = 10
    local damageReduction = 5 + player:getJobPointLevel(tpz.jp.HOLY_CIRCLE_EFFECT)
    local duration = 180 + player:getMod(tpz.mod.HOLY_CIRCLE_DURATION)

    target:addStatusEffect(tpz.effect.HOLY_CIRCLE, damageIncrease, 0, duration, 0, damageReduction, 0)
end
