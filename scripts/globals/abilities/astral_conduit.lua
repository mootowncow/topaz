-----------------------------------
-- Ability: Astral Conduit
-- Description: Fully restores MP, resets blood pact recast timers, and reduces blood pact recasts by 50%
-- Note: Bypasses normal BP timer reduction cap
-- Obtained: SMN Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:setMP(player:getMaxMP())
    player:resetRecast(tpz.recast.ABILITY, 173)
    player:resetRecast(tpz.recast.ABILITY, 174)
    player:addStatusEffect(tpz.effect.ASTRAL_CONDUIT, 1, 0, 30)
end
