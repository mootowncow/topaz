-----------------------------------
-- Area: Bastok Markets
--  NPC: Degenhard
-- Starts & Ends Quest: The Bare Bones
-- Involved in Quests: Beat Around the Bushin
-- !pos -175 2 -135 235
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY) >= QUEST_ACCEPTED and
        npcUtil.tradeHasExactly(trade, {3541, 3542, 3543}) then
        player:startEvent(15)
    elseif player:getQuestStatus(BASTOK,tpz.quest.id.bastok.THE_BARE_BONES) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 880) then
        player:startEvent(258)
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED then
        player:startEvent(14)
    elseif player:getCharVar("BeatAroundTheBushin") == 3 then
        player:startEvent(342)
    elseif player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_BARE_BONES) == QUEST_AVAILABLE then
        player:startEvent(256)
    else
        player:startEvent(255)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 15 then
        npcUtil.giveItem(player, 5911)
        player:confirmTrade()
    elseif csid == 342 then
        player:setCharVar("BeatAroundTheBushin", 4)
    elseif csid == 256 then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_BARE_BONES)
    elseif csid == 258 then
        if (npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.THE_BARE_BONES, {ki = tpz.ki.MAP_OF_THE_DANGRUF_WADI, fame = 250})) then
            player:addExp(2000 * EXP_RATE)
            player:confirmTrade()
        end
    end
end
