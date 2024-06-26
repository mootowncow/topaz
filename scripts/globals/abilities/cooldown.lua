-----------------------------------
-- Ability: Cooldown
-- Description: Causes your next repair or maintenance to also effect yourself.
-- Obtained: PUP Level 70
-- Recast Time: 01:30:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.LUX, 1, 0, 30)
end
