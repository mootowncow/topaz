-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Chigre(ZNM T1))
-- !pos -217 35 12 68
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2602) and npcUtil.popFromQM(player, npc, ID.mob.CHIGRE) then
        tpz.znm.onTrade(player, 2602)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BLOOD_STAINS)
end
