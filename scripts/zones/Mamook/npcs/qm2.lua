-----------------------------------
-- Area: Mamook
--  NPC: ??? (Spawn Iriri Samariri(ZNM T2))
-- !pos -118 7 -80 65
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2579) and npcUtil.popFromQM(player, npc, ID.mob.IRIRI_SAMARIRI) then -- Trade Samariri Corpsehair
        tpz.znm.onTrade(player, 2579)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
