-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Lil'Apkallu(ZNM T1))
-- !pos 488 -1 166 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2601) and npcUtil.popFromQM(player, npc, ID.mob.LIL_APKALLU) then
        tpz.znm.onTrade(player, 2601)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SLIMY_TOUCH)
end
