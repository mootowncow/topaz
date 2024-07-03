-----------------------------------
-- Area: Mamook
--  NPC: ??? (Spawn Chamrosh(ZNM T1))
-- !pos 206 14 -285 65
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2581) and npcUtil.popFromQM(player, npc, ID.mob.CHAMROSH) then
        tpz.znm.onTrade(player, 2581)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SICKLY_SWEET)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
