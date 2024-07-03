-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Wulgaru(ZNM T2))
-- !pos -22 -4 204 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2597) and npcUtil.popFromQM(player, npc, ID.mob.WULGARU) then -- Trade Opalus Gem
        tpz.znm.onTrade(player, 2597)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
