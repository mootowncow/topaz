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

    zone:registerRegion(1, 261.084900, normalCircleRadius, 20.264042, 0, 0, 0)
    zone:registerRegion(2, 298.680389, normalCircleRadius, 60.110912, 0, 0, 0)
    zone:registerRegion(3, 299.859222, normalCircleRadius, -19.702612, 0, 0, 0)
    zone:registerRegion(4, 178.913330, normalCircleRadius, 20.043570, 0, 0, 0)
    zone:registerRegion(5, 62.156502, normalCircleRadius, 18.830523, 0, 0, 0)
    zone:registerRegion(6, 0.492411, normalCircleRadius, 39.821842, 0, 0, 0)
    zone:registerRegion(7, 97.677650, normalCircleRadius, 137.734787, 0, 0, 0)
    zone:registerRegion(8, 101.436592, normalCircleRadius, 221.895096, 0, 0, 0)
    zone:registerRegion(9, 179.810715, normalCircleRadius, 138.718307, 0, 0, 0)
    zone:registerRegion(10, 37.519516, largeCircleRadius, 319.214478, 0, 0, 0)
    zone:registerRegion(11, 255.439651, normalCircleRadius, 260.035583, 0, 0, 0)
    zone:registerRegion(12, 418.432220, extremelyLargeCircleRadius, 132.688217, 0, 0, 0)
    zone:registerRegion(13, 341.541595, normalCircleRadius, 19.540817, 0, 0, 0)
    zone:registerRegion(14, 300.377441, normalCircleRadius, 20.257357, 0, 0, 0)

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
