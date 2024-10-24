-----------------------------------
-- Area: Bastok Mines
--  NPC: Black Mud
-- Starts & Finishes Quest: Drachenfall
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    35.243, 7.000, -1.829,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
    89.659, 7.000, -0.181,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)

Drachenfall = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.DRACHENFALL)

    if (Drachenfall == QUEST_ACCEPTED) then
        count = trade:getItemCount()
        DrachenfallWater = trade:hasItemQty(492, 1)

        if (DrachenfallWater == true and count == 1) then
            player:startEvent(103)
        end
    end

end

function onTrigger(player, npc)

Drachenfall = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.DRACHENFALL)
Fame = player:getFameLevel(BASTOK)

    if (Drachenfall == QUEST_ACCEPTED) then
        BrassCanteen = player:hasItem(493)
        if (BrassCanteen == true) then
            player:startEvent(101)
        else
            player:startEvent(102)
        end
    elseif (Drachenfall == QUEST_AVAILABLE and Fame >= 2) then
        player:startEvent(101)
    else
        player:startEvent(100)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 101) then
        Drachenfall = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.DRACHENFALL)

        if (Drachenfall == QUEST_AVAILABLE) then
            FreeSlots = player:getFreeSlotsCount()
            if (FreeSlots >= 1) then
                player:addQuest(BASTOK, tpz.quest.id.bastok.DRACHENFALL)
                player:addItem(493)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 493)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 493)
            end
        end
    elseif (csid == 102) then
        FreeSlots = player:getFreeSlotsCount()
        if (FreeSlots >= 1) then
            player:addItem(493)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 493)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 493)
        end
    elseif (csid == 103) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:tradeComplete()
            player:completeQuest(BASTOK, tpz.quest.id.bastok.DRACHENFALL)
            player:addExp(7500 * EXP_RATE)
            player:addFame(BASTOK, 300)
            player:addTitle(tpz.title.DRACHENFALL_ASCETIC)
            player:addGil(GIL_RATE*2000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2000)
            player:addItem(13609, 1, 115, 4) -- Pet: StoreTP +5
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13609) -- Wolf Mantle +1
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13609) -- Wolf Mantle +1
        end
    end

end
