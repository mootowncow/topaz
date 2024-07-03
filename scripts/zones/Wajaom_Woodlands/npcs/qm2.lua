-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Iriz Ima(ZNM T2))
-- !pos 253 -23 116 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2577) and npcUtil.popFromQM(player, npc, ID.mob.IRIZ_IMA) then
        tpz.znm.onTrade(player, 2577)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.PAMAMA_PEELS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
