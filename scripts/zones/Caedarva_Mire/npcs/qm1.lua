-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Verdelet(ZNM T2))
-- !pos 417 -19 -69 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2599) and npcUtil.popFromQM(player, npc, ID.mob.VERDELET) then -- Mint Drop
        tpz.znm.onTrade(player, 2599)
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
