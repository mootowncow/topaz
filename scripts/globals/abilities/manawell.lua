-----------------------------------
-- Ability: Manawell
-- Description: Restores your MP over 9 seconds. Cannot perform actions during the duration.
-- Obtained: BLM Level 40
-- Recast Time: 00:08:00 
-- Duration: 0:00:08
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.MANAWELL, 1, 0, 30)
end
