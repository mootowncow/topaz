-----------------------------------
--
-- Zone: VeLugannon_Palace (177)
--
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)

    -- Place Curtana at a random ??? on initialize
    local randpos = math.random(1, 8)
    local curtana = GetNPCByID(17502581)

    switch (randpos): caseof
    {
        [1] = function (x) curtana:setPos(-370.039, 16.014, -274.378); end,
        [2] = function (x) curtana:setPos(-389, 16, -274); end,
        [3] = function (x) curtana:setPos(-434, 16, -229); end,
        [4] = function (x) curtana:setPos(-434, 16, -210); end,
        [5] = function (x) curtana:setPos(434, 13, -210); end,
        [6] = function (x) curtana:setPos(434, 16, -230); end,
        [7] = function (x) curtana:setPos(390, 16, -194); end,
        [8] = function (x) curtana:setPos(370, 16, -194); end,
    }
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
        player:setPos(-100.01, -25.752, -399.468, 59)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
