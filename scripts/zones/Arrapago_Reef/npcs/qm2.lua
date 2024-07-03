-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Velionis(ZNM T1))
-- !pos 311 -3 27 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2600) and npcUtil.popFromQM(player, npc, ID.mob.VELIONIS) then
        tpz.znm.onTrade(player, 2600)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.GLITTERING_FRAGMENTS)
end
