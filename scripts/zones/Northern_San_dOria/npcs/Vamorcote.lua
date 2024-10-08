-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- Expert Logger
-- !pos -137.070 10.999 161.855 231
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/items")
require("scripts/globals/settings")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local loggingQuestAccepted = player:getCharVar("LoggingQuestAccepted")

    -- "The Setting Sun" conditional script
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(535, 1) and trade:getItemCount() == 1) then
            player:startEvent (658)
        end
    elseif (loggingQuestAccepted == 1) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.RONFAURE_CHESTNUT, 25}, {tpz.items.MAPLE_LOG, 25}, {tpz.items.CHESTNUT_LOG, 10} }) then
        if npcUtil.giveItem(player, tpz.items.AMATEURS_HATCHET) then
            player:setCharVar("LoggingQuestsCompleted", 1)
            player:PrintToPlayer("This should help you out nicely.",0,"Vamorcote")
            player:tradeComplete()
        end
    elseif (loggingQuestAccepted == 2) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.ELM_LOG, 25}, {tpz.items.WALNUT_LOG, 25}, {tpz.items.HOLLY_LOG, 25} }) then
        if npcUtil.giveItem(player, tpz.items.INITIATES_HATCHET) then
            player:delItem(tpz.items.AMATEURS_HATCHET, 1)
            player:setCharVar("LoggingQuestsCompleted", 2)
            player:PrintToPlayer("This should help you out nicely.",0,"Vamorcote")
            player:tradeComplete()
        end
    elseif (loggingQuestAccepted == 3) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.ROSEWOOD_LOG, 50}, {tpz.items.EBONY_LOG, 50}, {tpz.items.DRYAD_ROOT, 25} }) then
        if npcUtil.giveItem(player, tpz.items.APPRENTICES_HATCHET) then
            player:delItem(tpz.items.INITIATES_HATCHET, 1)
            player:setCharVar("LoggingQuestsCompleted", 3)
            player:PrintToPlayer("This should help you out nicely.",0,"Vamorcote")
            player:tradeComplete()
        end
    elseif (loggingQuestAccepted == 4) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.JACARANDA_LOG, 50}, {tpz.items.TEAK_LOG, 50}, {tpz.items.DRAGON_FRUIT, 50} }) then
        if npcUtil.giveItem(player, tpz.items.VETERANS_HATCHET) then
            player:delItem(tpz.items.APPRENTICES_HATCHET, 1)
            player:setCharVar("LoggingQuestsCompleted", 4)
            player:PrintToPlayer("This should help you out nicely.",0,"Vamorcote")
            player:tradeComplete()
        end
    elseif (loggingQuestAccepted == 5) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.BLOODWOOD_LOG, 50}, {tpz.items.DOGWOOD_LOG, 50}, {tpz.items.DATE, 50} }) then
        if npcUtil.giveItem(player, tpz.items.ULLRS_HATCHET) then
            player:delItem(tpz.items.VETERANS_HATCHET, 1)
            player:setCharVar("LoggingQuestsCompleted", 5)
            player:PrintToPlayer("This should help you out nicely.",0,"Vamorcote")
            player:tradeComplete()
        end
    end
end

function onTrigger(player, npc)
    -- Look at the "The Setting Sun" quest status and San d'Oria player's fame
    theSettingSun = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)
    local loggingSkill = player:getCharVar("LoggingSkill")
    local loggingQuestsCompleted = player:getCharVar("LoggingQuestsCompleted")
    local loggingQuestAccepted = player:getCharVar("LoggingQuestAccepted")

    if (theSettingSun == QUEST_AVAILABLE  and
        player:getFameLevel(SANDORIA) >= 5 and
        player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL) >= QUEST_ACCEPTED)
    then
        player:startEvent(654, 0, 535, 535) --The quest is offered to the player.
    elseif (theSettingSun == QUEST_ACCEPTED) then
        player:startEvent(655, 0, 0, 535) --The NPC asks if the player got the key.'
    elseif (theSettingSun == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(659) --The quest is already done by the player and the NPC does small talks.
    elseif (loggingSkill > 10) and (loggingQuestsCompleted == 0) then
        player:PrintToPlayer("You seem like you enjoy logging.\n Bring me 25 Ronfaure Chestnuts 25 Maple Logs and 10 Chestnut Logs. I'll give you something nice in return.",0,"Vamorcote")
        player:setCharVar("LoggingQuestAccepted", 1)
    elseif (loggingSkill > 30) and (loggingQuestsCompleted == 1) then
        player:PrintToPlayer("You seem like you enjoy logging.\n Bring me 25 Elm Logs, 25 Walnut Logs and 25 Holly Logs. I'll give you something nice in return.",0,"Vamorcote")
        player:setCharVar("LoggingQuestAccepted", 2)
    elseif (loggingSkill > 50) and (loggingQuestsCompleted == 2) then
        player:PrintToPlayer("You seem like you enjoy logging.\n Bring me 50 Rosewood Logs, 50 Ebony Logs and 25 Dryad Roots. I'll give you something nice in return.",0,"Vamorcote")
        player:setCharVar("LoggingQuestAccepted", 3)
    elseif (loggingSkill > 70) and (loggingQuestsCompleted == 3) then
        player:PrintToPlayer("You seem like you enjoy logging.\n Bring me 50 Jacaranda Logs, 50 Teak Logs and 50 Dragon Fruits. I'll give you something nice in return.",0,"Vamorcote")
        player:setCharVar("LoggingQuestAccepted", 4)
    elseif (loggingSkill > 90) and (loggingQuestsCompleted == 4) then
        player:PrintToPlayer("You seem like you enjoy logging.\n Bring me 50 Bloodwood Logs, 50 Dogwood Logs and 50 Dates. I'll give you something nice in return.",0,"Vamorcote")
        player:setCharVar("LoggingQuestAccepted", 5)
    else
        player:startEvent(651)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 654 and option == 1) then --Player accepts the quest
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)
    elseif (csid == 658) then --The player trades the Engraved Key to the NPC. Here come the rewards!
        player:tradeComplete()
        player:addGil(GIL_RATE*10000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000)
        player:addExp(12500 * EXP_RATE)
        player:addFame(SANDORIA, 1000)
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)
    end
end
