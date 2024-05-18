-----------------------------------
-- Ability: Triple Shot
-- Description: Occasionally uses three units of ammunition to deal extra damage.
-- Obtained: COR Level 87
-- Recast Time: 00:05:00
-- Duration: 0:02:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:delStatusEffect(tpz.effect.SWORDPLAY)
    player:addStatusEffect(tpz.effect.TRIPLE_SHOT, 45, 0, 150)
end
