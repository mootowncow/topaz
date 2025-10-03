-----------------------------------
-- Area: Sea Serpent Grotto
--   NPC: Hurr the Betrayer
-- Type: Involved in the "Sahagin Key Quest"
-- !pos 305.882 26.768 234.279 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("SahaginKeyItems") == 1 then -- If player was told to use 3 Mythril Beastcoins
        if npcUtil.tradeHasExactly(trade, {{tpz.items.MYTHRIL_BEASTCOIN, 3}, {tpz.items.NORG_SHELL, 1}}) then
            player:startEvent(107)
        end
    elseif (player:getCharVar("SahaginKeyItems") == 2) then -- If player was told to use a Gold Beastcoin
        if npcUtil.tradeHasExactly(trade, {tpz.items.GOLD_BEASTCOIN, tpz.items.NORG_SHELL}) then
            player:startEvent(107)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("SahaginKeyProgress") == 2 and not player:hasItem(tpz.items.SAHAGIN_KEY) then -- If player has never before finished the quest
        player:startEvent(105)
        player:setCharVar("SahaginKeyItems", 1)
    elseif player:getCharVar("SahaginKeyProgress") == 3 and player:getCharVar("SahaginKeyItems") == 0 and not player:hasItem(tpz.items.SAHAGIN_KEY) then
        player:startEvent(106) -- Requires Gold Beastcoin and a Norg Shell
        player:setCharVar("SahaginKeyItems", 2)
    elseif player:getCharVar("SahaginKeyProgress") == 3 and player:getCharVar("SahaginKeyItems") == 1 then
        player:startEvent(105) -- If player was told to use 3 Mythril Beastcoins
    elseif player:getCharVar("SahaginKeyProgress") == 3 and player:getCharVar("SahaginKeyItems") == 2 then
        player:startEvent(106) -- If player was told to use a Gold Beastcoin
    elseif player:getCharVar("SahaginKeyProgress") == 2 and player:hasItem(tpz.items.SAHAGIN_KEY) then
        player:startEvent(104) -- Doesn't offer the key again if the player has one
    else
        player:startEvent(104) -- Doesn't offer the key if the player hasn't spoken to the first 2 NPCs
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 107 and player:getCharVar("SahaginKeyProgress") == 2 and npcUtil.giveItem(player, tpz.items.SAHAGIN_KEY) then
        player:tradeComplete()
        player:setCharVar("SahaginKeyProgress", 3) -- Mark the quest progress
        player:setCharVar("SahaginKeyItems", 0)
    elseif csid == 107 and player:getCharVar("SahaginKeyProgress") == 3 and npcUtil.giveItem(player, tpz.items.SAHAGIN_KEY) then
        player:tradeComplete()
        player:setCharVar("SahaginKeyItems", 0)
    end
end
