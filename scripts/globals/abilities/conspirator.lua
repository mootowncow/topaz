-----------------------------------
-- Ability: Conspirator
-- Enhances accuracy and "Subtle Blow" effect for party members within area of effect.
-- Calculated at time of party members attack. Does not effect the person at the top of the enmity list.
-- Handled in C++
-- Obtained: Thief Level 87
-- Recast Time: 5:00
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.CONSPIRATOR, 0, 0, 300)
end
