-----------------------------------
-- Ability: Arcane Circle
-- Grants resistance, defense, and attack against Arcana to party members within the area of effect.
-- Obtained: Dark Knight Level 5
-- Recast Time: 5:00 minutes
-- Duration: 3:00 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local damageIncrease = 10
    local damageReduction = 5 + player:getJobPointLevel(tpz.jp.ARCANE_CIRCLE_EFFECT)
    local duration = 180 + player:getMod(tpz.mod.ARCANE_CIRCLE_DURATION)

    target:addStatusEffect(tpz.effect.ARCANE_CIRCLE, damageIncrease, 0, duration, 0, damageReduction, 0)
end
