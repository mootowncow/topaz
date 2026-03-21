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
-- TODO: Add nadeeys tables data to wiki page (already have a toau augment page) Copy this augment format maybe? https://www.bg-wiki.com/ffxi/Obstin._Sash
-- TODO: Make sure additem works properly for magian augment items and normal items still, then merge into release
tpz = tpz or {}
tpz.reinforcementPoints = tpz.reinforcementPoints or {}

RankRPTable =
{
        50,   -- Rank 1
        130,  -- Rank 2
        250,
        420,
        640,
        920,
        1260,
        1670,
        2150,
        2710, -- Rank 10
        3360,
        4110,
        4970,
        5950,
        7060,
        8310,
        9720,
        11300,
        13060, -- 20
        15020, -- Rank 20
        17190,
        22240,
        25150,
        28330,
        31790,
        35550,
        39620,
        44020,
        48720,
        53920, -- Rank 30
}

local PATH_IDS =
{
    ['Path A'] = 1,
    ['Path B'] = 2,
    ['Path C'] = 3,
}

local PATH_NAMES =
{
    [1] = 'Path A',
    [2] = 'Path B',
    [3] = 'Path C',
}

local function calculateRank(rank, rp)
    local maxRank = #RankRPTable

    while rank < maxRank do
        local needed = RankRPTable[rank + 1]

        if rp < needed then
            break
        end
        rank = rank + 1
    end

    return rank
end

local function getRankTier(rank)
    -- Rank tiers is 0-9, 10-19, 20-29, 30
    if rank < 9 then
        return 1
    elseif rank < 19 then
        return 2
    elseif rank < 29 then
        return 3
    end

    return 4
end

local function getTierRpCap(rank)
    if rank < 9 then
        return 2150
    elseif rank < 19 then
        return 13060
    elseif rank < 29 then
        return 48720
    end

    return 0 -- Shouldn't happen
end

local function getMaxRank(pathData)
    local maxRank = 0

    for k in pairs(pathData.stats) do
        local r = tonumber(k:match("%d+"))
        if r and r > maxRank then
            maxRank = r
        end
    end

    return maxRank
end

local function getLeftOverMats(currentRP, tradedMatRp, validMatsQty, currentRank, maxRank)

    local tierCap = getTierRpCap(currentRank)
    local maxRankRP = RankRPTable[maxRank]

    local cap = math.min(tierCap, maxRankRP)

    local remainingRP = cap - currentRP

    if remainingRP <= 0 then
        return validMatsQty
    end

    local usableMats = math.ceil(remainingRP / tradedMatRp)
    usableMats = math.min(usableMats, validMatsQty)

    return validMatsQty - usableMats
end

local function DisplayItemRankData(player, npc, trade, augmentData)
    local npcName = npc:getName()
    local tradedItem = trade:getItem(0)
    local rawName = tradedItem:getName()
    local itemName = rawName:gsub("_", " "):lower()
    itemName = utils.CapitalizeFirstLetters(itemName)
    local currentRP = tradedItem:getReinforcementPoints()
    local currentRank = tradedItem:getReinforcementRank()
    local nextRankup = RankRPTable[currentRank +1]
    local currentPath = PATH_NAMES[tradedItem:getReinforcementPath()]
    local equipData = augmentData.equipment[tradedItem:getID()]
    local pathData  = equipData[currentPath]
    local maxRank = getMaxRank(pathData)

    if currentRank >= maxRank then
        nextRankup = 0
    end

    if nextRankup and currentRank then
        player:PrintToPlayer("Your " .. itemName .. " current Reinforcement Points are: " .. currentRP .. ". (Rank: " .. currentRank .. ") [" .. currentPath .. "].", 0, npcName)

        -- Check if item is currently at the max rank or not
        if currentRank >= maxRank then
            player:PrintToPlayer("Your " .. itemName .. " is at it's Reinforcement Points cap!", 0, npcName)
        else
            player:PrintToPlayer("Next rank up at " .. nextRankup .. " Reinforcement Points.", 0, npcName)
        end
        return
    end
end

local function giveAugmentItem(player, npc, trade, validEquipId, augmentPath, currentPathId, newRank, newRP, currency, currencyNeeded, augmentData)
    local equipData = augmentData.equipment[validEquipId]
    local pathData  = equipData[augmentPath]

    if not pathData or not pathData.stats then
        return false
    end

    local rankKey = "Rank " .. newRank
    local rankStats = pathData.stats[rankKey]
    local trialId = 0
    local rankPath = currentPathId

    if currentPathId == 0 then
        rankPath = PATH_IDS[augmentPath]
    end

    if newRank == 0 then
        -- Add Item
        player:addItem(validEquipId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialId, 0, newRP, rankPath)

        -- Delete currency
        player:delCurrency(currency, currencyNeeded)

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
    player:addItem(validEquipId, 1, augments[1], augments[2], augments[3], augments[4], augments[5], augments[6], augments[7], augments[8], trialId, augments[9], newRP, rankPath)

    -- Delete currency
    player:delCurrency(currency, currencyNeeded)

    return true
end

