-----------------------------------
-- Area: Castle Oztroja [S]
--  NPC: _2r4 (Brass Door)
-- Notes: Entrance
-- !gotoid 17183511
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
local CASTLE_OZTROJA_S = require("scripts/zones/Castle_Oztroja_[S]/globals")
-----------------------------------
function onTrigger(player, npc)
    CASTLE_OZTROJA_S.handleDoor(player, npc, function(a,b) return a <= b end, -205, player:getXPos())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
