-----------------------------------
--
-- Zone: Crawlers_Nest_[S] (171)
--
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
require("scripts/globals/wotg")
-----------------------------------

function onInitialize(zone)
    local normalCircleRadius = 10
    local largeCircleRadius = 20
    local extremelyLargeCircleRadius = 25
    zone:registerRegion(1, 61.583229, normalCircleRadius, 19.683287, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(2, 60.794937, normalCircleRadius, 97.207321, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(3, 41.173512, largeCircleRadius, 205.871521, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(4, 0.202141, largeCircleRadius, 277.989471, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(5, -85.401657, largeCircleRadius, 240.516739, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(6, -135.130219, normalCircleRadius, 218.389618, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(7, -102.547623, normalCircleRadius, 299.619873, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(8, -136.894577, extremelyLargeCircleRadius, 364.278198, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(9, -77.232605, largeCircleRadius, 81.779991, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(10, -18.022476, normalCircleRadius, 141.868866, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(11, 58.191879, normalCircleRadius, 260.211212, 0, 0, 0) -- Random event spawn circle
    zone:registerRegion(12, 46.562725, largeCircleRadius, 365.081757, 0, 0, 0) -- Random event spawn circle
end

function OnZoneTick(player, zone)
    local currentWave = zone:getLocalVar("wave")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventActive = zone:getLocalVar("eventActive", 1)
    local waveActive = zone:getLocalVar("waveActive")
    local events = {
        Waves = 1,
        Defense = 2,
        Boss = 3,
        Special = 4
    }

    tpz.wotg.progressCheck(player, zone)
     
    if (eventActive == events.Waves) and (waveActive == 0) then
        tpz.wotg.spawnWave(player, currentWave)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(380.617, -34.61, 4.581, 65)
    end
    return cs
end

function onRegionEnter(player, region)
    local regionID = region:GetRegionID()
    if (regionID >= 1 and regionID <= 12) then
        print("Player entered a random event region")
        local spawnChance = 10
        tpz.wotg.RandomEvent(player, spawnChance)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
