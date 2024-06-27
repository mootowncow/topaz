-----------------------------------
-- Ability: Avatar's Favor
-- Description: Increases the power of your currently summoned avatar.
-- Obtained: SMN Level 60
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    player:addStatusEffect(tpz.effect.AVATAR_S_FAVOR, 0, 0, 60)
    pet:addStatusEffect(tpz.effect.AVATAR_S_FAVOR, 0, 0, 60)
    return tpz.effect.AVATAR_S_FAVOR
end
