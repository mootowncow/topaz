-----------------------------------
--
-- Zone: Lufaise_Meadows (24)
--
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable("realPadfoot", math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        SpawnMob(v)
    end

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-475.825, -20.461, 281.149, 11)
    end

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.AN_INVITATION_WEST and player:getCharVar("PromathiaStatus") == 0) then
        cs = 110
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus") == 0) then
        cs = 111
    elseif
        prevZone == tpz.zone.VALKURM_DUNES and
        player:getCharVar("ChasingDreams") == 13
    then
        cs = 4
    end
    return cs
end

function afterZoneIn(player)
    local day = VanadielDayOfTheWeek()
    if (day == tpz.day.WATERSDAY) then
        for v = 16875921, 16875930 do
            if not GetMobByID(v):isSpawned() then
                GetMobByID(v):spawn()
            end
        end
    end
end

function onRegionEnter(player, region)
    local regionID = region:GetRegionID()

    if (regionID == 1 and player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 6) then
        player:startEvent(116)
     end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 110) then
        player:messageSpecial(ID.text.KI_STOLEN, 0, tpz.ki.MYSTERIOUS_AMULET)
        player:delKeyItem(tpz.ki.MYSTERIOUS_AMULET)
        player:setCharVar("PromathiaStatus", 1)
    elseif (csid == 111 and npcUtil.giveItem(player, 14657)) then
        player:setCharVar("PromathiaStatus", 1)
    elseif (csid == 116) then
        player:setCharVar("PromathiaStatus", 7)
        player:addTitle(tpz.title.BANISHER_OF_EMPTINESS)
    elseif (csid == 4) then
         player:setCharVar("ChasingDreams", 14)
    end
end
