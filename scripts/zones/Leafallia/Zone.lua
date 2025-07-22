-----------------------------------
--
-- Zone: Leafallia
--
-----------------------------------
local ID = require("scripts/zones/Leafallia/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-1, 0, 0, 151)
    end

    if (player:getCharVar("sirenDefeated") == 1) then
        player:queue(5000, function(player)
            player:addSpell(355)
            player:messageSpecial(ID.text.UNLOCK_SIREN)
            player:setCharVar("sirenDefeated", 0)
        end)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
