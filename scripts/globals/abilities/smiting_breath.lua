-----------------------------------
-- Ability: Smiting Breath
-- Commands your wyvern to use an offensive breath.
-- Obtained: Dragoon Level 40
-- Recast Time: 01:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/pets/wyvern")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    doOffensiveBreath(player, target)
end
