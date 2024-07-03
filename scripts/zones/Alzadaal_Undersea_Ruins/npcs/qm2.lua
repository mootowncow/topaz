-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Cheese Hoarder Gigiroon(ZNM T1))
-- !pos -184 -8 24 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2582) and npcUtil.popFromQM(player, npc, ID.mob.CHEESE_HOARDER_GIGIROON) then
        tpz.znm.onTrade(player, 2582)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.HEADY_FRAGRANCE)
end
