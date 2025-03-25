-----------------------------------
--
-- Zone: Rolanberry_Fields_[S] (91)
--
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
require("scripts/globals/voidwalker")
-----------------------------------

function onInitialize(zone)
    local circleRadius = 15
    zone:registerRegion(1, -44.526684, circleRadius, 337.972321, 0, 0, 0)
    zone:registerRegion(2, 1.749000, circleRadius, 240.000000, 0, 0, 0)
    zone:registerRegion(3, 226.945999, circleRadius, 287.264008, 0, 0, 0)
    zone:registerRegion(4, 459, circleRadius, -77, 0, 0, 0)

    tpz.voidwalker.zoneOnInit(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-376.179, -30.387, -776.159, 220)
    end
    return cs
end

function onRegionEnter(player, region)
    local RegionID = region:GetRegionID()

    -- Map RegionID to Gate NPC ID
    local gates = {
        [1] = 17150730,
        [2] = 17150731,
        [3] = 17150732,
        [4] = 17150733,
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
end
