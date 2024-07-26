-----------------------------------
-- Ability: Tomahawk
-- Recast Time: 0:01:00
-- Duration: 0:00:30 (+0:00:15 for each merit, cap is 0:00:50)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player,target,ability)
    -- special defense down 50%
    if target:getMod(tpz.mod.SPDEF_DOWN) == 0 then
        local duration = 25 + player:getMerit(tpz.merit.TOMAHAWK)
        target:queue(0, function(target)
            target:addMod(tpz.mod.SPDEF_DOWN,50)
        end)
        target:queue(duration*1000, function(target)
            target:setMod(tpz.mod.SPDEF_DOWN,0)
        end)
    end
    target:updateClaim(player)
    if player:isPC() then
        player:removeAmmo()
    end
end
