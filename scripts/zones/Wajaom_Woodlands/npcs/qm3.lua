-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Gotoh Zha the Redolent(ZNM T3))
-- !pos -337 -31 676 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2575) and npcUtil.popFromQM(player, npc, ID.mob.GOTOH_ZHA_THE_REDOLENT) then
        tpz.znm.onTrade(player, 2575)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.INSECT_WINGS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
