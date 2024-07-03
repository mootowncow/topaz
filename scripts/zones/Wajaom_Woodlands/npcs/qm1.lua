-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Vulpangue(ZNM T1))
-- !pos -697 -7 -123 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2580) and npcUtil.popFromQM(player, npc, ID.mob.VULPANGUE) then
        tpz.znm.onTrade(player, 2580)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BROKEN_SHARDS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
