-----------------------------------
-- Area: Riverne Site #A01
--  NPC: qm1
-- Gives Shield Bug for Shieldtrap NM
-----------------------------------
local RIVERNE_SITE_A01 = require("scripts/zones/Riverne-Site_A01/globals")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
	if npcUtil.giveItem(player, 1881) then
        RIVERNE_SITE_A01.moveShieldBug()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
