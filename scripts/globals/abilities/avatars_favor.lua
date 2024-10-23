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
    local jpValue = player:getJobPointLevel(tpz.jp.AVATARS_FAVOR_EFFECT) * 3
    local duration = 60 + jpValue

    player:addStatusEffect(tpz.effect.AVATAR_S_FAVOR, 0, 0, duration)
    pet:addStatusEffect(tpz.effect.AVATAR_S_FAVOR, 0, 0, duration)
    return tpz.effect.AVATAR_S_FAVOR
end
