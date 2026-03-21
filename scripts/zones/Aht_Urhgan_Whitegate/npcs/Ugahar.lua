-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ugahar
-- Standard Info NPC
-- !pos 87 -0 45 50
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    return player:startEvent(253)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
