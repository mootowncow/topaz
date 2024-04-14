-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Optistery
-- Type: Quest NPC
-- !pos  -56.952 -6.249 92.029 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local lostBookProgress = player:getCharVar("TheLostBookProgress")
    if lostBookProgress == 4 and npcUtil.tradeHasExactly(trade, 2550) and player:hasKeyItem(tpz.ki.LYNX_PELT) then
        player:startEvent(146) -- Items accepted CS
    end
end

function onTrigger(player, npc)
    local lostBookQuestStatus = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_LOST_BOOK)
    local lostBookProgress = player:getCharVar("TheLostBookProgress")

    if lostBookProgress == 3 then
        player:startEvent(145) -- Player is told to get Vellum and LYNX_PELT
    elseif lostBookProgress == 4 then
        player:startEvent(149) -- Reminder to get vellum and LYNX_PELT
    elseif lostBookProgress == 5 then
        player:startEvent(147) -- Quest Complete CS
    end
    -- no CS or dialog found for the 1 day wait
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 145 then
        player:setCharVar("TheLostBookProgress", 4)
    elseif csid == 146 then
        player:setCharVar("TheLostBookProgress", 5)
        player:confirmTrade()
        player:delKeyItem(tpz.ki.LYNX_PELT)
    elseif csid == 147 then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_LOST_BOOK, {item=4873, var={"TheLostBookProgress", "LostBookTrade"}})
    end
end
