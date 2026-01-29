-----------------------------------
-- Area: Castle Oztroja [S]
--  NPC: Brass Door)
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
local CASTLE_OZTROJA_S = require("scripts/zones/Castle_Oztroja_[S]/globals")
-----------------------------------
function onTrigger(player, npc)
    CASTLE_OZTROJA_S.handleDoor(player, npc, function(a,b) return a <= b end, -43, player:getXPos())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
