-----------------------------------
-- Ability: Swordplay
-- Grants +25% attack, +25 accuracy and 25% Parry Rate for 5 minutes.
-- Removes the ability to block.
-- Obtained: PLD level 50
-- Recast Time: 00:05:00
-- Duration: 0:02:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:delStatusEffect(tpz.effect.TRIPLE_SHOT)
    target:addStatusEffect(tpz.effect.SWORDPLAY, 1, 0, 150)
end
