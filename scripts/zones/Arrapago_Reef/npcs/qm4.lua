-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Nuhn(ZNM T3))
-- !pos -451 -7 389 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2596) and npcUtil.popFromQM(player, npc, ID.mob.NUHN) then -- Trade Rose Scampi
        tpz.znm.onTrade(player, 2596)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
