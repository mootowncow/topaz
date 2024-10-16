-----------------------------------
-- Ability: Warding Circle
-- Grants resistance, defense, and attack against Demons to party members within the area of effect.
-- Obtained: Samurai Level 5
-- Recast Time: 5:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local damageIncrease = 10
    local damageReduction = 5 + player:getJobPointLevel(tpz.jp.WARDING_CIRCLE_EFFECT)
    local duration = 180 + player:getMod(tpz.mod.WARDING_CIRCLE_DURATION)

    target:addStatusEffect(tpz.effect.WARDING_CIRCLE, damageIncrease, 0, duration, 0, damageReduction, 0)
end
