-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andecia
-- Starts and Finishes Quest: Grave Concerns
-- !pos 167 0 45 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(547, 1) and trade:getItemCount() == 1 and player:getCharVar("OfferingWaterOK") == 1) then
            player:startEvent(624)
        end
    end
end

function onTrigger(player, npc)

    local Tomb = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRAVE_CONCERNS)
    local WellWater = player:hasItem(567) -- Well Water
    local Waterskin = player:hasItem(547) -- Tomb Waterskin

    if (Tomb == QUEST_AVAILABLE) then
        player:startEvent(541)
    elseif (Tomb == QUEST_ACCEPTED and WellWater == false and player:getCharVar("OfferingWaterOK") == 0) then
        player:startEvent(622)
    elseif (Tomb == QUEST_ACCEPTED and Waterskin == true and player:getCharVar("OfferingWaterOK") == 0) then
        player:startEvent(623)
    elseif (Tomb == QUEST_COMPLETED) then
        player:startEvent(558)
    else
        player:startEvent(540)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 541 and option == 0) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 567) -- Well Water
        else
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.GRAVE_CONCERNS)
            player:setCharVar("graveConcernsVar", 0)
            player:addItem(567)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 567) -- Well Water
        end
    elseif (csid == 624) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:tradeComplete()
            player:setCharVar("OfferingWaterOK", 0)
            player:addTitle(tpz.title.ROYAL_GRAVE_KEEPER)
            player:addGil(GIL_RATE*560)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*560)
            player:addExp(3500 * EXP_RATE)
            player:addFame(SANDORIA, 300)
            player:addItem(12592, 1, 23, 1) -- ACC+2
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12592) -- Doublet
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.GRAVE_CONCERNS)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12592) -- Doublet
        end
    end

end
