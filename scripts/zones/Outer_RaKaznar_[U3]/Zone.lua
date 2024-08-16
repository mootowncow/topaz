-----------------------------------
--
-- Zone: Outer Ra’Kanzar [U3] (189)
--
-- https://github.com/LandSandBoat/server/commit/02fc13f946ddd81f732f14121c0c94506f4f3a94
-----------------------------------
local ID = require("scripts/zones/Outer_RaKaznar_[U3]/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-40, -180, -20, 128)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
