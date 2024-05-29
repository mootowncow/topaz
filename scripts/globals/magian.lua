-----------------------------------
-- Magian Trial Global
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require('scripts/globals/magian_data')
require('scripts/globals/npc_util')
-----------------------------------
tpz = tpz or {}
tpz.magian = tpz.magian or {}
-- NOTE: This table should never be accessed directly, and is not guaranteed to contain
-- data unless returned via getPlayerTrialData().
tpz.magian.playerCache = tpz.magian.playerCache or {}

local magianMoogleInfo =
{
    ['Magian_Moogle_Blue']   = {   nil, 10141, 10142, 10143, 10144, 10148, tpz.itemType.ARMOR  },
    ['Magian_Moogle_Orange'] = { 10121, 10122, 10123, 10124, 10125, 10129, tpz.itemType.WEAPON },
}

tpz.magian.moogle =
{
    BLUE    = 17772782,
    ORANGE  = 17772778,
    GREEN   = 17772784,
}

tpz.magian.magianOnTrade = function(player, npc, trade)
    local moogleData = magianMoogleInfo[npc:getName()]
    local trialData = tpz.magian.trials
    local tradedItem = trade:getItem()

    if player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) then
        if (trade:getSlotCount() == 0) then
            return player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, tradedItem)
        end

        if (npc:getID() == tpz.magian.moogle.ORANGE) then
            for requiredItemId, trials in pairs(trialData) do
                if trade:hasItemQty(requiredItemId, 1) then
                    for tradeItem, trial in pairs(trials) do
                        local numRequired = trial.numRequired
                        local rewardItem = trial.rewardItem.itemId
                        local itemAugments = trial.rewardItem.itemAugments

                        if trade:hasItemQty(tradeItem, numRequired) then
                            -- Flatten the itemAugments table
                            local flatAugments = {}
                            for _, augmentPair in ipairs(itemAugments) do
                                for _, value in ipairs(augmentPair) do
                                    table.insert(flatAugments, value)
                                end
                            end

                            if (tpz.magian.IsValidReward(player, npc, trade, rewardItem)) then
                                player:addItem(rewardItem, 1, unpack(flatAugments))
                                player:tradeComplete()
                                return player:messageSpecial(ID.text.MAGIAN_TRIAL_COMPLETE, rewardItem) -- TODO: Probably a CS
                            else
                                return player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, rewardItem)
                            end
                        end
                    end
                end
            end
        end

        if (npc:getID() == tpz.magian.moogle.ORANGE) then
            player:messageSpecial(ID.text.ITEM_NOT_WEAPON_MAGIAN)
        elseif (npc:getID() == tpz.magian.moogle.BLUE) then
            player:messageSpecial(ID.text.ITEM_NOT_ARMOR_MAGIAN)
        end

        player:messageSpecial(ID.text.MAGIAN_NO_TRIAL)
    end
end

tpz.magian.IsValidReward = function(player, npc, trade, rewardItem)
    if IsRareItem(rewardItem) then
        if player:hasItem(rewardItem) then
            return false
        end
    end

    return true
end