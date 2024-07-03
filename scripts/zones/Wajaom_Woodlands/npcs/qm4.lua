-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Tinnin(ZNM T4))
-- !pos 278 0 -703 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2573) and npcUtil.popFromQM(player, npc, ID.mob.TINNIN) then
        tpz.znm.onTrade(player, 2573)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.HEAVY_FRAGRANCE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
