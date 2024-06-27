-----------------------------------
-- Ability: Demateralize
-- NYI
-- Obtained: NYI
-- Recast Time: NYI
-- Duration: NYI
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.DEMATERIALIZE, 25, 0, 60) -- NYI
end
