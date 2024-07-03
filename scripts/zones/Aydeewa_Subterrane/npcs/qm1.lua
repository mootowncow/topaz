-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Nosferatu(ZNM T3))
-- !pos -199 8 -62 68
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2584) and npcUtil.popFromQM(player, npc, ID.mob.NOSFERATU) then -- Pure Blood
        tpz.znm.onTrade(player, 2584)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
