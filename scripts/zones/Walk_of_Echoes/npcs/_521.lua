-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Ornate Door
-- !pos -700 -17.6 -327 182
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day

    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) > QUEST_AVAILABLE and player:getCharVar("ChampOfDawnSeenCS") == 0 and
       (player:hasKeyItem(tpz.ki.BREATH_OF_DAWN1) and player:hasKeyItem(tpz.ki.BREATH_OF_DAWN2) and player:hasKeyItem(tpz.ki.BREATH_OF_DAWN3)) then
            player:setCharVar("ChampOfDawnSeenCS", 1)
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES) > QUEST_AVAILABLE or
       player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) > QUEST_AVAILABLE) and player:getCharVar("TrialByCaitSeenCS") == 0 and
       realday ~= player:getCharVar("TrialByCait_date") and
       (player:hasKeyItem(tpz.ki.BREATH_OF_DAWN1) or player:hasKeyItem(tpz.ki.BREATH_OF_DAWN2) or player:hasKeyItem(tpz.ki.BREATH_OF_DAWN3)) then
            player:setCharVar("TrialByCait_date", tonumber(os.date("%j")))
            player:setCharVar("TrialByCaitSeenCS", 1) -- Must wait 1 real life day before you can trigger the necessary cutscene.
            player:startEvent(17)
    else
        if not EventTriggerBCNM(player, npc) then
            player:messageSpecial(ID.text.DOOR_SHUT)
        end
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    EventFinishBCNM(player, csid, option)
end
