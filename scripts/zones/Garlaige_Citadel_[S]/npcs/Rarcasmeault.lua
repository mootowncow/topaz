-----------------------------------
-- Rarcasmeault
-- Involved in quest: The Flipside of Things
-----------------------------------
-- !addquest 7 11
-- !pos 146.175 -6.000 93.04 164
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local theFlipsideofThings = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FLIPSIDE_OF_THINGS)
    local theFlipsideofThingsProg = player:getCharVar("theFlipsideofThings")

    if (theFlipsideofThings == QUEST_ACCEPTED) then
        if player:hasKeyItem(tpz.ki.FIREPOWER_CASE) then
            return player:startEvent(9)
        else
            return player:startEvent(8) -- This is their default action until the quest is completed.
        end
    elseif (theFlipsideofThings == QUEST_AVAILABLE) then
        -- Start quest
        return player:startEvent(6)
    end

    return player:startEvent(4)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 6) and (option == 1) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FLIPSIDE_OF_THINGS)
        player:setCharVar("theFlipsideofThings", 1)
    elseif (csid == 9) then
        -- FIREPOWER_CASE is removed silently
        player:delKeyItem(tpz.ki.FIREPOWER_CASE)
        npcUtil.completeQuest(
            player,
            CRYSTAL_WAR,
            tpz.quest.id.crystalWar.THE_FLIPSIDE_OF_THINGS,
            { ki = tpz.ki.MAP_OF_VUNKERL_INLET, var = "theFlipsideofThings"}
        )
    end
end