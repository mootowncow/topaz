-----------------------------------
--
--  ToAU Augments
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
require("scripts/globals/items")
require("scripts/globals/augments")
-----------------------------------
-- TODO: Way to check that the item ranked up THEN add mods based on NEW rank
tpz = tpz or {}
tpz.itemRankPoints = tpz.itemRankPoints or {}

local function giveAugmentItem(player, npc, trade, validEquipId, augmentPath, currentRank, newRP, augmentData)
    local equipData = augmentData.equipment[validEquipId]
    local pathData  = equipData[augmentPath]

    if not pathData or not pathData.stats then
        return false
    end

    local rankKey = "Rank " .. currentRank
    local rankStats = pathData.stats[rankKey]
    local trialId = 0

    if currentRank == 0 then
        printf("Adding Rank 0 item with %d RP", newRP)

        player:addItem(validEquipId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialId, 0, newRP)
        return true
    end

    if not rankStats then
        printf("Invalid rank %s", rankKey)
        return false
    end

    if player:getFreeSlotsCount() < 1 then
        return false
    end

    local augments = {}
    local i = 1

    for aug, value in pairs(rankStats) do
        augments[i] = aug
        augments[i + 1] = value
        i = i + 2
    end

    -- Add Item
    printf("Adding %d rank points", newRP)
    player:addItem(validEquipId, 1, augments[1], augments[2], augments[3], augments[4], augments[5], augments[6], augments[7], augments[8], trialId, augments[9], newRP)

    return true
end

local function validMats(trade, equipId, rank, augmentData)
    local equipData = augmentData.equipment[equipId]

    if type(equipData) ~= 'table' then
        return false
    end

    for augmentPath, pathData in pairs(equipData) do
        if type(pathData) == 'table' and pathData.reqItem then

            -- Get required item by rank tier
            local requiredItemIndex = pathData.reqItem[math.floor(rank / 10) + 1]

            if requiredItemIndex and npcUtil.tradeHas(trade, requiredItemIndex.id) then
                -- Get currency key + value
                local currencyName = nil
                local currencyAmount = nil

                if pathData.currency then
                    for key, value in pairs(pathData.currency) do
                        currencyName = key
                        currencyAmount = value
                        break
                    end
                end

                return requiredItemIndex.id,
                       trade:getItemQty(requiredItemIndex.id),
                       requiredItemIndex.rp,
                       currencyName,
                       currencyAmount,
                       augmentPath
            end
        end
    end

    return false
end

local function isValidTrade(player, npc, trade, augmentData)
    local npcName = npc:getName()

    -- Step 1: Check that player is trading valid items
    local validEquip = false

    for equipmentId in pairs(augmentData.equipment) do
        if npcUtil.tradeHas(trade, equipmentId) then
            validEquip = true
            break
        end
    end

    if validEquip then
        local validEquipSlotId = nil
        local validEquipId = nil

        -- Find the trade slot the valid base item is being traded into
        for slot = 0, trade:getSlotCount() - 1 do
            local itemId = trade:getItemId(slot)
            printf("itemId %d", itemId)

            if augmentData.equipment[itemId] then
                validEquipSlotId = slot
                validEquipId = itemId
                break
            end
        end

        local validEquipobjId = trade:getItem(validEquipSlotId)
        local currentRank = validEquipobjId:getRank()
        printf("currentRank %d", currentRank)

        -- Step 2: Check if the item can gain RP
        if currentRank >= 20 then
            player:PrintToPlayer("Your items rank is already maxed!", 0, npcName)
            return false
        end

        -- Step 3: Check that the player is trading matching mats
        local validMats, validMatsQty, tradedMatRp, currency, currencyAmount, augmentPath = validMats(trade, validEquipId, currentRank, augmentData)
        if not validMats then
            player:PrintToPlayer("These materials cannot be used with this equipment.", 0, npcName)
            return false
        end

        -- Step 4: Make sure the trade has only the validated items in it
        if not npcUtil.tradeHasExactly(trade, { validEquipId, {validMats, validMatsQty} }) then
            player:PrintToPlayer("Only trade me the base equipement and materials required to augment that equipment", 0, npcName)
            return false
        end

        -- Step 5: Check player has enough currency to upgrade the item
        if player:getCurrency(currency) <= currencyAmount then
            player:PrintToPlayer("You don't have enough " .. currency .. " to augment your item.", 0, npcName)
            return false
        end

        -- Step 6: Add new item with new rank points amount
        local currentRP = validEquipobjId:getRankPoints()
        local rpGained = tradedMatRp * validMatsQty
        local newRP = currentRP + rpGained
        printf("currentRP %d, rpGained %d, newRP %d", currentRP, rpGained, newRP)

        printf("currentRP %d", currentRP)
        if not giveAugmentItem(player, npc, trade, validEquipId, augmentPath, currentRank, newRP, augmentData) then
            local ID = zones[player:getZoneID()]
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, validEquipId)
            return false
        end

        -- Step 7: Display message with how much RP gained and RP total
        local rawName = validEquipobjId:getName()
        local itemName = utils.PunctuateString(rawName)
        printf("New RP %d", newRP)

        player:PrintToPlayer("Your " .. itemName .. " has gained " .. rpGained .. " RP for a total of " .. newRP .. " RP. (Current Rank: " .. currentRank .. ")", 0, npcName)

        return true
    end

    return false
end

tpz.itemRankPoints.onTrade = function(player, npc, trade, augmentData)
    local npcName = npc:getName()

    if isValidTrade(player, npc, trade, augmentData) then
        return player:confirmTrade()
    end

    return player:PrintToPlayer("I can't do anything with these items.", 0xD, npcName)
end

tpz.itemRankPoints.onTrigger = function(player, npc, augmentData)
end
