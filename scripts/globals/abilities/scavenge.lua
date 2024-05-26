-----------------------------------
-- Ability: Scavenge
-- Searches the ground around user for items.
-- Obtained: Ranger Level 10
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability, action)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
local items = {
            4112, -- Potion
            4113, -- Potion +1
            4114, -- Potion +2
            4115, -- Potion +3
            4116, -- Hi-potion 
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4119, -- Hi-potion +3
            4120, -- X-potion
            4121, -- X-potion +2
            4122, -- X-potion +3
            4123, -- X-potion +3
            4124, -- Max-potion 
            4125, -- Max-potion +1
            4126, -- Max-potion +2
            4127, -- Max-potion +3


            4128, -- Ether
            4129, -- Ether +1
            4130, -- Ether +2
            4131, -- Ether +3
            4132, -- Hi-ether
            4133, -- Hi-ether +1
            4134, -- Hi-ether +2 
            4135, -- Hi-ether +3
            4136, -- Super Ether
            4137, -- Super Ether +1
            4138, -- Super Ether +2
            4139, -- Super Ether +3
            4140, -- Pro-ether
            4141, -- Pro-ether +1
            4142, -- Pro-ether +2
            4143, -- Pro-ether +3

            4148, -- Antidote
            4150, -- Eye Drops
            4151, -- Echo Drops
            4154, -- Holy Water
}

    local consumables =
    {
        -- 1-9
        [0] =
        {
            4112, -- Potion
            4148, -- Antidote
        },
        -- 10-19
        [1] =
        {
            4113, -- Potion +1
            4114, -- Potion +2
            4115, -- Potion +3
            4128, -- Ether
            4148, -- Antidote
            4150, -- Eye Drops
        },
        -- 20-29
        [2] = 
        {
            4113, -- Potion +1
            4114, -- Potion +2
            4115, -- Potion +3
            4116, -- Hi-potion
            4148, -- Antidote
            4150, -- Eye Drops
        },
        -- 30-39
        [3] =
        {
            4115, -- Potion +3
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4148, -- Antidote
            4150, -- Eye Drops
            4151, -- Echo Drops
        },
        -- 40-49
        [4] =
        {
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4119, -- Hi-potion +3
            4148, -- Antidote
            4150, -- Eye Drops
            4151, -- Echo Drops
        },
        -- 50-59
        [5] =
        {
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4119, -- Hi-potion +3
            4148, -- Antidote
            4150, -- Eye Drops
            4151, -- Echo Drops
        },
        -- 60-69
        [6] =
        {
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4119, -- Hi-potion +3
            4148, -- Antidote
            4150, -- Eye Drops
            4151, -- Echo Drops
            4154, -- Holy Water
        },
        -- 70-75
        [7] =
        {
            4117, -- Hi-potion +1
            4118, -- Hi-potion +2
            4119, -- Hi-potion +3
            4150, -- Eye Drops
            4154, -- Holy Water
        }
    }
    
    local key = math.floor(player:getMainLvl() / 10)

    -- If subbing RNG and RNG is underleveled, use RNG level istead of main job Level
    if player:getSubLvl() < math.floor(player:getMainLvl() / 2) then
        key = math.floor(player:getSubLvl() / 10)
    end

    local resultTable = consumables[key]
    local result = resultTable[math.random(#resultTable)]

    -- RNG AF2 quest check
    local FireAndBrimstoneCS = player:getCharVar("fireAndBrimstone")
    local oldEarring = 1113

    if (player:getZoneID() == 151 and FireAndBrimstoneCS == 5 and-- zone + quest match
        player:hasItem(oldEarring) == false and -- make sure player doesn't already have the earring
        player:getYPos() > -43 and player:getYPos() < -38 and -- Y match
        player:getXPos() > -85 and player:getXPos() < -73 and -- X match
        player:getZPos() > -85 and player:getZPos() < -75 and -- Z match
        math.random(100) < 50) then

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, oldEarring)
            return
        else
            player:addItem(oldEarring)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, oldEarring)
        end
    else

        local bonuses = (player:getMod(tpz.mod.SCAVENGE_EFFECT)  + player:getMerit(tpz.merit.SCAVENGE_EFFECT) ) / 100
        local arrowsToReturn = math.floor(math.floor(player:getLocalVar("ArrowsUsed")  % 10000) * (player:getMainLvl() / 200 + bonuses))
        local playerID = target:getID()

        player:addTempItem(result)
        action:messageID(playerID, 140) -- Player finds xxx item. xxx being returned itemID
        return result
    end
end
