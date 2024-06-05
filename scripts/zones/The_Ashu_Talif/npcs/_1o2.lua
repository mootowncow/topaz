-----------------------------------
-- Area: The Ashu Talif
-- Gate: Gate: Lifeboat (_1o2)
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/appraisal")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 and option == 1 then
        player:startEvent(102)
    elseif csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end
