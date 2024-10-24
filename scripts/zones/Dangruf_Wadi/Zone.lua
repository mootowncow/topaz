-----------------------------------
--
-- Zone: Dangruf_Wadi (191)
--
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/treasure")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -133.1, 2.6, 133.2, 0, 0, 0)  -- I-8 Geyser
    zone:registerRegion(2, -213.3, 2.9, 93.4, 0, 0, 0)  -- H-8 Geyser
    zone:registerRegion(3, -66.7, 2.9, 533.4,  0, 0, 0)  -- J-3 Geyser

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-4.025, -4.449, 0.016, 112)
    end
    return cs
end

function onRegionEnter(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)
            player:setPos(-133.19, 2.66, 133.20)
            player:startEvent(10)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET, "kkj2")
        end,
        [2] = function (x)
            player:setPos(-213.3, 2.9, 93.4)
            player:startEvent(11)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET + 1, "kkj1")
        end,
        [3] = function (x)
        player:setPos(-66.7, 2.9, 533)
            player:startEvent(12)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET + 2, "kkj3")
        end,
    }
    if (player:hasKeyItem(tpz.ki.BLUE_ACIDITY_TESTER)) then
        player:delKeyItem(tpz.ki.BLUE_ACIDITY_TESTER)
        player:addKeyItem(tpz.ki.RED_ACIDITY_TESTER)
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour(zone)
    local nm = GetMobByID(ID.mob.GEYSER_LIZARD)
    local pop = nm:getLocalVar("pop")
    if (os.time() > pop and not nm:isSpawned()) then
        UpdateNMSpawnPoint(ID.mob.GEYSER_LIZARD)
        nm:spawn()
    end
end

function onZoneWeatherChange(weather)
    if (weather == tpz.weather.NONE or weather == tpz.weather.SUNSHINE) then
        GetNPCByID(ID.npc.AN_EMPTY_VESSEL_QM):setStatus(tpz.status.NORMAL)
    else
        GetNPCByID(ID.npc.AN_EMPTY_VESSEL_QM):setStatus(tpz.status.DISAPPEAR)
    end
end
