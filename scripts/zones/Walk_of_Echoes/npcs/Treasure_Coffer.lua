-----------------------------------
-- Area: Walk of Echoes
-- NPC:  Treasure Coffer (Walk rewards completion chest)
-- !gotoid 17523269
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/status")
require("scripts/globals/walk_of_echoes")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.woe.TreasureCoffer.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.woe.TreasureCoffer.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end