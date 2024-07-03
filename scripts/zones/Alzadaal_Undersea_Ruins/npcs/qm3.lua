-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Armed Gears(ZNM T3))
-- !pos -42 -4 -169 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2574) and npcUtil.popFromQM(player, npc, ID.mob.ARMED_GEARS) then -- Trade Ferrite
        tpz.znm.onTrade(player, 2574)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
