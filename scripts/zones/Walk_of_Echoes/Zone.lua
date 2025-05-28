-----------------------------------
--
-- Zone: Walk_of_Echoes
--
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    -- WINGSCUSTOM: cait sith avatar quest available when currently-implemented WOTG missions are completed
    -- This needs to be changed as more missions are implemented
    local highestMission = {tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK, "PURPLE_THE_NEW_BLACK"}
    local caitSithAvailable = player:hasCompletedMission(WOTG, highestMission[1])

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-420, 10, 0, 69)
    end

    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_AVAILABLE then
        if caitSithAvailable then
            cs = 15
        else
            -- give message once fully loaded in
            player:timer(3000, function(player)
                player:PrintToPlayer(string.format("Please complete the highest implemented WotG mission (%s) to flag Champion of the Dawn",string.gsub(string.lower(highestMission[2]),"_"," ")))
            end)
        end
    else
        if player:getCharVar("TrialByCait_Won") == 1 then
            cs = 18
--            player:timer(3000, function(player)
--                numitem = 0
--
--                if (player:hasItem(28454)) then numitem = numitem + 2; end  -- nesanica_belt
--                if (player:hasItem(28567)) then numitem = numitem + 4; end  -- nesanica_ring
--                if (player:hasItem(28382)) then numitem = numitem + 6; end  -- nesanica_torque
--
--
--                player:startEvent(18, 0, 0, 0, 0, numitem)
--            end)
        end
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
     if csid == 18 then
        numitem = 32 -- for lilisette to.. is flag 32, so start with removing that

        if (player:hasSpell(307)) then numitem = numitem + 16; end -- Cait Sith Spell
        if (player:hasItem(28454)) then numitem = numitem + 1; end  -- nesanica_belt
        if (player:hasItem(28567)) then numitem = numitem + 2; end  -- nesanica_ring
        if (player:hasItem(28382)) then numitem = numitem + 4; end  -- nesanica_torque
        player:updateEvent(28454, 28567, 28382, 388, 182, 2, 0, numitem)
     end
end

function onEventFinish(player, csid, option)
    if csid == 15 then
        player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN)
    elseif csid == 18 then
        print(option)
        local item = 0
        if (option == 1) then item = 28454      -- nesanica_belt
        elseif (option == 2) then item = 28567  -- nesanica_ring
        elseif (option == 3) then item = 28382  -- nesanica_torque
        end

        if (player:getFreeSlotsCount() == 0 and not (option == 4 or option == 5)) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if (option == 4) then
                player:addGil(GIL_RATE*10000)
                player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000) -- Gil
            elseif (option == 5) then
                player:addSpell(307) -- Cait Sith Spell
                player:messageSpecial(ID.text.IFRIT_UNLOCKED, 0, 0, 0)
            elseif item > 0 then
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end
            player:setCharVar("TrialByCait_Won", 0)
            player:setCharVar("TrialByCait_date", os.date("%j")) -- %M for next minute, %j for next day
            -- ?? player:addFame(blah, 30)
            if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_COMPLETED then
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES)
            else
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN)
            end
        end
    end
end
