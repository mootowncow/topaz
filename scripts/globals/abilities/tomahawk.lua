-----------------------------------
-- Ability: Tomahawk
-- Recast Time: 0:01:00
-- Duration: 0:00:30 (+0:00:15 for each merit, cap is 0:01:30)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player,target,ability)
    local duration = 25 + player:getMerit(tpz.merit.TOMAHAWK)
    local weaponResDown = 50
    if (player:getName() == 'iron_eater') then
        duration = 90
    end

    handleWeaponResDown(player, target, weaponResDown, duration)

    if player:isPC() then
        player:removeAmmo()
    end

    target:updateClaim(player)
end
