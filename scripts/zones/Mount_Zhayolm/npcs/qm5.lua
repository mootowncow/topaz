-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Sarameya(ZNM T4))
-- !pos 322 -14 -581 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2583) and npcUtil.popFromQM(player, npc, ID.mob.SARAMEYA) then -- Buffalo Corpse
        tpz.znm.onTrade(player, 2583)
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
