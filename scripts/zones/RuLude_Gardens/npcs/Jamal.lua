-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Jamal
-- Type: Alter Ego Points NPC
-- !pos -4.349 1 134.014 243
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
function onTrigger(player, npc)
    player:PrintToPlayer("Phew. When I agreed to get involved with the trust initiative, I didn't imagine it to be so...trying.",0,"Jamal")
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end