-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Type: Standard Merchant
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    local AstralCovenantTimer = player:getCharVar("[ENM]AstralCovenantTimer")
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP) ~= QUEST_COMPLETED and npcUtil.tradeHas(trade, 548) then
        -- Finish Quest: Tenshodo Membership (Invitation)
        player:startEvent(108)
    elseif
        player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED and
        not player:hasKeyItem(tpz.ki.PSOXJA_PASS) and
        player:getCharVar("PXPassGetGems") == 1 and
        (
            npcUtil.tradeHas(trade, 1692) or
            npcUtil.tradeHas(trade, 1694) or
            npcUtil.tradeHas(trade, 1693)
        )
    then
        player:startEvent(52, 500 * GIL_RATE)
    end
    if npcUtil.tradeHas(trade, 1782) then -- Florid Stone for Test Your Mite ENM
        if player:hasKeyItem(tpz.ki.ASTRAL_COVENANT) then
            player:PrintToPlayer("You're already in the possession of an Astral Covenant.",0,"Ghebi Damomohe")
        elseif os.time() >= AstralCovenantTimer and not player:hasKeyItem(tpz.ki.ASTRAL_COVENANT) then
            player:confirmTrade()
            player:PrintToPlayer("This stone... there's something inside of it!",0,"Ghebi Damomohe")
            player:addKeyItem(tpz.ki.ASTRAL_COVENANT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ASTRAL_COVENANT)
            player:setCharVar("[ENM]AstralCovenantTimer", os.time() + 432000) -- 5 days
            player:PrintToPlayer("Take this down to the deepest scariest parts of Pso\'Xja.",0,"Ghebi Damomohe")
            player:PrintToPlayer("Please come back safely...",0,"Ghebi Damomohe")
        else
            player:PrintToPlayer("You must wait until the next day for another Astral Covenant.",0,"Ghebi Damomohe")
        end
    end
end

function onTrigger(player, npc)
    local GetGems = player:getCharVar("PXPassGetGems")
    local takeAstralToPsoxja = player:getLocalVar("takeAstralToPsoxja")

    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP) == QUEST_AVAILABLE then
        -- Start Quest: Tenshodo Membership
        player:startEvent(106, 8)
    elseif player:hasKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM) then
        -- Finish Quest: Tenshodo Membership
        player:startEvent(107)
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED and not player:hasKeyItem(tpz.ki.PSOXJA_PASS) and GetGems == 0 then
        -- Mission: Darkness Named
        player:startEvent(54)
    elseif (GetGems == 1) then
        player:startEvent(53)
    elseif player:hasKeyItem(tpz.ki.ASTRAL_COVENANT) and (takeAstralToPsoxja == 0) then
        player:PrintToPlayer("What are you waiting for? Take that Astral Covenant to Pso\'Xja!",0,"Ghebi Damomohe")
        player:setLocalVar("takeAstralToPsoxja", 1)
    else
        player:startEvent(106, 4)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local AstralCovenantTimer = player:getCharVar("[ENM]AstralCovenantTimer")
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144,    -- Rice Ball
            4457, 2700,    -- Eel Kabob
            4467,    3,    -- Garlic Cracker
        }

        tpz.shop.general(player, stock, NORG)
    elseif csid == 106 and option == 2 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP)
    elseif csid == 107 then
        -- Finish Quest: Tenshodo Membership (Application Form)
        if npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item=548, title=tpz.title.TENSHODO_MEMBER, ki=tpz.ki.TENSHODO_MEMBERS_CARD }) then
            player:delKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM)
        end
    elseif csid == 108 then
        -- Finish Quest: Tenshodo Membership (Invitation)
        if npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item=548, title=tpz.title.TENSHODO_MEMBER, ki=tpz.ki.TENSHODO_MEMBERS_CARD }) then
            player:confirmTrade()
            player:delKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM)
        end
    elseif csid == 52 then
        player:confirmTrade()
        player:addGil(500 * GIL_RATE)
        player:addKeyItem(tpz.ki.PSOXJA_PASS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PSOXJA_PASS)
        player:setCharVar("PXPassGetGems", 0)
    elseif csid == 54 then
        player:setCharVar("PXPassGetGems", 1)
    end
end
