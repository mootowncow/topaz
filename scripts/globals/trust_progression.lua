---------------------------------------------------------
-- Trust progression system
---------------------------------------------------------
require("scripts/globals/common")
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/roe")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/items")
require("scripts/globals/npc_util")
---------------------------------------------------------
-- TODO: Takes items that it shouldn't. If you trade elm logs + random items itll take all the items on trade
-- TODO: Only allow to trade 1 role at a time
tpz = tpz or {}
tpz.trustProgression = tpz.trustProgression or {}

local trustProgData = {
    ['Melee'] = {
        items = { tpz.items.COPPER_INGOT, tpz.items.BRONZE_INGOT },
        var = '[Trust]Melee'
    },
    ['Ranged'] = {
        items = { tpz.items.PIECE_OF_LAUAN_LUMBER, tpz.items.PIECE_OF_ELM_LUMBER },
        var = '[Trust]Ranged'
    },
}

tpz.trustProgression.onTrigger = function(player, npc)
end

tpz.trustProgression.onTrade = function(player, npc, trade)
    local currentContribution = 0
    local tradedContribution = 0
    local totalContribution = 0
    local role

    -- Iterate over each role in trustProgData
    for roleName, roleData in pairs(trustProgData) do
        for _, itemId in ipairs(roleData.items) do
            -- Check if the current item from trustProgData.items is present in the trade
            if npcUtil.tradeHas(trade, itemId) then
                role = roleData.var  -- Assign the .var (role) associated with the current item
                currentContribution = GetServerVariable(role)
                tradedContribution = tradedContribution + trade:getItemQty(itemId)
                totalContribution = currentContribution + tradedContribution
                player:PrintToPlayer("You traded item ID: " .. itemId .. " with quantity: " .. trade:getItemQty(itemId))
                player:tradeComplete()
            end
        end
    end

    -- Now, 'role' will contain the appropriate role string (e.g., "[Trust]Melee") for the traded items
    -- Use 'tradedContribution' and 'role' for further processing
    SetServerVariable(role, totalContribution)
    player:PrintToPlayer(role .. " contribution was " .. currentContribution .. " contribution is now " .. totalContribution)
end

