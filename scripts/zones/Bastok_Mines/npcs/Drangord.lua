-----------------------------------
-- Area: Bastok Mines
--  NPC: Drangord
-- Expert Miner
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/items")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local miningQuestAccepted = player:getCharVar("MiningQuestAccepted")
    local ID = zones[player:getZoneID()]

    if (miningQuestAccepted == 1) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.CHUNK_OF_ZINC_ORE, 25}, {tpz.items.CHUNK_OF_MYTHRIL_ORE, 10}, {tpz.items.CHUNK_OF_DARKSTEEL_ORE, 3} }) then
        if npcUtil.giveItem(player, tpz.items.AMATEURS_PICKAXE) then
            player:setCharVar("MiningQuestsCompleted", 1)
            player:PrintToPlayer("This should help you out nicely.",0,"Drangord")
            player:tradeComplete()
        end
    elseif (miningQuestAccepted == 2) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.CHUNK_OF_SILVER_ORE, 25}, {tpz.items.CHUNK_OF_GOLD_ORE, 10}, {tpz.items.CHUNK_OF_PLATINUM_ORE, 3} }) then
        if npcUtil.giveItem(player, tpz.items.INITIATES_PICKAXE) then
            player:delItem(tpz.items.AMATEURS_PICKAXE, 1)
            player:setCharVar("MiningQuestsCompleted", 2)
            player:PrintToPlayer("This should help you out nicely.",0,"Drangord")
            player:tradeComplete()
        end
    elseif (miningQuestAccepted == 3) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.IGNEOUS_ROCK, 99}, {tpz.items.GOBLIN_DIE, 99} }) then
        if npcUtil.giveItem(player, tpz.items.APPRENTICES_PICKAXE) then
            player:delItem(tpz.items.INITIATES_PICKAXE, 1)
            player:setCharVar("MiningQuestsCompleted", 3)
            player:PrintToPlayer("This should help you out nicely.",0,"Drangord")
            player:tradeComplete()
        end
    elseif (miningQuestAccepted == 4) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.CHUNK_OF_ALUMINUM_ORE, 50}, {tpz.items.HANDFUL_OF_IRON_SAND, 50}, {tpz.items.PINCH_OF_SULFUR, 50} }) then
        if npcUtil.giveItem(player, tpz.items.VETERANS_PICKAXE) then
            player:delItem(tpz.items.APPRENTICES_PICKAXE, 1)
            player:setCharVar("MiningQuestsCompleted", 4)
            player:PrintToPlayer("This should help you out nicely.",0,"Drangord")
            player:tradeComplete()
        end
    elseif (miningQuestAccepted == 5) and
    npcUtil.tradeHasExactly(trade, { {tpz.items.CHUNK_OF_LUMINIUM_ORE, 25}, {tpz.items.CHUNK_OF_ORICHALCUM_ORE, 25}, {tpz.items.CHUNK_OF_ADAMAN_ORE, 25} }) then
        if npcUtil.giveItem(player, tpz.items.FORSETIS_PICKAXE) then
            player:delItem(tpz.items.VETERANS_PICKAXE, 1)
            player:setCharVar("MiningQuestsCompleted", 5)
            player:PrintToPlayer("This should help you out nicely.",0,"Drangord")
            player:tradeComplete()
        end
    end
end

function onTrigger(player, npc)
    local miningSkill = player:getCharVar("MiningSkill")
    local miningQuestsCompleted = player:getCharVar("MiningQuestsCompleted")
    local miningQuestAccepted = player:getCharVar("MiningQuestAccepted")

    if (miningSkill > 10) and (miningQuestsCompleted == 0) then
        player:PrintToPlayer("You seem like you enjoy mining.\n Bring me 25 Zinc Ore, 10 Mythril Ore and 3 Darksteel Ore. I'll give you something nice in return.",0,"Drangord")
        player:setCharVar("MiningQuestAccepted", 1)
    elseif (miningSkill > 30) and (miningQuestsCompleted == 1) then
        player:PrintToPlayer("You seem like you enjoy mining.\n Bring me 25 Silver Ore, 10 Gold Ore and 3 Platinum Ore. I'll give you something nice in return.",0,"Drangord")
        player:setCharVar("MiningQuestAccepted", 2)
    elseif (miningSkill > 50) and (miningQuestsCompleted == 2) then
        player:PrintToPlayer("You seem like you enjoy mining.\n Bring me 99 Igneous Rocks and 99 Goblin Dice. I'll give you something nice in return.",0,"Drangord")
        player:setCharVar("MiningQuestAccepted", 3)
    elseif (miningSkill > 70) and (miningQuestsCompleted == 3) then
        player:PrintToPlayer("You seem like you enjoy mining.\n Bring me 50 Aluminum Ore, 50 Iron Sand and 50 Sulfur. I'll give you something nice in return.",0,"Drangord")
        player:setCharVar("MiningQuestAccepted", 4)
    elseif (miningSkill > 90) and (miningQuestsCompleted == 4) then
        player:PrintToPlayer("You seem like you enjoy mining.\n Bring me 25 Luminium Ore 25 Orichalcum Ore and 25 Adaman Ore. I'll give you something nice in return.",0,"Drangord")
        player:setCharVar("MiningQuestAccepted", 5)
    elseif player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STARDUST) == QUEST_ACCEPTED then
        player:startEvent(97)
    else
        player:startEvent(21)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
