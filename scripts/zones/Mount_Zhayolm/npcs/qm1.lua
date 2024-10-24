-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Brass Borer(ZNM T1))
-- !pos 399 -27 120 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2590) and npcUtil.popFromQM(player, npc, ID.mob.BRASS_BORER) then
        tpz.znm.onTrade(player, 2590)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SHED_LEAVES)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
