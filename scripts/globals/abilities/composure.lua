-----------------------------------
-- Ability: Composure
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white and black magic you cast on yourself last longer.
-- Obtained: Red Mage Level 50
-- Recast Time: 5:00
-- Duration: 120 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local accBonus = math.floor(player:getMainLvl() / 5)
    player:delStatusEffectSilent(tpz.effect.COMPOSURE)
    player:addStatusEffect(tpz.effect.COMPOSURE, accBonus, 0, 7200)
end
