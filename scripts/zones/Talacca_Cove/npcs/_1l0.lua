-----------------------------------
-- Area: Talacca_Cove
-- NPC:  rock slab (corsair job flag quest and BCNM Entrance)
-- !pos -99 -7 -91 57
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    local LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if (LuckOfTheDraw ==4) then
        player:startEvent(3)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    end

end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (csid == 3) then -- complete corsair job flag quest
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 5493)
        else
            player:setCharVar("LuckOfTheDraw", 5) -- var will remain for af quests
            player:addItem(19221) -- Firefly
            player:messageSpecial(ID.text.ITEM_OBTAINED, 19221) -- Firefly
            player:addItem(5363, 12) -- Bullet Pouch 12
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5363) -- Bullet Pouch x12
            player:addItem(5493) -- Corsair's Die
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5493) -- Corsair's Die
            player:delKeyItem(tpz.ki.FORGOTTEN_HEXAGUN)
            player:unlockJob(tpz.job.COR)
            player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_CORSAIR)
            player:completeQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)
        end
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end
