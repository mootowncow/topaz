-----------------------------------
--
-- Zone: Garlaige_Citadel_[S] (164)
--
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/wotg")
-----------------------------------

function onInitialize(zone)
    local normalCircleRadius = 10

    zone:registerRegion(1,  58.794773,  normalCircleRadius, -140.628220, 0, 0, 0)
    zone:registerRegion(2,  30.087503,  normalCircleRadius, -153.177536, 0, 0, 0)
    zone:registerRegion(3,  29.962498,  normalCircleRadius, -126.896446, 0, 0, 0)
    zone:registerRegion(4,   9.909133,  normalCircleRadius, -126.492340, 0, 0, 0)
    zone:registerRegion(5, -20.378864,  normalCircleRadius, -140.834900, 0, 0, 0)
    zone:registerRegion(6, -49.500500,  normalCircleRadius, -153.131256, 0, 0, 0)
    zone:registerRegion(7, -70.383171,  normalCircleRadius, -127.126274, 0, 0, 0)
    zone:registerRegion(8, -70.056992,  normalCircleRadius, -152.280029, 0, 0, 0)
    zone:registerRegion(9, -99.882011,  normalCircleRadius, -147.928497, 0, 0, 0)
    zone:registerRegion(10, -21.308405, normalCircleRadius, -171.071457, 0, 0, 0)
    zone:registerRegion(11,  60.257812, normalCircleRadius, -164.064896, 0, 0, 0)
    zone:registerRegion(12, 103.448601, normalCircleRadius, -173.367325, 0, 0, 0)
    zone:registerRegion(13,  99.114830, normalCircleRadius, -228.030304, 0, 0, 0)
    zone:registerRegion(14, 140.218506, normalCircleRadius, -180.047714, 0, 0, 0)
    zone:registerRegion(15, 180.767303, normalCircleRadius, -169.288254, 0, 0, 0)
    zone:registerRegion(16, 219.672638, normalCircleRadius, -100.862419, 0, 0, 0) -- Furnace / Explosure room
    zone:registerRegion(17, 209.793427, normalCircleRadius, -166.915329, 0, 0, 0)
    zone:registerRegion(18, 209.392746, normalCircleRadius, -194.039215, 0, 0, 0)
    zone:registerRegion(19, 230.082565, normalCircleRadius, -165.412018, 0, 0, 0)
    zone:registerRegion(20, 229.962036, normalCircleRadius, -195.152374, 0, 0, 0)
    zone:registerRegion(21, 258.861816, normalCircleRadius, -212.553482, 0, 0, 0)

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
        player:setPos(-300, -13.548, 157, 64)
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
