-----------------------------------
--
-- Zone: Sauromugue_Champaign_[S] (98)
--
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/zone")
require("scripts/globals/voidwalker")
-----------------------------------

function onInitialize(zone)
    local circleRadius = 15
    zone:registerRegion(1, -358.799011, circleRadius, 334.000000, 0, 0, 0) -- TODO
    zone:registerRegion(2, 39.999001, circleRadius, 180.000000, 0, 0, 0)
    zone:registerRegion(3, -49.300632, circleRadius, -48.092354, 0, 0, 0)

    UpdateNMSpawnPoint(ID.mob.COQUECIGRUE)
    GetMobByID(ID.mob.COQUECIGRUE):setRespawnTime(math.random(7200, 7800))
    tpz.voidwalker.zoneOnInit(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-104, -25.36, -410, 195)
    end
    if (prevZone == tpz.zone.ROLANBERRY_FIELDS_S and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and player:getCharVar("DownwardHelix") == 2) then
        cs = 3
    end
    return cs
end

function onRegionEnter(player, region)
    local RegionID = region:GetRegionID()

    -- Map RegionID to Gate NPC ID
    local gates = {
        [1] = 17179322,
        [2] = 17179323,
        [3] = 17179324,
    }

    -- Get the corresponding gate for the region the player entered
    local gateId = gates[RegionID]

    if gateId then
        local gate = GetNPCByID(gateId)
        if gate and (gate:getAnimation() == tpz.anim.CLOSE_DOOR) then
            gate:setAnimation(tpz.anim.OPEN_DOOR)
            gate:timer(1000 * 30, function(gate) -- Stay open for 30s
                gate:setAnimation(tpz.anim.CLOSE_DOOR)
            end)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 3) then
        player:setCharVar("DownwardHelix", 3)
    end
end
