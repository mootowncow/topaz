-----------------------------------
-- Area: Castle Oztroja [S]
-- Lever for a Brass Door
-----------------------------------
local CASTLE_OZTROJA_S = require("scripts/zones/Castle_Oztroja_[S]/globals")

function onTrigger(player, npc)
    CASTLE_OZTROJA_S.handleLevers(npc)
end
