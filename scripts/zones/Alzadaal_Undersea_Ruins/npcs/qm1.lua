-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Ob(ZNM T1))
-- !pos 542 0 -129 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2592) and npcUtil.popFromQM(player, npc, ID.mob.OB) then
        tpz.znm.onTrade(player, 2592)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SLIMY_TOUCH)
end
