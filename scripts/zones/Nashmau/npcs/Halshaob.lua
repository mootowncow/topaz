-----------------------------------
-- Area: Nashmau
--  NPC: Halshaob
-- Type: Quest NPC
-- !pos 28.537 -7 -85.250 53
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local now = tonumber(os.date("%j"))
    local timer = player:getCharVar("Halshaob_Timer")
    local quest = player:getCharVar("Halshaob_Quest")
    local questSTAT = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
    local questRPE = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.ROYAL_PAINTER_ESCORT)
    
    if timer < now and quest == 0 then
        if (trade:getItemQty(tpz.items.IMPERIAL_BRONZE_PIECE) == 3) and trade:getItemCount() == 3 then
            player:tradeComplete()
            if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF) == QUEST_AVAILABLE then
                player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
                player:confirmTrade()
            end
            player:setCharVar("Halshaob_Timer", os.date("%j"))
            player:setCharVar("Halshaob_Quest", 2)
            player:startEvent(302, 2184, 3, 101)
        elseif (trade:getItemQty(tpz.items.IMPERIAL_SILVER_PIECE) == 1) and trade:getItemCount() == 1 and questSTAT == QUEST_COMPLETED then
          if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.ROYAL_PAINTER_ESCORT) == QUEST_AVAILABLE then
              player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.ROYAL_PAINTER_ESCORT)
              player:confirmTrade()
          end
          player:setCharVar("Halshaob_Timer", os.date("%j"))
          player:setCharVar("Halshaob_Quest", 4)
          player:startEvent(302, 2185, 1, 102)
        elseif trade:getItemQty(tpz.items.IMPERIAL_MYTHRIL_PIECE) == 1 and trade:getItemCount() == 1 and questRPE == QUEST_COMPLETED then
            if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TARGETING_THE_CAPTAIN) == QUEST_AVAILABLE then
                player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TARGETING_THE_CAPTAIN)
                player:confirmTrade()
            end
            player:setCharVar("Halshaob_Timer", os.date("%j"))
            player:setCharVar("Halshaob_Quest", 8)
            player:startEvent(302, 2186, 1, 103)
        end
    end
end

function onTrigger(player, npc)
    local now = tonumber(os.date("%j"))
    local timer = player:getCharVar("Halshaob_Timer")
    local quest = player:getCharVar("Halshaob_Quest")

    --if player:getCurrentMission(TOAU) > tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE then
        if timer > 0 then
            local arg1 = 4092
            local arg4 = 0
            local arg5 = 0

            -- arg1: Which quests are available?
         if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.ROYAL_PAINTER_ESCORT) == QUEST_COMPLETED then
             arg1 = 4080
         elseif player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF) == QUEST_COMPLETED then
             arg1 = 4088
         end

            -- arg4: Which quest is currently active?
            arg4 = player:getCharVar("Halshaob_Quest")

            -- arg5: Is the player already on a quest? Or completed one recently?
            if timer >= now or quest > 0 then
                arg5 = 1
            end

            player:startEvent(301, arg1, 0, 0, arg4, arg5)
        else
           player:startEvent(300)
        end
    --else
    --    player:startEvent(299)
    --end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 300 then
        player:setCharVar("Halshaob_Timer", 1)
        player:setCharVar("Halshaob_Quest", 0)
    end
end
