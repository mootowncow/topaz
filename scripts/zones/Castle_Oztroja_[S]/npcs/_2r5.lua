-----------------------------------
-- Area:  Castle Oztroja [S]
-- NPC:   _2r5 (Handle)
-- Notes: Opens door _2r4
-- !gotoid 17183512
-----------------------------------
local CASTLE_OZTROJA_S = require("scripts/zones/Castle_Oztroja_[S]/globals")

function onTrigger(player, npc)
    CASTLE_OZTROJA_S.handleLevers(npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
