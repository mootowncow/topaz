-----------------------------------
--
-- Zone: Caedarva_Mire (79)
--
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    -- Lamian Fang Key Marsh
    zone:registerRegion(1, 134, 6, -184, 0, 0, 0)
    zone:registerRegion(2, 149, 6, -180, 0, 0, 0)
    zone:registerRegion(3, 140, 6, -170, 0, 0, 0)
    zone:registerRegion(4, 145, 6, -180, 0, 0, 0) 
    -- Karakul Marsh 
    zone:registerRegion(5, 299, 14, -341, 0, 0, 0) -- North(By Key ???)
    zone:registerRegion(6, 302, 14, -377, 0, 0, 0) -- Middle Pond(By Jnun)
    --Jnun/Imp/Fly Marsh 
    zone:registerRegion(7, 452, 6, -302, 0, 0, 0)
    zone:registerRegion(8, 457, 6, -308, 0, 0, 0)
    zone:registerRegion(9, 469, 6, -301, 0, 0, 0)
    zone:registerRegion(10, 458, 6, -339, 0, 0, 0)

    UpdateNMSpawnPoint(ID.mob.AYNU_KAYSEY)

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(339.996, 2.5, -721.286, 200)
    end
    if prevZone == tpz.zone.LEUJAOAM_SANCTUM then
        player:setPos(495.450, -28.25, -478.43, 32)
    end
    if prevZone == tpz.zone.PERIQIA then
        player:setPos(-252.715, -7.666, -30.64, 128)
    end

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SHADES_OF_VENGEANCE and player:getCharVar("AhtUrganStatus") == 1) then
        cs = 21
    end

    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
    player:entityVisualPacket("1pd1")
    player:entityVisualPacket("2pc1")
end

function onRegionEnter(player, region)
    local stauseffects =
    {
        [1] = tpz.effect.QUICKENING, 25, 0, 180,
        [2] = tpz.effect.FLEE, 100, 0, 180,
        [3] = tpz.effect.STONESKIN, 350, 0, 180,
        [4] = tpz.effect.HASTE, 1465, 0, 180,
        [5] = tpz.effect.SLOW, 2550, 0, 180,
    }
    local Zikko = GetMobByID(17101144)
    local Respawn = GetServerVariable("Zikko_Respawn")
    local RNG = math.random(100)
    local BuffRoll = math.random(100)
    local RegionID = region:GetRegionID()
    local tick = player:getLocalVar("Caedarva_Mire_Swamp_Tick")
    
    if (RegionID <= 10 and not player:hasStatusEffect(tpz.effect.MOUNTED) and os.time() >= tick) then
        printf("Entered Region")
        player:setLocalVar("Caedarva_Mire_Swamp_Tick", os.time() + 5)
        if RNG < 50 then
            --printf("%u", RNG)
            --printf("Apply Weight")
            player:addStatusEffect(tpz.effect.WEIGHT, 50, 0, 180)
        elseif RNG < 75 then
            --printf("Apply Random Status from Table")
            if BuffRoll < 20 then
                player:addStatusEffect(tpz.effect.QUICKENING, 25, 0, 30)
            elseif BuffRoll < 40 then
                player:addStatusEffect(tpz.effect.FLEE, 100, 0, 30)
            elseif BuffRoll < 60 then
                player:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 180)
            elseif BuffRoll < 80 then
                player:addStatusEffect(tpz.effect.HASTE, 1465, 0, 180)
            elseif BuffRoll < 90 then
                player:addStatusEffect(tpz.effect.SLOW, 10000, 0, 180)
            end
        elseif RNG < 95 and Respawn <= os.time() then
            --printf("Spawn Zikko")
            Zikko:setSpawn(player:getXPos() + math.random(1, 3), player:getYPos(), player:getZPos() + math.random(1, 3))
            SpawnMob(ID.mob.ZIKKO):updateClaim(player)
            SetServerVariable("Zikko_Respawn", os.time() + 7200)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 21 then
        player:completeMission(TOAU, tpz.mission.id.toau.SHADES_OF_VENGEANCE)
        player:setCharVar("AhtUrganStatus", 0)
        player:setCharVar("TOAUM31_PERMITDAY", 0)
        player:setTitle(tpz.title.NASHMEIRAS_MERCENARY)
        player:addMission(TOAU, tpz.mission.id.toau.IN_THE_BLOOD)
    elseif csid == 133 then -- enter instance, warp to periqia
        player:setPos(0, 0, 0, 0, 56)
    elseif csid == 130 then
        player:setPos(0, 0, 0, 0, 69)
    end
end
