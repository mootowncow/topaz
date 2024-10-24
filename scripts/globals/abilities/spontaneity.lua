-----------------------------------
-- Ability: Spontaneity
-- Reduces casting time for the next magic spell the target casts.
-- Obtained: BLM Level 25
-- Recast Time: 03:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.SPONTANEITY, 1, 0, 60)
end
