-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Marjory
-- Type: Alter Ego Points NPC
-- !pos -4.349 1 134.014 243
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
function onTrigger(player, npc)
    player:PrintToPlayer("Why I never! One with such a meager aura is not fit to be in my presence, let alone speak to me!",0,"Marjory")
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end