-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Ornate Door
-- !pos -700 -17.6 -327 182
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")
require("scripts/globals/battlefield")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local championOfDawnAcceptedOrCompleted = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) > QUEST_AVAILABLE
    local championofDawnCompleted = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_COMPLETED
    local aForbiddenReunionAccepted = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_FORBIDDEN_REUNION) == QUEST_ACCEPTED
    local hasAllBreathOfDawn = player:hasKeyItem(tpz.ki.BREATH_OF_DAWN1) and player:hasKeyItem(tpz.ki.BREATH_OF_DAWN2) and player:hasKeyItem(tpz.ki.BREATH_OF_DAWN3)

    -- Intro CS before first fight
    if championOfDawnAcceptedOrCompleted and hasAllBreathOfDawn and (player:getCharVar("ChampOfDawnSeenCS") == 0) then
        player:startEvent(16) -- intro CS
    -- Intro before A Forbidden Reunion fight
    elseif aForbiddenReunionAccepted and (player:getCharVar("aForbiddenReunionSeenCS") == 0) then
        player:startEvent(124)
    -- Repeat fight quest start
    elseif championOfDawnAcceptedOrCompleted and not hasAllBreathOfDawn and (player:getCharVar("ChampOfDawnSeenCS") == 2) then
        player:startEvent(19)
    -- Repeat fight (The Dawn Also Rises)
    elseif championofDawnCompleted and hasAllBreathOfDawn and (player:getCharVar("TrialByCaitSeenCS") == 0) then
        player:startEvent(20) -- Cutscene right before fighting
    -- First fight (Champion of Dawn)
    elseif championOfDawnAcceptedOrCompleted and hasAllBreathOfDawn and (player:getCharVar("ChampOfDawnSeenCS") == 1) then
        player:startEvent(17) -- Cutscene right before fighting
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
    if csid == 16 then
        player:setCharVar("ChampOfDawnSeenCS", 1)
    elseif csid == 17 then
        player:setCharVar("ChampOfDawnSeenCS", 2)
        player:setCharVar("TrialByCaitSeenCS", 1)
    elseif csid == 20 then
        player:setCharVar("TrialByCaitSeenCS", 1)
    elseif csid == 124 then
        player:addKeyItem(tpz.ki.BUTTERFLYSHAPED_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BUTTERFLYSHAPED_KEY)
        player:setCharVar("aForbiddenReunionSeenCS", 1)
    end
    EventFinishBCNM(player, csid, option)
end
