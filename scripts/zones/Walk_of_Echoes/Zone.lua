-----------------------------------
--
-- Zone: Walk_of_Echoes
-- Zone Id: 182
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/walk_of_echoes")
-----------------------------------

function onInitialize(zone)
    tpz.woe.zone.onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-420, 10, 0, 69)
    end

    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_AVAILABLE then
        cs = 15
    elseif player:getCharVar("TrialByCait_Won") == 1 then -- Incase of a DC when picking reward
        cs = 18
    elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_FORBIDDEN_REUNION) == QUEST_AVAILABLE then
        cs = 123
    end

    tpz.woe.zone.onZoneIn(player, prevZone)

    return cs
end

function OnZoneTick(player, zone, region)
    tpz.woe.zone.onZoneTick(player, zone, region)
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

    tpz.woe.zone.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 15 then
        player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN)
    elseif csid == 18 then
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
                player:messageSpecial(ID.text.CAITSITH_UNLOCKED, 0, 0, 0)
            elseif item > 0 then
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end
            player:setCharVar("TrialByCait_Won", 0)
            player:setCharVar("TrialByCaitSeenCS", 0)
            -- ?? player:addFame(blah, 30)
            if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_COMPLETED then
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES)
            else
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN)
            end
        end
    elseif csid == 123 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_FORBIDDEN_REUNION)
    end

    tpz.woe.zone.onEventFinish(player, csid, option)
end
