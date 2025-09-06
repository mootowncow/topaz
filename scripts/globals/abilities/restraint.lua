-----------------------------------
-- Ability: Restraint
-- Grants an absorb shield (stoneskin).
-- Obtained: WAR Level 40
-- Recast Time: 1:00
-- Duration: 00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 30

    player:addStatusEffect(tpz.effect.RESTRAINT, 0, 0, duration)

    return tpz.effect.RESTRAINT
end