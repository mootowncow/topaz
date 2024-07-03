-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Khromasoul Bhurborlor(ZNM T3))
-- !pos 88 -22 70 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/znm")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2585) and npcUtil.popFromQM(player, npc, ID.mob.KHROMASOUL_BHURBORLOR, {hide = 0}) then -- Vinegar Pie
        tpz.znm.onTrade(player, 2585)
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
