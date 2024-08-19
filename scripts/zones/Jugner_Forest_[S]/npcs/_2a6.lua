-----------------------------------
-- Area: Jugner Forest [S]
-- Door: Gilded Doors (North)
-- !gotoid 17113883
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(104)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
