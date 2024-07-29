-----------------------------------
-- Ability: Super Jump
-- Performs a super jump.
-- Obtained: Dragoon Level 50
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    jobUtil.CheckForFlyHigh(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    -- Reduce 99% of total accumulated enmity
    if (target:isMob()) then
        target:lowerEnmity(player, 99)
    end

    ability:setMsg(tpz.msg.basic.NONE)

    -- Prevent the player from performing actions while in the air
    player:queue(0, function(player)
        player:stun(5000)
        player:setSuperJump(1)
    end)
    player:queue(5000, function(player)
        player:setSuperJump(0)
    end)
    
    -- player:addStatusEffect(tpz.effect.SUPER_JUMP,1,0,5)

    -- If the Dragoon's wyvern is out and alive, tell it to use Super Climb
    local wyvern = player:getPet()
    if (wyvern ~= nil and wyvern:getHP() > 0) then
        if player:isMob() then
            wyvern:useJobAbility(652, wyvern)
        else
            if (player:getPetID() == tpz.pet.id.WYVERN) then
                wyvern:useJobAbility(652, wyvern)
            end
        end
    end

end
