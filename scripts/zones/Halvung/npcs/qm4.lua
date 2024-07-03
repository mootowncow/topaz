-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Achamoth(ZNM T3))
-- !pos -34 10 336 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2586) and npcUtil.popFromQM(player, npc, ID.mob.ACHAMOTH) then -- Rock Juice
        tpz.znm.onTrade(player, 2586)
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
