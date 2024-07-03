-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Tyger(ZNM T4))
-- !pos -766 -12 632 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2593) and npcUtil.popFromQM(player, npc, ID.mob.TYGER) then -- Singed Buffalo
        tpz.znm.onTrade(player, 2593)
        player:messageSpecial(ID.text.OMINOUS_PRESENCE)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.HEADY_FRAGRANCE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