local function isValidMats(trade, equipId, currentRank, augmentData)
    local equipData = augmentData.equipment[equipId]

    if type(equipData) ~= 'table' then
        return false
    end

    for augmentPath, pathData in pairs(equipData) do
        if type(pathData) == 'table' and pathData.reqItem then

            -- Get required item by rank tier
            local rankTier = getRankTier(currentRank)
            local requiredItemIndex = pathData.reqItem[rankTier]

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

            if augmentData.equipment[itemId] then
                validEquipSlotId = slot
                validEquipId = itemId
                break
            end
        end

        local validEquipobjId = trade:getItem(validEquipSlotId)
        local currentRank = validEquipobjId:getReinforcementRank()

        -- Step 2: Check that the player is trading matching mats
        local validMats, validMatsQty, tradedMatRp, currency, currencyAmount, augmentPath = isValidMats(trade, validEquipId, currentRank, augmentData)
        if not validMats then
            player:PrintToPlayer("These materials cannot be used with this equipment.", 0, npcName)
            return false
        end

        -- Step 3: Check if the item can gain RP
        local equipData = augmentData.equipment[validEquipId]
        local pathData  = equipData[augmentPath]
        local maxRank = getMaxRank(pathData)

        if currentRank >= maxRank then
            player:PrintToPlayer("Your items Reinforcement Points are already maxed!", 0, npcName)
            return false
        end

        -- Step 4: Make sure the trade has only the validated items in it
        if not npcUtil.tradeHasExactly(trade, { validEquipId, {validMats, validMatsQty} }) then
            player:PrintToPlayer("Only trade me the base equipement and materials required to augment that equipment", 0, npcName)
            return false
        end

        -- Step 5: Calculate new RP and new Rank, give left over mats if trade exceeds current tier cap for that item
        local currentRP     = validEquipobjId:getReinforcementPoints()
        local currentPathId = validEquipobjId:getReinforcementPath()

        local newPathId = PATH_IDS[augmentPath]

        if currentPathId ~= 0 and currentPathId ~= newPathId then
            player:PrintToPlayer("This item is already locked to a different augment path.", 0, npcName)
            return false
        end

        -- Calculate leftover mats
        local leftoverMats = getLeftOverMats(currentRP, tradedMatRp, validMatsQty, currentRank, maxRank)

        -- Mats actually used
        local usableMats = validMatsQty - leftoverMats

        -- Real RP gained
        local rpGained = tradedMatRp * usableMats

        -- New RP total
        local newRP = currentRP + rpGained

        -- Cap RP to tier
        local tierCap = getTierRpCap(currentRank)
        if newRP > tierCap then
            newRP = tierCap
        end

        -- Cap RP to item max rank
        local maxRankRP = RankRPTable[maxRank]
        if newRP > maxRankRP then
            newRP = maxRankRP
        end

        -- Return left over mats
        if leftoverMats > 0 then
            player:addItem(validMats, leftoverMats)
        end

        -- Calculate rank
        local newRank = calculateRank(currentRank, newRP)

        -- Clamp to max augment rank
        if newRank > maxRank then
            newRank = maxRank
        end

        -- printf("currentRP %d, rpGained %d, newRP %d, currentRank %d, newRank %d, currentPathId %d", currentRP, rpGained, newRP, currentRank, newRank, currentPathId)

        -- Step 6: Check player has enough currency to upgrade the item
        -- Calculate Currency based on RP Gained (Number in currency part of augmentData table per 100 RP gained)
        local currencyNeeded = math.floor((currencyAmount * rpGained) / 100)
        local fmtCurrencyName = currency:gsub("_", " "):lower()
        fmtCurrencyName = utils.CapitalizeFirstLetters(fmtCurrencyName)
        if player:getCurrency(currency) < currencyNeeded then
            player:PrintToPlayer("You don't have enough [" .. fmtCurrencyName .. "] to augment your item. (Required: " .. currencyNeeded .. ").", 0, npcName)
            return false
        end

        -- Step 7: Add new item with new reinforcement points amount
        if not giveAugmentItem(player, npc, trade, validEquipId, augmentPath, currentPathId, newRank, newRP, currency, currencyNeeded, augmentData) then
            local ID = zones[player:getZoneID()]
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, validEquipId)
            return false
        end

        -- Step 8: Display message with how much RP gained, RP total, if the item ranked up and current rank
        local rawName = validEquipobjId:getName()
        local itemName = rawName:gsub("_", " "):lower()
        itemName = utils.CapitalizeFirstLetters(itemName)

        if (newRank > currentRank) then
            player:PrintToPlayer("Your " .. itemName .. " has ranked up to Rank " .. newRank .. "!", 0, npcName)
        end

        if (rpGained == 0) then
            player:PrintToPlayer("Your " .. itemName .. " cannot gain anymore RP with that material!" .. " (Current Rank: " .. newRank .. ")", 0, npcName)
        else
            local currentPath = PATH_NAMES[validEquipobjId:getReinforcementPath()]

            if currentPath then
                player:PrintToPlayer("Your " .. itemName .. " has gained " .. rpGained .. " RP for a total of " .. newRP .. " RP (Current Rank: " .. newRank .. ") [" .. currentPath .. "]", 0, npcName)
            else
                player:PrintToPlayer("Your " .. itemName .. " has gained " .. rpGained .. " RP for a total of " .. newRP .. " RP (Current Rank: " .. newRank .. ")", 0, npcName)
            end

            if leftoverMats > 0 then
                player:PrintToPlayer(leftoverMats .. " materials were returned to you.", 0, npcName)
            end
        end

        return true
    end

    player:PrintToPlayer("I can't do anything with these items.", 0xD, npcName)

    return false
end

tpz.reinforcementPoints.onTrade = function(player, npc, trade, augmentData)
    local npcName = npc:getName()

    if trade:getSlotCount() == 1 then
        return DisplayItemRankData(player, npc, trade, augmentData)
    end

    if isValidTrade(player, npc, trade, augmentData) then
        return player:confirmTrade()
    end
end

tpz.reinforcementPoints.onTrigger = function(player, npc, augmentData)
end
