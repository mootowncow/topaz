-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Verdical Conflux #09
-- !gotoid 17523238
-----------------------------------
require("scripts/globals/walk_of_echoes")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.woe.veridicalConflux.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.woe.veridicalConflux.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.woe.veridicalConflux.onEventFinish(player, csid, option)
end
