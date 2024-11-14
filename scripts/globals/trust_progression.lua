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
tpz = tpz or {}
tpz.trustProgression = tpz.trustProgression or {}

local trustProgData = {
    ['Melee'] = {
        items = {
            { id = tpz.items.COPPER_INGOT, contribution = 1 },
            { id = tpz.items.BRONZE_INGOT, contribution = 1 },
            { id = tpz.items.BRASS_INGOT, contribution = 1 },
            { id = tpz.items.IRON_INGOT, contribution = 2 },
            { id = tpz.items.STEEL_INGOT, contribution = 2 },
            { id = tpz.items.MYTHRIL_INGOT, contribution = 3 },
            { id = tpz.items.DARKSTEEL_INGOT, contribution = 3 },
            { id = tpz.items.ADAMAN_INGOT, contribution = 4 }
        },
        var = '[Trust]Melee'
    },
    ['Ranged'] = {
        items = {
            { id = tpz.items.PIECE_OF_ARROWWOOD_LUMBER, contribution = 1 },
            { id = tpz.items.PIECE_OF_LAUAN_LUMBER, contribution = 1 },
            { id = tpz.items.PIECE_OF_ELM_LUMBER, contribution = 1 },
            { id = tpz.items.PIECE_OF_MAPLE_LUMBER, contribution = 1 },
            { id = tpz.items.PIECE_OF_BEECH_LUMBER, contribution = 1 },
            { id = tpz.items.PIECE_OF_CHESTNUT_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_WALNUT_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_WILLOW_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_YEW_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_HOLLY_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_ASH_LUMBER, contribution = 2 },
            { id = tpz.items.PIECE_OF_OAK_LUMBER, contribution = 3 },
            { id = tpz.items.PIECE_OF_MAHOGANY_LUMBER, contribution = 3 },
            { id = tpz.items.PIECE_OF_ROSEWOOD_LUMBER, contribution = 3 },
            { id = tpz.items.PIECE_OF_EBONY_LUMBER, contribution = 3 },
            { id = tpz.items.PIECE_OF_ANCIENT_LUMBER, contribution = 4 },
            { id = tpz.items.PIECE_OF_RATTAN_LUMBER, contribution = 4 }
        },
        var = '[Trust]Ranged'
    },
    ['Tank'] = {
        items = {
            { id = tpz.items.SQUARE_OF_SHEEP_LEATHER, contribution = 1 },
            { id = tpz.items.SQUARE_OF_DHALMEL_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_RAM_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_BLACK_TIGER_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_SMILODON_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_KARAKUL_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_MANTA_LEATHER, contribution = 2 },
            { id = tpz.items.SQUARE_OF_COEURL_LEATHER, contribution = 3 },
            { id = tpz.items.SQUARE_OF_LYNX_LEATHER, contribution = 3 },
            { id = tpz.items.SQUARE_OF_MANTICORE_LEATHER, contribution = 4 },
            { id = tpz.items.SQUARE_OF_RUSZOR_LEATHER, contribution = 5 }
        },
        var = '[Trust]Tank'
    },
    ['Caster'] = {
        items = {
            { id = tpz.items.SQUARE_OF_GRASS_CLOTH, contribution = 1 },
            { id = tpz.items.SQUARE_OF_COTTON_CLOTH, contribution = 1 },
            { id = tpz.items.SQUARE_OF_LINEN_CLOTH, contribution = 2 },
            { id = tpz.items.SQUARE_OF_WOOL_CLOTH, contribution = 2 },
            { id = tpz.items.SQUARE_OF_VELVET_CLOTH, contribution = 2 },
            { id = tpz.items.SQUARE_OF_SILK_CLOTH, contribution = 3 },
            { id = tpz.items.SQUARE_OF_RAINBOW_CLOTH, contribution = 4 }
        },
        var = '[Trust]Caster'
    },
    ['Healer'] = {
        items = {
            { id = tpz.items.FLASK_OF_POISON_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_VENOM_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_PARALYZE_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_SLEEPING_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_SILENCING_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_BLINDING_POTION, contribution = 1 },
            { id = tpz.items.FLASK_OF_VITRIOL, contribution = 1 },
            { id = tpz.items.JAR_OF_FIRESAND, contribution = 2 }
        },
        var = '[Trust]Healer'
    },
    ['Support'] = {
        items = {
            { id = tpz.items.PONZE_OF_SHELL_POWDER, contribution = 1 },
            { id = tpz.items.HANDFUL_OF_ARMORED_ARROWHEADS, contribution = 1 },
            { id = tpz.items.PONZE_OF_CARAPACE_POWDER, contribution = 2 },
            { id = tpz.items.HANDFUL_OF_DEMON_ARROWHEADS, contribution = 2 },
            { id = tpz.items.HANDFUL_OF_MARID_TUSK_ARROWHEADS, contribution = 2 },
            { id = tpz.items.HANDFUL_OF_GARGOUILLE_ARROWHEADS, contribution = 3 },
        },
        var = '[Trust]Support'
    }
}

tpz.trustProgression.onTrigger = function(player, npc)
end

tpz.trustProgression.onTrade = function(player, npc, trade)
    local currentContribution = 0
    local tradedContribution = 0
    local totalContribution = 0
    local role = nil
    local roleFound = false

    -- Create a flag to ensure only one role's items are traded at a time
    local roleMatched = nil

    -- Iterate over each role in trustProgData
    for roleName, roleData in pairs(trustProgData) do
        for _, itemData in ipairs(roleData.items) do
            local itemId = itemData.id
            local itemContributionValue = itemData.contribution

            -- Check if the current item from trustProgData.items is present in the trade
            if npcUtil.tradeHasExactly(trade, itemId) then
                -- Check if a different role's item was already traded
                if roleMatched and roleMatched ~= roleData.var then
                    player:PrintToPlayer("You can only trade items for one role at a time.")
                    return
                end

                -- Assign the role if it's not already set
                if not roleMatched then
                    roleMatched = roleData.var
                    currentContribution = GetServerVariable(roleMatched)
                end

                -- Add the contribution value based on item quantity and its contribution value
                tradedContribution = tradedContribution + (trade:getItemQty(itemId) * itemContributionValue)
                roleFound = true -- Set flag if any item matches a role
            end
        end
    end

    -- If no matching items were found, prevent trade completion and notify the player
    if not roleFound then
        player:PrintToPlayer("Invalid items in trade for trust progression!")
        return
    end

    -- Complete the trade if all items are valid
    player:tradeComplete()

    -- Now, 'roleMatched' will contain the appropriate role string for the traded items
    totalContribution = currentContribution + tradedContribution
    SetServerVariable(roleMatched, totalContribution)
    player:PrintToPlayer(roleMatched .. " contribution was " .. currentContribution .. ", contribution is now " .. totalContribution)
end
