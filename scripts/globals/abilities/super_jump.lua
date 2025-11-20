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

    local weapon = player:getEquipID(tpz.slot.MAIN)
    local hasSarissa = (weapon == tpz.items.SARISSA)

    -- Under Spirit Surge, Super Jump adds -50% enmity reduction to closest party member behind the dragoon
    if player:hasStatusEffect(tpz.effect.SPIRIT_SURGE) or hasSarissa then
        local minDistance = 9999
        local closestPartyMember = nil

        -- Find the closest party member
        local party = player:getPartyWithTrusts()
        for _, member in pairs(party) do
            local distance = member:checkDistance(player)
            if
                member:getID() ~= player:getID() and
                not member:isDead() and
                (distance < minDistance or closestPartyMember == nil)
            then
                closestPartyMember = member
                minDistance = distance
            end
        end

        -- It doesn't matter what direction the dragoon is facing http://wiki.ffo.jp/html/3367.html#comment_1
        if
            closestPartyMember and
            closestPartyMember:isBehind(player) and
            (player:checkDistance(target) < closestPartyMember:checkDistance(target)) -- Verify dragoon is closer than the party member that we want to reduce the enmity of
        then
            if target:isMob() then
                target:lowerEnmity(closestPartyMember, 50)
            end
        end
    end
end
