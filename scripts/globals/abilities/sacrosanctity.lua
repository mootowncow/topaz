-----------------------------------
-- Ability: Sacrosanctity
-- Description: Enhances your physical prowess, but lowers curing power.
-- Obtained: WHM Level 5
-- Recast Time: 00:00:30
-- Duration: 0:05:00
-- WHM Main only
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.SACROSANCTITY, 1, 0, 300)
end
