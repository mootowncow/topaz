-----------------------------------
-- Ability: Dragon Breaker
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for dragons.
-- Obtained: DRG Level 87
-- Recast Time: 00:01:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local jpValue  = player:getJobPointLevel(tpz.jp.DRAGON_BREAKER_DURATION)
    local duration = 180 + jpValue
    target:addStatusEffect(tpz.effect.DRAGON_BREAKER, 14, 0, duration)

    return tpz.effect.DRAGON_BREAKER
end
