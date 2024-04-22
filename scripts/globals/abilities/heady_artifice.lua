-----------------------------------
-- Ability: Heady Artifice
-- Description: Greatly reduces the damage your Automaton takes for a short time.
-- Obtained: PUP Level 60
-- Recast Time: 00:00:60
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    pet:delStatusEffect(tpz.effect.PHALANX)
    pet:addStatusEffect(tpz.effect.PHALANX, 500, 0, 5)
end
