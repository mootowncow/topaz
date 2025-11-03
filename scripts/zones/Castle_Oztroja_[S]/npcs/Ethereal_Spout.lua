-----------------------------------
-- Area: Castle_Oztroja [S]
-- A Malicious Manifest BCNM Exit
-- !gotoid 17183547
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/bcnm")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(32003)
end


function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end
end