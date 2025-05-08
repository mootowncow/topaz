-----------------------------------
--
-- Zone: The_Eldieme_Necropolis_[S] (175)
--
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/wotg")
-----------------------------------

function onInitialize(zone)
local normalCircleRadius = 10
local largeCircleRadius = 20
local extremelyLargeCircleRadius = 25

zone:registerRegion(1, 300.377014, -0.250000, largeCircleRadius, 0, 0, 0)
zone:registerRegion(2, 261.084900, -1.250000, normalCircleRadius, 0, 0, 0)
zone:registerRegion(3, 298.680389, -0.000004, normalCircleRadius, 0, 0, 0)
zone:registerRegion(4, 299.859222, -0.000004, normalCircleRadius, 0, 0, 0)
zone:registerRegion(5, 178.913330, -8.500000, normalCircleRadius, 0, 0, 0)
zone:registerRegion(6, 62.156502, -0.250000, normalCircleRadius, 0, 0, 0)
zone:registerRegion(7, 0.492411, 1.000000, largeCircleRadius, 0, 0, 0)
zone:registerRegion(8, 97.677650, -7.188785, normalCircleRadius, 0, 0, 0)
zone:registerRegion(9, 101.436592, -15.168465, normalCircleRadius, 0, 0, 0)
zone:registerRegion(10, 179.810715, -0.250000, normalCircleRadius, 0, 0, 0)
zone:registerRegion(11, 37.519516, -15.000000, largeCircleRadius, 0, 0, 0)
zone:registerRegion(12, 255.439651, -23.381905, normalCircleRadius, 0, 0, 0)
zone:registerRegion(13, 418.432220, 0.546957, extremelyLargeCircleRadius, 0, 0, 0)
zone:registerRegion(14, 341.541595, -1.250000, normalCircleRadius, 0, 0, 0)
zone:registerRegion(15, 300.377441, -0.250000, normalCircleRadius, 0, 0, 0)

tpz.wotg.onInitialize(zone)
end

function OnZoneTick(player, zone, region)
    local currentWave = zone:getLocalVar("wave")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventActive = zone:getLocalVar("eventActive", 1)
    local waveActive = zone:getLocalVar("waveActive")

    if (eventActive == tpz.wotg.events.Waves) and (waveActive == 0) then
        tpz.wotg.spawnWave(player, currentWave)
    end

    tpz.wotg.onZoneTick(player, zone, region)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(420.035, -58.114, -119.51, 191)
    end
    return cs
end

function onRegionEnter(player, region)
    tpz.wotg.onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
