-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Anantaboga(ZNM T2))
-- !pos -368 -13 366 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2587) and npcUtil.popFromQM(player, npc, ID.mob.ANANTABOGA, {hide = 0}) then -- Raw Buffalo
        tpz.znm.onTrade(player, 2587)
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
