-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Claret(ZNM T1))
-- !pos 497 -9 52 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2591) and npcUtil.popFromQM(player, npc, ID.mob.CLARET) then
        tpz.znm.onTrade(player, 2591)
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
