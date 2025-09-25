----------------------------------
-- Area: Rolanberry Fields [S]
--  NPC: Naiko-Paneiko
-- Involved in quest: The Weekly Adventurer
-- !pos -316.786 -12.448 -118.721 91
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local theWeeklyAdventurer = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_WEEKLY_ADVENTURER)
    local theWeeklyAdventurerProg = player:getCharVar("theWeeklyAdventurer")

    if (theWeeklyAdventurer == QUEST_ACCEPTED) then
        -- Default or Retry state
        if theWeeklyAdventurerProg == 1 then
            -- These are dangerous lands, adventurer. We advise that you distance yourself from here.
            return player:startEvent(3)
        elseif theWeeklyAdventurerProg == 5 then -- Retry
            -- Oh, it's you again.
            return player:startEvent(3, 0, 0, 0, 0, 0, 0, 0, 1)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 3) then
        if (option == 0) then -- Passed the quiz
            player:setCharVar("theWeeklyAdventurer", 4)
        elseif (option == 1) then -- Picked wrong category
            player:setCharVar("theWeeklyAdventurer", 2)
        elseif (option == 2) then -- Reported wrong information
            player:setCharVar("theWeeklyAdventurer", 3)
        end
    end
end
