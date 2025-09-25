----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Naiko-Paneiko
-- Involved in quest: The Weekly Adventurer
-- !addquest 7 2
-- !pos 294.030 -33.443 -28.637 171
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
        if theWeeklyAdventurerProg == 1 or theWeeklyAdventurerProg == 5 then
            -- What are you doing, kid? Get to the Rolanberry Fields rightaru away!
            return player:startEvent(21)
        elseif theWeeklyAdventurerProg == 4 then -- Success
            -- Oh, there you are, kid. Greataru work!
            return player:startEvent(19, 171, 1, 2984, 3, 0, 10, 0, 0)
        elseif theWeeklyAdventurerProg == 2 then -- Fail type 1
            -- Oooh, look who's back! We got problems, kid? I just don'taru get it.
            return player:startEvent(17)
        elseif theWeeklyAdventurerProg == 3 then -- Fail type 2
            -- Oooh, look who's back! We got problems, kid? This just doesn't make any sense!
            return player:startEvent(18)
        end
    elseif (theWeeklyAdventurer == QUEST_AVAILABLE) then
        -- Hey there, kid, I'm Naiko-Paneiko, up-and-coming ace journalist
        return player:startEvent(16)
    end

    return player:startEvent(20)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 16) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_WEEKLY_ADVENTURER)
        npcUtil.giveKeyItem(player, tpz.ki.SCOOP_DEDICATED_LINKPEARL)
        player:setCharVar("theWeeklyAdventurer", 1)
    elseif (csid == 17) then
        player:setCharVar("theWeeklyAdventurer", 5)
    elseif (csid == 18) then
        player:setCharVar("theWeeklyAdventurer", 5)
    elseif (csid == 19) then
        -- SCOOP_DEDICATED_LINKPEARL is removed silently
        player:delKeyItem(tpz.ki.SCOOP_DEDICATED_LINKPEARL)
        npcUtil.completeQuest(
            player,
            CRYSTAL_WAR,
            tpz.quest.id.crystalWar.THE_WEEKLY_ADVENTURER,
            { ki = tpz.ki.MAP_OF_FORT_KARUGONARUGO, var = "theWeeklyAdventurer"}
        )
    end
end
