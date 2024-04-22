-----------------------------------
-- Area: Nashmau
--  NPC: Paparoon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/items")
-----------------------------------

function onTrade(player, npc, trade)
    -----------------------------------
    local alexandriteItemNamesTable =
    {
        [tpz.items.PIECE_OF_ALEXANDRITE]    = 'Alexandrite',
        [tpz.items.COTTON_COIN_PURSE]       = 'Cotton Coin Purse',
        [tpz.items.LINEN_COIN_PURSE]        = 'Linen Coin Purse',
    }

    local gilTable =
    {
        tpz.items.PIECE_OF_ALEXANDRITE,
        tpz.items.COTTON_COIN_PURSE,
        tpz.items.LINEN_COIN_PURSE,
    }
    -----------------------------------

    -- Check if the trade only contains alexandrite items
    local isValidTrade = true
    for v, _ in pairs(alexandriteItemNamesTable) do
        if not npcUtil.tradeHas(trade, v) then
            isValidTrade = false
            break
        end
    end

    if not isValidTrade then
        -- Handle invalid trade here
        player:PrintToPlayer("Invalid trade! Please trade only Alexandrite items.", 0, "Paparoon")
        return
    end

    -- Trade any amount of alexandrite items to store them
    for v, name in pairs(alexandriteItemNamesTable) do
        if npcUtil.tradeHas(trade, v) then
            local currentAmount = player:getCharVar(name)
            local tradeAmount = trade:getItemQty(v)
            local newAmount = currentAmount + tradeAmount
            player:setCharVar(name, newAmount)
            player:PrintToPlayer("I was holding " .. currentAmount .. " " .. name .. " for you.", 0, "Paparoon")
            player:PrintToPlayer("I am now holding " .. newAmount .. " " .. name .. " for you.", 0, "Paparoon")
            return
        end
    end


    -- Trade Specificed gil amount to get the alexandrite items back
    for _, gil in pairs(gilTable) do
        if (gil == trade:getGil()) then
            local alexandriteNameBase = GetItem(alexandriteItemNamesTable[gil])
            local alexandriteName = string.gsub(alexandriteNameBase:getName(), '_', ' ');
            local amount = player:getCharVar(alexandriteName)
            player:addItem(gil, amount)
            player:addGil(gil)
            player:setCharVar(alexandriteName, 0)
            -- TODO: NPC text saying what happened
            player:tradeComplete()
            return
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(26)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
