-----------------------------------
-- Area: Castle Oztroja [S]
--  NPC: _2rx (Handle)
-- Notes: Opens Brass Door
-- !gotoid 17183557
-----------------------------------
local CASTLE_OZTROJA_S = require("scripts/zones/Castle_Oztroja_[S]/globals")

function onTrigger(player, npc)
    CASTLE_OZTROJA_S.handleLevers(npc)
end
