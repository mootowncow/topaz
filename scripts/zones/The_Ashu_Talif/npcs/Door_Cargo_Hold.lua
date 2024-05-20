-----------------------------------
-- Area: The Ashu Talif
-- Door: Cargo Hold
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function onTrigger(player, npc)
    local instance = player:getInstance()
    local faluuya = GetMobByID(ID.mob[56].FALUUYA, instance)
    faluuya:setLocalVar("escortStart", 1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
