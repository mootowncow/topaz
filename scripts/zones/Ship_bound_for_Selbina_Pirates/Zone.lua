-----------------------------------
--
-- Zone: Ship bound for Selbina Pirates (227)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Selbina_Pirates/IDs")
require("scripts/globals/zone")
require("scripts/globals/pirates")
require("scripts/globals/sea_creatures")
require("scripts/globals/keyitems")
-----------------------------------
function onInitialize(zone)

    tpz.pirates.init(ID)

    zone:addListener("TRANSPORTZONE_END", "SELBINA_PIRATES_TRANSPORTZONE_END", function(transportZone)
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        if GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
            DespawnMob(ID.mob.ENAGAKURE)
        end
        tpz.sea_creatures.despawn(ID)
    end)

    zone:addListener("TRANSPORTZONE_START", "SELBINA_PIRATES_TRANSPORTZONE_START", function(transportZone)
        tpz.pirates.start(ID)
        tpz.sea_creatures.checkSpawns(ID, 5, 1) -- 5 percent on init
    end)

    zone:addListener("TRANSPORTZONE_UPDATE", "SELBINA_PIRATES_TRANSPORTZONE_UPDATE", function(transportZone, tripTime)
        tpz.pirates.update(ID, transportZone, tripTime)
        tpz.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    return cs
end

function onGameHour(zone)
    local hour = VanadielHour()
    if hour >= 20 or hour < 4 then
        -- Check for Enagakure
        local players = zone:getPlayers()
        for _, player in pairs(players) do
            if player:hasKeyItem(tpz.ki.SEANCE_STAFF)
                and player:getVar("Enagakure_Killed") == 0
                and not GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
                    GetMobByID(ID.mob.ENAGAKURE):spawn()
            end
        end
        if math.random() < 0.20 and not GetMobByID(ID.mob.PHANTOM):isSpawned() then
            GetMobByID(ID.mob.PHANTOM):spawn()
        end
    else
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        if GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
            DespawnMob(ID.mob.ENAGAKURE)
        end
    end
end

function onTransportEvent(player, transport)
    player:startEvent(255)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, tpz.zone.SELBINA)
    end
end
