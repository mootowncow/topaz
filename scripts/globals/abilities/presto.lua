-----------------------------------
-- Ability: Presto
-- Description Enhances the effect of your next step and grants you an additional finishing move.
-- Obtained: DNC Level 77
-- Recast Time: 00:00:15 (Step)
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.PRESTO, 1, 0, 30)
end
