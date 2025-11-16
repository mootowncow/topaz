-----------------------------------
-- Ability: Sharpshot
-- Increases ranged accuracy and gives your melee attacks a chance to taint the target.
-- Obtained: Ranger Level 1
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 40 + player:getMod(tpz.mod.SHARPSHOT)
    player:addStatusEffect(tpz.effect.SHARPSHOT, power, 0, 60)
end
