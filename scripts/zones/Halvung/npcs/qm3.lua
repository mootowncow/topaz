-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Reacton(ZNM T2))
-- !pos 18 -9 213 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2588) and npcUtil.popFromQM(player, npc, ID.mob.REACTON) then -- Bone Charcoal
        tpz.znm.onTrade(player, 2588)
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
